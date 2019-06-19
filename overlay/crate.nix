let
  crates-io = "https://github.com/rust-lang/crates.io-index";
in
{ stdenvNoCC, jq, runCommandNoCC, lib }:
let
  computeSha256 = src: runCommandNoCC "cksum" {} "sha256sum ${src} | cut -d' ' -f1 >$out";
in
{
  src ? null,
  tarball ? null,
  name ? null,
  version ? null,
  manifest ? null,
  deps ? null,
  features ? null
}:
assert src != null || tarball != null;
assert src == null || tarball == null;
assert tarball != null -> name != null && version != null;
let
  name' = name;
  version' = version;
  deps' = deps;
  features' = features;
in
let
  inherit (builtins) fromTOML readFile isString;
  unpackedSrc =
    if src == null then
      stdenvNoCC.mkDerivation {
        name = "unpacked-${name'}-${version'}";
        src = tarball;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp -R ./. $out/
        '';
      }
    else src;

  Cargo-toml =
    if manifest == null then
      fromTOML (readFile "${unpackedSrc}/Cargo.toml")
    else
      manifest;

  inherit (Cargo-toml.package) name version;

  crate =
    if tarball == null then
      stdenvNoCC.mkDerivation {
        name = "${name'}-${version'}.tar.gz";
        inherit src;
        installPhase = ''
          tar czf $out \
            --hard-dereference \
            --sort=name \
            --mtime="@$SOURCE_DATE_EPOCH" \
            --xform 's,^\.,${name'}-${version'},' \
            --owner=0 \
            --group=0 \
            .
        '';
      }
    else tarball;
in
let
  src = unpackedSrc;

  cksum = lib.fileContents (computeSha256 crate);
  cargo-checksum = stdenvNoCC.mkDerivation {
    name = "${name}-${version}.cargo-checksum";
    nativeBuildInputs = [jq];
    packageChecksum = cksum;
    inherit src;
    installPhase = ''
      buildChecksum() {
        unset first
        echo '{"package":'
        echo '"'"$packageChecksum"'","files": {'
        for path in `find . -mindepth 1 | sed 's/^\.\///'`; do
          if [ -f $path ]; then
            if [ -z "''${first:+x}" ]; then
              first=y
            else
              echo ','
            fi
            echo '"'"$path"'": "'`sha256sum $path | cut -d' ' -f1`'"'
          fi
        done
        echo '}}'
      }
      buildChecksum | jq -c > $out
    '';
  };

  mkDep = target: kind: name: spec:
    if isString spec then
      {
        inherit name target kind;
        default_features = true;
        features = [];
        optional = false;
        registry = crates-io;
        req = spec;
      }
    else if deps' == null || deps' ? ${name} then
      {
        inherit name target kind;
        default_features = spec.default_features or true;
        features = spec.features or [];
        optional = spec.optional or false;
        registry = spec.registry or crates-io;
        req = spec.version;
      }
    else [];

  collectDeps = collector: deps:
    lib.attrValues
      (lib.mapAttrs (collector "normal") deps.dependencies or {}) ++
    lib.attrValues
      (lib.mapAttrs (collector "dev") deps.dev-dependencies or {}) ++
    lib.attrValues
      (lib.mapAttrs (collector "build") deps.build-dependencies or {});

  deps =
    lib.flatten
      (collectDeps (mkDep null) Cargo-toml ++
        lib.attrValues
          (lib.mapAttrs
            (target: deps: collectDeps (mkDep target) deps)
            (Cargo-toml.target or {})));

  depNames = lib.listToAttrs (map (d: { inherit (d) name; value = true; }) deps);

  features =
    let
      toml-features = Cargo-toml.features or {};
      orig-features =
        if features' == null then
          toml-features
        else
          builtins.intersectAttrs features' toml-features;
    in
    lib.mapAttrs
      (name: fs:
        lib.filter
          (f:
            let
              match = builtins.match "(.+)/(.+)" f;
              dep = if match == null then "" else lib.elemAt match 0;
            in
            depNames ? ${f} ||
            depNames ? ${dep} ||
            (features' != null && features' ? ${f}) ||
            (features' != null && features' ? ${dep}))
          fs)
      orig-features;

  registry-entry = {
    inherit cksum name deps features;
    vers = version;
    yanked = false;
  };
in
{
  inherit
    Cargo-toml
    cargo-checksum
    cksum
    crate
    name
    registry-entry
    src
    version
    ;
}
