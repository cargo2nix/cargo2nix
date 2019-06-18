let
  crates-io = "https://github.com/rust-lang/crates.io-index";
in
{ stdenvNoCC, jq, runCommandNoCC, lib }:
let
  computeSha256 = src: runCommandNoCC "cksum" {} "sha256sum ${src} | cut -d' ' -f1 >$out";
in
{ src ? null, tarball ? null, name ? null, version ? null }:
assert src != null || tarball != null;
assert src == null || tarball == null;
assert tarball != null -> name != null && version != null;
let
  inherit (builtins) fromTOML readFile isString;
  unpackedSrc =
    if src == null then
      stdenvNoCC.mkDerivation {
        name = "unpacked-${name}-${version}";
        src = tarball;
        installPhase = ''
          mkdir -p $out
          cp -R ./. $out/
        '';
      }
    else src;

  Cargo-toml = fromTOML (readFile "${unpackedSrc}/Cargo.toml");

  inherit (Cargo-toml.package) name version;

  crate =
    if tarball == null then
      stdenvNoCC.mkDerivation {
        name = "${name}-${version}.tar.gz";
        inherit src;
        installPhase = ''
          tar czf $out \
            --hard-dereference \
            --sort=name \
            --mtime="@$SOURCE_DATE_EPOCH" \
            --xform 's,^\.,${name}-${version},' \
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
    else
      {
        inherit name target kind;
        default_features = spec.default_features or [];
        features = spec.features or [];
        optional = spec.optional or false;
        registry = spec.registry or crates-io;
        req = spec.version;
      }
    ;

  collectDeps = collector: deps:
    lib.attrValues
      (lib.mapAttrs (collector "normal") deps.dependencies or {}) ++
    lib.attrValues
      (lib.mapAttrs (collector "dev") deps.dev-dependencies or {}) ++
    lib.attrValues
      (lib.mapAttrs (collector "build") deps.build-dependencies or {});

  registry-entry = {
    inherit cksum name;
    deps =
      collectDeps (mkDep null) Cargo-toml ++
      lib.attrValues
        (lib.mapAttrs
          (target: deps: collectDeps (mkDep target) deps)
          (Cargo-toml.target or {}));
    features = Cargo-toml.features or {};
    vers = version;
    yanked = false;
  };
in
rec {
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
