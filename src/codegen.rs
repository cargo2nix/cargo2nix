use std::{
    collections::{BTreeMap, HashMap},
    sync::Arc,
};

use failure::{format_err, Error};
use futures::{stream::iter_ok, Future, Stream};
use lazy_static::lazy_static;
use regex::Regex;
use serde::Deserialize;
use serde_json;
use tokio_process::CommandExt;

use crate::ast::{App, AttrSet, Expr, List, NixString};

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

pub struct Dependency {
    pub toml_names: Vec<String>,
    pub extern_name: String,
    pub package_id: String,
}

pub struct Package {
    pub name: String,
    pub version: String,
    pub id: String,
    pub dependencies: Vec<Dependency>,
    pub source_info: SourceInfo,
    pub source: Option<String>,
    pub manifest: Expr,
}

#[derive(Clone)]
pub enum GitReference {
    Branch(String),
    Tag(String),
    Rev(String),
}

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

pub fn generate(packages: Vec<Package>) -> impl Future<Item = Arc<Expr>, Error = Error> {
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
        .and_then(move |git_repo_sha| -> Result<Arc<Expr>, Error> {
            let mut package_attrs = BTreeMap::new();
            for package in packages {
                let source = package
                    .source
                    .as_ref()
                    .map(String::as_ref)
                    .unwrap_or_else(|| UNKNOWN_SOURCE.as_str());
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
                let src: App = app!(
                    proj!(config, key!("resolver")),
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
                            let dep: Arc<_> = attrs!({
                                attrs_path!(key!("toml-names")) =>
                                    Arc::new(
                                        List(
                                            toml_names
                                                .iter()
                                                .map(|n| NixString(n.clone()).into())
                                                .collect()));
                                attrs_path!(key!("extern-name")) => nix_string!(extern_name);
                                attrs_path!(key!("package-id")) => nix_string!(package_id);
                            });
                            dep.as_ref().clone().into()
                        },
                    )
                    .collect();
                package_attrs.insert(
                    attrs_path!(key!(source), key!(package.name), key!(package.version)),
                    Arc::new(
                        app!(
                            mk_rust_crate,
                            attrs!({
                                attrs_path!(key!("package-id")) =>
                                    nix_string!(&package.id);
                                attrs_path!(key!("src")) => Arc::new(src);
                                attrs_path!(key!("dependencies")) => Arc::new(List(dependencies));
                                attrs_path!(key!("cargo-manifest")) => Arc::new(package.manifest);
                            })
                        )
                        .into(),
                    ),
                );
            }
            let pkgs = ident!("pkgs");
            let call_package = ident!("callPackage");
            Ok(Arc::new(
                lambda! (
                    formal formal_arg!({
                        pkgs,
                        call_package,
                        mk_rust_crate,
                        config,
                        ...
                    }) =>
                        Arc::new(lambda!(
                            symbolic ident!("self") =>
                                Arc::new(AttrSet {
                                    recursive: false,
                                    attrs: package_attrs,
                                }.into())
                        ).into())
                )
                .into(),
            ))
        })
}
