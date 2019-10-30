{ buildPackages, lib }:
let
  unpackSrc = { name, src }: buildPackages.stdenvNoCC.mkDerivation {
    inherit name src;
    preferLocalBuild = true;
    allowSubstitutes = false;
    phases = "unpackPhase installPhase";
    installPhase = "cp -R ./ $out";
  };
in
{
  fetchCratesIo = { name, version, sha256 }: unpackSrc {
    name = "${name}-${version}-unpacked";
    src = buildPackages.fetchurl {
      name = "${name}-${version}.tar.gz";
      url = "https://crates.io/api/v1/crates/${name}/${version}/download";
      inherit sha256;
    };
  };

  fetchCrateGit = { url, name, version, rev, sha256 }:
    let
      inherit (buildPackages) runCommand jq remarshal fetchgitPrivate;
      repo = fetchgitPrivate {
        name = "${name}-${version}-src";
        inherit url rev sha256;
      };
    in
      /. + builtins.readFile (runCommand "find-crate-${name}-${version}"
        { nativeBuildInputs = [ jq remarshal ]; }
        ''
          shopt -s globstar
          for f in ${repo}/**/Cargo.toml; do
            if [[ "$(remarshal -if toml -of json "$f" | jq '.package.name == "${name}" and .package.version == "${version}"')" == "true" ]]; then
              echo -n "''${f%/*}" > $out
              exit 0
            fi
          done

          echo Crate ${name}-${version} not found in ${url}
          exit 1
        '');
}
