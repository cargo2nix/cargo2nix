use std::{
    collections::{BTreeMap, HashMap},
    rc::Rc,
};

use serde::Deserialize;

use crate::ast::{App, AttrSet, Expr, List, NixString};

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

fn package_id(source: &str, name: &str, version: &str) -> String {
    format!("{} {} ({})", name, version, source)
}

fn checksum_key(source: &str, name: &str, version: &str) -> String {
    format!("checksum {}", package_id(source, name, version))
}

pub fn generate(lockfile: &LockFile) -> Rc<Expr> {
    let mut package_attrs = BTreeMap::new();
    let config = ident!("config");
    let mk_rust_crate = ident!("mkRustCrate");
    for package in lockfile.package.iter() {
        let source = if let Some(ref source) = package.source {
            source
        } else {
            "unknown"
        };
        let src: App = app!(
            proj!(config, key!("resolver")),
            attrs!({
                attrs_path!(key!("source")) => nix_string!(source);
                attrs_path!(key!("name")) => nix_string!(&package.name);
                attrs_path!(key!("version")) => nix_string!(&package.version);
                attrs_path!(key!("sha256")) =>
                    nix_string!(
                        &lockfile
                            .metadata
                            .get(
                                &checksum_key(
                                    &source,
                                    &package.name,
                                    &package.version
                                )
                            )
                            .unwrap_or(
                                &"0000000000000000000000000000000000000000000000000000".to_string()
                            )
                    );
            })
        );
        package_attrs.insert(
            attrs_path!(key!(source), key!(package.name), key!(package.version)),
            Rc::new(
                app!(
                    mk_rust_crate,
                    attrs!({
                        attrs_path!(key!("package-id")) =>
                            nix_string!(package_id(source, &package.name, &package.version));
                        attrs_path!(key!("src")) => Rc::new(src);
                        attrs_path!(key!("dependencies")) => {
                            Rc::new(
                                List(
                                    package
                                        .dependencies
                                        .as_ref()
                                        .unwrap_or(&vec![])
                                        .iter()
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
    Rc::new(
        lambda! (
            formal formal_arg!({
                pkgs,
                call_package,
                mk_rust_crate,
                config,
                ...
            }) =>
                Rc::new(lambda!(
                    symbolic ident!("self") =>
                        Rc::new(AttrSet {
                            recursive: false,
                            attrs: package_attrs,
                        }.into())
                ).into())
        )
        .into(),
    )
}
