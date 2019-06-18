use std::collections::HashMap;

use cargo::{
    core::{
        registry::PackageRegistry, resolver::Method, source::SourceId, GitReference, PackageId,
        Workspace,
    },
    ops::{get_resolved_packages, resolve_with_previous},
    util::config::Config,
};
use failure::Error;
use serde::Serialize;

use crate::codegen::{
    Dependency as LockedDependency, GitReference as LockedGitReference, Package as LockedPackage,
    PackageId as LockedPackageId, SourceInfo,
};
use crate::serializer::Serializer;

fn source_id_to_string(id: SourceId) -> Option<String> {
    if id.is_path() {
        None
    } else if id.is_git() {
        Some(format!("git+{}", id.url()))
    } else {
        Some(id.to_url().to_string())
    }
}

fn dep_to_pkg_id(id: PackageId) -> String {
    match source_id_to_string(id.source_id()) {
        Some(source) => format!("{} {} ({})", id.name(), id.version(), source),
        None => format!("{} {}", id.name(), id.version()),
    }
}

pub fn generate_lockfile<'a>(
    config: &'a Config,
    ws: &Workspace<'a>,
) -> Result<(Vec<LockedPackage>, Vec<LockedPackageId>), Error> {
    let mut registry = PackageRegistry::new(config)?;
    let resolve = resolve_with_previous(
        &mut registry,
        ws,
        Method::Everything,
        None,
        None,
        &[],
        true,
        true,
    )?;
    let packages = get_resolved_packages(&resolve, registry)?;
    let packages = {
        let mut pkgs = HashMap::new();
        for pkg in packages.get_many(packages.package_ids())? {
            pkgs.insert(pkg.package_id(), pkg.clone());
        }
        pkgs
    };
    let packages: Vec<_> = packages
        .values()
        .map(|pkg| {
            let id = pkg.package_id();
            let source_id = id.source_id();
            let dependencies = resolve
                .deps(id)
                .filter_map(|(dep_id, deps)| {
                    let toml_names = deps
                        .into_iter()
                        .map(|dep| dep.name_in_toml().to_string())
                        .collect();
                    packages
                        .get(&dep_id)
                        .and_then(|dep| dep.targets().iter().find(|t| t.is_lib()))
                        .and_then(|lib| {
                            resolve
                                .extern_crate_name(id, dep_id, lib)
                                .ok()
                                .map(|extern_name| LockedDependency {
                                    toml_names: toml_names,
                                    extern_name,
                                    package_id: dep_to_pkg_id(dep_id),
                                })
                        })
                })
                .collect();
            let source_info = if source_id.is_git() {
                let git_ref = source_id.git_reference().expect("expecting git reference");
                SourceInfo::Git {
                    url: source_id.url().to_string(),
                    git_ref: match git_ref {
                        GitReference::Branch(branch) => LockedGitReference::Branch(branch.clone()),
                        GitReference::Rev(rev) => LockedGitReference::Rev(rev.clone()),
                        GitReference::Tag(tag) => LockedGitReference::Tag(tag.clone()),
                    },
                }
            } else if source_id.is_registry() {
                SourceInfo::Registry {
                    index: source_id.to_url().to_string(),
                    checksum: resolve
                        .checksums()
                        .get(&id)
                        .and_then(|x| x.as_ref())
                        .map(String::clone),
                }
            } else {
                SourceInfo::None
            };
            let manifest = pkg
                .manifest()
                .original()
                .serialize(Serializer)
                .expect("failing to serialize Cargo.toml");
            LockedPackage {
                name: pkg.name().as_str().to_string(),
                version: pkg.version().to_string(),
                id: dep_to_pkg_id(id),
                source: source_id_to_string(source_id),
                dependencies,
                source_info,
                manifest,
            }
        })
        .collect();
    let root_packages = ws
        .members()
        .map(|pkg| LockedPackageId {
            name: pkg.name().as_str().to_string(),
            version: pkg.version().to_string(),
            source: source_id_to_string(pkg.package_id().source_id()),
        })
        .collect();
    Ok((packages, root_packages))
}
