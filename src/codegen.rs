use std::collections::{BTreeSet, HashMap};

use failure::{format_err, Error};
use futures::{stream::iter_ok, Future, Stream};
use lazy_static::lazy_static;
use log::info;
use regex::Regex;
use serde::Deserialize;
use serde_json;
use tokio_process::CommandExt;

use crate::ast::{AttrSet, Eq, Expr, List, NixString};

lazy_static! {
    static ref PACKAGE_ID_WITH_SRC: Regex = Regex::new("^(.+) (.+) \\((.+)\\)$").unwrap();
    static ref PACKAGE_ID_WITHOUT_SRC: Regex = Regex::new("^(.+) (.+)$").unwrap();
    static ref GIT_SOURCE: Regex = Regex::new("^git\\+(.+)#(.+)$").unwrap();
    static ref ZERO_SHA: String =
        "0000000000000000000000000000000000000000000000000000".to_string();
    static ref UNKNOWN_SOURCE: String = "unknown".to_string();
}

pub struct LockFile {
    pub package: Vec<Package>,
    pub metadata: HashMap<String, String>,
}

#[derive(Debug)]
pub struct Dependency {
    pub toml_names: Vec<String>,
    pub extern_name: String,
    pub package_id: String,
}

#[derive(Debug)]
pub struct Package {
    pub name: String,
    pub version: String,
    pub id: String,
    pub dependencies: Vec<Dependency>,
    pub source_info: SourceInfo,
    pub source: Option<String>,
    pub manifest: Expr,
}

pub struct PackageId {
    pub name: String,
    pub version: String,
    pub source: Option<String>,
}

#[derive(Clone, Debug)]
pub enum GitReference {
    Branch(String),
    Tag(String),
    Rev(String),
}

#[derive(Debug)]
pub enum SourceInfo {
    Registry {
        index: String,
        checksum: Option<String>,
    },
    Git {
        url: String,
        git_ref: GitReference,
    },
    None,
}

#[derive(Deserialize)]
struct GitRepoPin {
    url: String,
    rev: String,
    sha256: String,
}

pub fn generate(packages: Vec<Package>) -> impl Future<Item = Box<Expr>, Error = Error> {
    info!("generate: {:?}", packages);
    let config = ident!("config");
    let mk_rust_crate = ident!("mkRustCrate");
    let sources_to_fetch: Vec<_> = packages
        .iter()
        .filter_map(|pkg| match pkg.source_info {
            SourceInfo::Git {
                ref url,
                ref git_ref,
            } => Some((pkg.id.clone(), url.clone(), git_ref.clone())),
            _ => None,
        })
        .collect();
    iter_ok(sources_to_fetch.into_iter())
        .and_then(|(id, url, git_ref)| {
            let mut cmd = std::process::Command::new("nix-prefetch-git");
            cmd.args(&["--url", &url]);
            cmd.arg("--rev");
            match git_ref {
                GitReference::Branch(ref branch) => cmd.arg(&format!("refs/heads/{}", branch)),
                GitReference::Rev(ref rev) => cmd.arg(rev),
                GitReference::Tag(ref tag) => cmd.arg(&format!("refs/tags/{}", tag)),
            }
            .stdout(std::process::Stdio::piped())
            .output_async()
            .map_err(|e| format_err!("process: {}", e))
            .and_then(move |output| {
                if output.status.success() {
                    let output: GitRepoPin =
                        serde_json::from_str(&String::from_utf8_lossy(&output.stdout))?;
                    Ok((id, output))
                } else {
                    Err(format_err!(
                        "nix-prefetch-git failed, {}",
                        String::from_utf8_lossy(&output.stderr)
                    ))
                }
            })
        })
        .fold(HashMap::new(), |mut map, (id, pin)| -> Result<_, Error> {
            map.insert(id, pin);
            Ok(map)
        })
        .and_then(move |git_repo_sha| -> Result<Box<Expr>, Error> {
            let mut package_attrs = vec![];
            let mut sources = BTreeSet::new();
            for package in packages {
                let source = package
                    .source
                    .as_ref()
                    .map(String::as_ref)
                    .unwrap_or_else(|| UNKNOWN_SOURCE.as_str());
                sources.insert(source.to_string());
                let (source_info, checksum) = match package.source_info {
                    SourceInfo::Registry {
                        ref index,
                        ref checksum,
                    } => (
                        attrs!({
                            attrs_path!(key!("index")) => nix_string!(index);
                        }),
                        checksum.as_ref(),
                    ),
                    SourceInfo::Git { .. } => {
                        let entry = git_repo_sha.get(&package.id);
                        let pin = entry.as_ref().expect("a git crate is not prefetched");
                        (
                            attrs!({
                                attrs_path!(key!("url")) => nix_string!(&pin.url);
                                attrs_path!(key!("rev")) => nix_string!(&pin.rev);
                            }),
                            Some(&pin.sha256),
                        )
                    }
                    SourceInfo::None => (attrs!({}), None),
                };
                let src: Expr = app!(
                    proj!(config.clone().into(), key!("resolver")),
                    attrs!({
                        attrs_path!(key!("source")) => nix_string!(&source);
                        attrs_path!(key!("name")) => nix_string!(&package.name);
                        attrs_path!(key!("version")) => nix_string!(&package.version);
                        attrs_path!(key!("sha256")) => nix_string!(checksum.unwrap_or(&ZERO_SHA));
                        attrs_path!(key!("source-info")) => source_info;
                    })
                );
                let dependencies: Vec<Expr> = package
                    .dependencies
                    .iter()
                    .map(
                        |Dependency {
                             ref toml_names,
                             ref extern_name,
                             ref package_id,
                         }| {
                            attrs!({
                                attrs_path!(key!("toml-names")) =>
                                        List(
                                            toml_names
                                                .iter()
                                                .map(|n| NixString(n.clone()).into())
                                                .collect()).into();
                                attrs_path!(key!("extern-name")) => nix_string!(extern_name);
                                attrs_path!(key!("package-id")) => nix_string!(package_id);
                            })
                        },
                    )
                    .collect();
                package_attrs.push((
                    attrs_path!(key!(source), key!(package.name), key!(package.version)),
                    app!(
                        mk_rust_crate.clone().into(),
                        attrs!({
                            attrs_path!(key!("package-id")) =>
                                nix_string!(&package.id);
                            attrs_path!(key!("src")) => src.into();
                            attrs_path!(key!("dependencies")) => List(dependencies).into();
                            attrs_path!(key!("cargo-manifest")) => package.manifest;
                        })
                    )
                    .into(),
                ));
            }
            package_attrs.push((
                attrs_path!(key!("sources")),
                List(sources.into_iter().map(|s| nix_string!(s).into()).collect()).into(),
            ));
            let pkgs = ident!("pkgs");
            let call_package = ident!("callPackage");
            Ok(Box::new(
                lambda! (
                    formal formal_arg!({
                        pkgs,
                        call_package,
                        mk_rust_crate,
                        config,
                        ...
                    }) =>
                        Box::new(lambda!(
                            symbolic ident!("self") =>
                                Box::new(AttrSet {
                                    recursive: false,
                                    attrs: package_attrs,
                                }.into())
                        ).into())
                )
                .into(),
            ))
        })
}

/// Stub generator that contains all the boilerplates
pub fn generate_builder(packages: Vec<PackageId>) -> Expr {
    let crates_io_index = nix_string!("registry+https://github.com/rust-lang/crates.io-index");

    let pkgs = ident!("pkgs");
    #[allow(non_snake_case)]
    let buildPackages = ident!("buildPackages");
    let lib = ident!("lib");
    let config = ident!("config");
    let build_config = ident!("buildConfig");
    let resolver = ident!("resolver");
    #[allow(non_snake_case)]
    let packageFun = ident!("packageFun");
    let cargo = ident!("cargo");
    let rustc = ident!("rustc");

    let bootstrap = ident!("bootstrap");

    #[allow(non_snake_case)]
    let rustBuilder = "rustBuilder";
    #[allow(non_snake_case)]
    let rustLib = "rustLib";
    #[allow(non_snake_case)]
    let makePackageSet = "makePackageSet";

    let package_features = List(
        packages
            .iter()
            .map(|p| {
                app!(
                    proj!(
                        app!(
                            proj!(
                                bootstrap.clone().into(),
                                key!(&p
                                    .source
                                    .as_ref()
                                    .map(String::as_str)
                                    .unwrap_or_else(|| UNKNOWN_SOURCE.as_str())),
                                key!(&p.name),
                                key!(&p.version)
                            ),
                            attrs!({}).into()
                        )
                        .into(),
                        key!("computePackageFeatures")
                    ),
                    list!().into()
                )
            })
            .collect(),
    )
    .into();

    let features = ident!("features");
    lambda!(
        formal formal_arg!({
            pkgs.clone(),
            buildPackages.clone(),
            lib.clone(),
            resolver.clone(),
            packageFun.clone(),
            config.clone(),
            build_config.clone(),
            cargo.clone(),
            rustc.clone(),
        }) => Box::new(letin!(
            let

            inherit (lib.clone().into()) ident!("recursiveUpdate");
            ident!("resolver-overlay") =>
                attrs!({
                    attrs_path!(key!("resolver")) => {
                        let source = ident!("source");
                        let name = ident!("name");
                        let version = ident!("version");
                        let sha256 = ident!("sha256");
                        let args = ident!("args");
                        lambda!(
                            formal formal_arg!({
                                source.clone(),
                                name.clone(),
                                version.clone(),
                                sha256.clone(),
                                ident!("source-info")
                            } @ args.clone()) => Box::new(
                                ifelse!(
                                    Eq {
                                        one: Box::new(source.clone().into()),
                                        another: Box::new(crates_io_index),
                                    }.into(),
                                    app!(
                                        proj!(
                                            pkgs.clone().into(),
                                            key!(rustBuilder),
                                            key!(rustLib),
                                            key!("fetchCratesIo")
                                        ).into(),
                                        attrs!({
                                            attrs_path!(name.clone().to_key()) => name.clone().into();
                                            attrs_path!(version.clone().to_key()) => version.clone().into();
                                            attrs_path!(sha256.clone().to_key()) => sha256.clone().into();
                                        }).into()
                                    ),
                                    app!(resolver.into(), args.into()).into()
                                ).into()
                            )
                        ).into()
                    };
                });
            ident!("config'") =>
                app!(
                    app!(
                        proj!(
                            lib.clone().into(),
                            key!("recursiveUpdate")),
                        config.clone().into()),
                    ident!("resolver-overlay").into()
                );
            ident!("buildConfig'") =>
                app!(
                    app!(
                        proj!(
                            lib.clone().into(),
                            key!("recursiveUpdate")),
                        build_config.clone().into()),
                    ident!("resolver-overlay").into()
                );
            bootstrap.clone() =>
                app!(
                    proj!(
                        pkgs.clone().into(),
                        key!(rustBuilder),
                        key!(makePackageSet)),
                    attrs!({
                        attrs_path!(cargo.clone().to_key()) => cargo.clone().into();
                        attrs_path!(rustc.clone().to_key()) => rustc.clone().into();
                        attrs_path!(packageFun.clone().to_key()) =>
                            packageFun.clone().into();
                        attrs_path!(key!("rustPackageConfig")) =>
                            ident!("config'").into();
                        attrs_path!(key!("buildRustPackages")) =>
                            app!(
                                proj!(
                                    buildPackages.clone().into(),
                                    key!(rustBuilder),
                                    key!(makePackageSet),
                                ),
                                attrs!({
                                    attrs_path!(cargo.clone().to_key()) => cargo.clone().into();
                                    attrs_path!(rustc.clone().to_key()) => rustc.clone().into();
                                    attrs_path!(packageFun.clone().to_key()) =>
                                        packageFun.clone().into();
                                    attrs_path!(key!("rustPackageConfig")) =>
                                        ident!("config'").into();
                                }).into()
                            );
                    }).into());
            ident!("all-features") => {
                app!(
                    app!(
                        app!(
                            proj!(lib.clone().into(), key!("fold")),
                            proj!(lib.clone().into(), key!("recursiveUpdate"))),
                        attrs!({})
                    ),
                    package_features
                )
            };
            features.clone() => {
                app!(
                    app!(
                        app!(
                            proj!(ident!("lib").into(), key!("fold")),
                            proj!(ident!("lib").into(), key!("recursiveUpdate"))
                        ),
                        attrs!({}).into()
                    ),
                    app!(
                        app!(
                            proj!(ident!("lib").into(), key!("mapAttrsToList")),
                            lambda!(
                                symbolic ident!("_") =>
                                    Box::new(
                                        lambda!(
                                            symbolic ident!("features") =>
                                                Box::new(ident!("features").into())
                                        ).into()
                                    )
                            ).into()
                        ),
                        ident!("all-features").into()
                    )
                )
            };
            in
                app!(
                    proj!(
                        pkgs.clone().into(),
                        key!(rustBuilder),
                        key!(makePackageSet)),
                    attrs!({
                        attrs_path!(cargo.clone().to_key()) => cargo.clone().into();
                        attrs_path!(rustc.clone().to_key()) => rustc.clone().into();
                        attrs_path!(packageFun.clone().to_key()) =>
                            packageFun.clone().into();
                        attrs_path!(key!("rustPackageConfig")) =>
                            app!(
                                app!(
                                    proj!(lib.clone().into(), key!("recursiveUpdate")),
                                    ident!("config'").into()
                                ),
                                attrs!({
                                    attrs_path!(key!("features")) => features.clone().into();
                                })
                            );
                        attrs_path!(key!("buildRustPackages")) =>
                            app!(
                                proj!(
                                    buildPackages.clone().into(),
                                    key!(rustBuilder),
                                    key!(makePackageSet),
                                ),
                                attrs!({
                                    attrs_path!(cargo.clone().to_key()) => cargo.clone().into();
                                    attrs_path!(rustc.clone().to_key()) => rustc.clone().into();
                                    attrs_path!(packageFun.clone().to_key()) =>
                                        packageFun.clone().into();
                                    attrs_path!(key!("rustPackageConfig")) =>
                                        app!(
                                            app!(
                                                proj!(lib.clone().into(), key!("recursiveUpdate")),
                                                ident!("buildConfig'").into()
                                            ),
                                            attrs!({
                                                attrs_path!(key!("features")) => features.into();
                                            })
                                        );
                                }).into()
                            );
                    }).into())
        ).into())
    )
    .into()
}
