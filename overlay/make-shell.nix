let
  defaultResolver = { source, name, version, ...}:
    throw "do not know how to resolve ${name} ${version} ${source}";
  crates-io-index = "registry+https://github.com/rust-lang/crates.io-index";

  default-registry-maps = {
    ${crates-io-index} = "crates-io";
  };
in
{
  offline ? false,
  packageFun ? _: throw "missing package function",
  packageResolver ? defaultResolver,
  excludeCrates ? {},
  registryMapping ? default-registry-maps,

  lib,
  pkgs,
  mkCrate,
  mkShell,
  rustLib,
  fetchgit,
}:
let
  config = {
    resolver = { source, name, version, sha256, source-info }@args:
      {
        inherit name version;
      } //
      if source == crates-io-index then
        {
          tarball = rustLib.fetchCratesIo { inherit name version sha256; };
        }
      else if rustLib.isGit source then
        {
          src = fetchgit {
            inherit sha256;
            inherit (source-info) rev url;
          };
        }
      else
        { src = packageResolver args; };
  };
  mkCrate' = { src, ... }: src;

  rpkgs =
    lib.fix
      (packageFun {
        inherit pkgs stdenv callPackage rustLib config;
        mkRustCrate = mkRustCrate';
      });

  filterPackages = filter: pkgs:
    with lib;
    let
      included-keys = filter (key: filter ? ${key} -> filter.${key} != null) attrNames pkgs;
    in
    if filter == "*" then
      {}
    else if isAttrs filter then
      listToAttrs
        (map
          (key:
            {
              name = key;
              value = filterPackages filter.${key} pkgs.${key};
            })
          included-keys);

  fpkgs = filterPackage excludeCrates rpkgs;

  regMaps = registryMapping 

  registries =
    lib.mapAttr
      (reg)
in
