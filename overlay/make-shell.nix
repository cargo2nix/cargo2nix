let
  defaultResolver = { source, name, version, ...}:
    throw "do not know how to resolve ${name} ${version} ${source}";
  crates-io-index = "registry+https://github.com/rust-lang/crates.io-index";

  default-registry-maps = {
    ${crates-io-index} = "crates-io";
  };
in
{
  packageFun ? _: throw "missing package function",
  packageResolver ? defaultResolver,
  excludeCrates ? {},
  registryMapping ? default-registry-maps,
  environment ? {},
  features ? {},
  buildInputs ? [],
  nativeBuildInputs ? [],

  lib,
  stdenv,
  callPackage,
  pkgs,
  mkCrate,
  mkLocalRegistry,
  mkShell,
  rustLib,
  fetchgit,
  cargo,
  rustc,
}:
with builtins; with lib;
let
  config = {
    resolver = { source, name, version, sha256, source-info }@args:
      {
        inherit source name version;
      } //
      (if source == crates-io-index then
        {
          tarball = rustLib.fetchCratesIo { inherit name version sha256; };
          kind = "registry";
        }
      else if rustLib.isGit source then
        {
          src = fetchgit {
            inherit sha256;
            inherit (source-info) rev url;
          };
          kind = "git";
        }
      else
        packageResolver args);
  };
  mkCrate' = { src, package-id, dependencies, cargo-manifest, ... }:
    {
      inherit src;
      manifest = cargo-manifest;
      deps =
        if dependencies == null then
          null
        else
          listToAttrs
            (flatten
              (map
                (dep:
                  map
                    (name: { inherit name; value = true; })
                    dep.toml-names)
                dependencies));
    };

  rpkgs =
    lib.fix
      (packageFun {
        inherit pkgs stdenv callPackage rustLib config;
        mkRustCrate = mkCrate';
      });

  filterPackages = filter: pkgs:
    let
      included-keys = lib.filter (key: filter ? ${key} -> filter.${key} != null) (attrNames pkgs);
    in
    if filter == "*" then
      {}
    else
      listToAttrs
        (map
          (key:
            {
              name = key;
              value =
                if filter ? ${key} then
                  filterPackages filter.${key} pkgs.${key}
                else
                  pkgs.${key};
            })
          included-keys);

  fpkgs = filterPackages excludeCrates rpkgs;

  regMaps = default-registry-maps // registryMapping;
  revRegMaps =
    listToAttrs
      (mapAttrsToList
        (url: name: { inherit name; value = elemAt (match "registry\\+(.+)" url) 0; })
        regMaps);

  registries =
    let
      makeRegistry = reg: crates:
        let
          name = regMaps.${reg};
          crates' =
            mapAttrsToList
              (name: versions:
                mapAttrsToList
                  (version: crate:
                    let
                      inherit (crate.src) name version source;
                      activated-features = features.${source}.${name}.${version} or null;
                    in
                    if crate.src.kind or "unknown" == "registry" && crate.src ? tarball then
                      mkCrate {
                        inherit (crate.src) name version tarball;
                        inherit (crate) manifest deps;
                        features = if activated-features == null then null else activated-features;
                        registryMapping = revRegMaps;
                      }
                    else if crate.src.kind or "unknown" == "registry" && crate.src ? src then
                      mkCrate {
                        inherit (crate.src) name version src;
                        inherit (crate) manifest deps;
                        features = if activated-features == null then null else activated-features;
                        registryMapping = revRegMaps;
                      }
                    else
                      [])
                versions
              )
              crates;
        in
        {
          inherit name;
          index = reg;
          local-registry = mkLocalRegistry {
            inherit name;
            crates = flatten crates';
          };
        };
    in
    mapAttrsToList makeRegistry (filterAttrs (reg: _: regMaps ? ${reg}) fpkgs);

  replacementManifest =
    concatStringsSep
      "\n"
      (map
        ({ name, index, local-registry }:
          let
            real-index = elemAt (builtins.match "registry\\+(.+)" index) 0;
          in
          ''
            [registries.'${name}']
            index = "${real-index}"
            [source.'${name}']
            registry = "${real-index}"
            replace-with = "vendored-${name}"
            [source.'vendored-${name}']
            local-registry = "${local-registry}"
          '')
        registries);
in
pkgs.mkShell (environment // {
  inherit buildInputs;
  nativeBuildInputs = [ cargo rustc ] ++ nativeBuildInputs;

  inherit replacementManifest;
  passAsFile = [ "replacementManifest" ];
  shellHook = ''
    vendor_source() {
      mkdir -p .cargo
      touch .cargo/config
      cat $replacementManifestPath >>.cargo/config
    }
  '';
})
