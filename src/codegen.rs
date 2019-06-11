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

#[derive(Deserialize)]
pub struct LockFile {
    package: Vec<Package>,
    metadata: HashMap<String, String>,
}

#[derive(Deserialize)]
pub struct Package {
    name: String,
    version: String,
    source: Option<String>,
    dependencies: Option<Vec<String>>,
}

pub trait FormatPackageId {
    fn format_package_id(&self) -> String;
}

enum PackageId {
    NoSource(NoSourcePackageId),
    Regular(RegularPackageId),
    GitRepo(GitRepoPackageId),
    Raw {
        name: String,
        version: String,
        source: Option<String>,
    },
}

impl PackageId {
    fn from_raw<A, B, C>(name: A, version: B, source: Option<C>) -> Self
    where
        A: AsRef<str>,
        B: AsRef<str>,
        C: AsRef<str>,
    {
        PackageId::Raw {
            name: name.as_ref().to_string(),
            version: version.as_ref().to_string(),
            source: source.as_ref().map(|s| s.as_ref().to_string()),
        }
    }

    fn from_package_id<S: AsRef<str>>(package_id: S) -> Self {
        if let Some(id) = RegularPackageId::from_package_id(package_id.as_ref()) {
            PackageId::Regular(id)
        } else if let Some(id) = NoSourcePackageId::from_package_id(package_id.as_ref()) {
            PackageId::NoSource(id)
        } else {
            PackageId::Raw {
                name: "".to_string(),
                version: "".to_string(),
                source: None,
            }
        }
    }

    fn from_parts<A, B, C>(name: A, version: B, source: C) -> Self
    where
        A: AsRef<str>,
        B: AsRef<str>,
        C: AsRef<str>,
    {
        if let Some(id) = GitRepoPackageId::new(name.as_ref(), version.as_ref(), source.as_ref()) {
            PackageId::GitRepo(id)
        } else {
            Self::from_package_id(&format!(
                "{} {} ({})",
                name.as_ref(),
                version.as_ref(),
                source.as_ref()
            ))
        }
    }

    fn source(&self) -> Option<&str> {
        match self {
            PackageId::Regular(id) => id.source(),
            PackageId::GitRepo(id) => id.source(),
            PackageId::NoSource(id) => id.source(),
            PackageId::Raw { ref source, .. } => source.as_ref().map(String::as_str),
        }
    }
}

impl FormatPackageId for PackageId {
    fn format_package_id(&self) -> String {
        match self {
            PackageId::NoSource(ref id) => id.format_package_id(),
            PackageId::Regular(ref id) => id.format_package_id(),
            PackageId::GitRepo(ref id) => id.format_package_id(),
            PackageId::Raw {
                ref name,
                ref version,
                ref source,
            } => {
                if let Some(source) = source {
                    format!("{} {} ({})", name, version, source)
                } else {
                    format!("{} {}", name, version)
                }
            }
        }
    }
}

struct NoSourcePackageId {
    name: String,
    version: String,
}

impl NoSourcePackageId {
    fn from_package_id(package_id: &str) -> Option<Self> {
        if let Some(cap) = PACKAGE_ID_WITHOUT_SRC.captures(package_id) {
            if let (Some(name), Some(version)) = (cap.get(1), cap.get(2)) {
                return Some(Self {
                    name: name.as_str().to_string(),
                    version: version.as_str().to_string(),
                });
            }
        }
        None
    }

    fn source(&self) -> Option<&str> {
        None
    }
}

impl FormatPackageId for NoSourcePackageId {
    fn format_package_id(&self) -> String {
        format!("{} {} (unknown)", self.name, self.version)
    }
}

struct RegularPackageId {
    name: String,
    version: String,
    source: String,
}

impl RegularPackageId {
    fn from_package_id(package_id: &str) -> Option<Self> {
        if let Some(cap) = PACKAGE_ID_WITH_SRC.captures(package_id) {
            if let (Some(name), Some(version), Some(source)) = (cap.get(1), cap.get(2), cap.get(3))
            {
                return Some(Self {
                    name: name.as_str().to_string(),
                    version: version.as_str().to_string(),
                    source: source.as_str().to_string(),
                });
            }
        }
        None
    }

    fn source(&self) -> Option<&str> {
        Some(&self.source)
    }
}

impl FormatPackageId for RegularPackageId {
    fn format_package_id(&self) -> String {
        format!("{} {} ({})", self.name, self.version, self.source)
    }
}

fn checksum_key(package_id: &PackageId) -> String {
    format!("checksum {}", package_id.format_package_id())
}

struct GitRepoPackageId {
    name: String,
    version: String,
    url: String,
    rev: String,
    normalized_source: String,
}

impl FormatPackageId for GitRepoPackageId {
    fn format_package_id(&self) -> String {
        format!("{} {} (git+{})", self.name, self.version, self.url)
    }
}

impl GitRepoPackageId {
    fn new(name: &str, version: &str, source: &str) -> Option<Self> {
        if let Some(cap) = GIT_SOURCE.captures(source) {
            if let (Some(url), Some(rev)) = (cap.get(1), cap.get(2)) {
                return Some(Self {
                    name: name.to_string(),
                    version: version.to_string(),
                    url: url.as_str().to_string(),
                    rev: rev.as_str().to_string(),
                    normalized_source: format!("git+{}", url.as_str()),
                });
            }
        }
        None
    }

    fn source(&self) -> Option<&str> {
        Some(&self.normalized_source)
    }
}

#[derive(Deserialize)]
struct GitRepoPin {
    url: String,
    rev: String,
    sha256: String,
}

impl GitRepoPin {
    fn sha256(&self) -> String {
        self.sha256.clone()
    }
}

impl GitRepoPackageId {
    fn get_sha256(&self) -> impl Future<Item = GitRepoPin, Error = Error> {
        let url = self.url.clone();
        let rev = self.rev.clone();
        std::process::Command::new("nix-prefetch-git")
            .args(&["--url", &self.url, "--rev", &self.rev])
            .stdout(std::process::Stdio::piped())
            .output_async()
            .map_err(|e| format_err!("process: {}", e))
            .and_then(move |output| {
                if output.status.success() {
                    let output: GitRepoPin =
                        serde_json::from_str(&String::from_utf8_lossy(&output.stdout))?;
                    if output.url == url && output.rev == rev {
                        Ok(output)
                    } else {
                        Err(format_err!("url mismatch"))
                    }
                } else {
                    Err(format_err!("nix-prefetch-git failed"))
                }
            })
    }
}

pub fn generate(lockfile: LockFile) -> impl Future<Item = Arc<Expr>, Error = Error> {
    let config = ident!("config");
    let mk_rust_crate = ident!("mkRustCrate");
    let sources_to_fetch: Vec<_> = lockfile
        .package
        .iter()
        .flat_map(|p| {
            p.source
                .as_ref()
                .map(|source| (&p.name, &p.version, source))
        })
        .flat_map(|(name, version, source)| GitRepoPackageId::new(name, version, source))
        .collect();
    iter_ok(sources_to_fetch.into_iter())
        .and_then(|package_id| package_id.get_sha256().map(move |pin| (package_id, pin)))
        .fold(
            HashMap::new(),
            |mut map, (package_id, pin)| -> Result<_, Error> {
                map.insert(package_id.format_package_id(), pin.sha256().to_string());
                Ok(map)
            },
        )
        .and_then(move |git_repo_sha| -> Result<Arc<Expr>, Error> {
            let mut package_attrs = BTreeMap::new();
            for package in lockfile.package.iter() {
                let raw_source =
                    PackageId::from_raw(&package.name, &package.version, package.source.as_ref());
                let source = PackageId::from_parts(
                    &package.name,
                    &package.version,
                    package.source.as_ref().unwrap_or_else(|| &UNKNOWN_SOURCE),
                );
                let normalized_package_id = source.format_package_id();
                let checksum = git_repo_sha.get(&normalized_package_id).unwrap_or_else(|| {
                    lockfile
                        .metadata
                        .get(&checksum_key(&source))
                        .unwrap_or(&ZERO_SHA)
                });
                let resolver_source = match source {
                    PackageId::GitRepo(..) => raw_source.source(),
                    _ => source.source(),
                }
                .unwrap_or_else(|| &UNKNOWN_SOURCE)
                .clone();
                let src: App = app!(
                    proj!(config, key!("resolver")),
                    attrs!({
                        attrs_path!(key!("source")) => nix_string!(&resolver_source);
                        attrs_path!(key!("name")) => nix_string!(&package.name);
                        attrs_path!(key!("version")) => nix_string!(&package.version);
                        attrs_path!(key!("sha256")) => nix_string!(checksum);
                    })
                );
                package_attrs.insert(
                    attrs_path!(
                        key!(source.source().unwrap_or_else(|| UNKNOWN_SOURCE.as_str())),
                        key!(package.name),
                        key!(package.version)
                    ),
                    Arc::new(
                        app!(
                            mk_rust_crate,
                            attrs!({
                                attrs_path!(key!("package-id")) =>
                                    nix_string!(&normalized_package_id);
                                attrs_path!(key!("src")) => Arc::new(src);
                                attrs_path!(key!("dependencies")) => {
                                    Arc::new(
                                        List(
                                            package
                                                .dependencies
                                                .as_ref()
                                                .unwrap_or(&vec![])
                                                .iter()
                                                .map(PackageId::from_package_id)
                                                .map(|id| id.format_package_id())
                                                .map(NixString::new)
                                                .map(Expr::from)
                                                .collect()
                                        )
                                    )
                                };
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
