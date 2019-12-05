{ buildPackages, lib }:
rec {
  unpackSrc = { name, src }: buildPackages.stdenvNoCC.mkDerivation {
    inherit name src;
    preferLocalBuild = true;
    allowSubstitutes = false;
    phases = "unpackPhase installPhase";
    installPhase = "cp -R ./ $out";
  };

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

  # This implementation of `fetchCrateAlternativeRegistry` assumes that the download URL is updated frequently
  # on the registry index as a workaround for the lack of authentication for crate downloads. Each time a crate needs
  # to be downloaded, the whole index needs to be recloned to get the download URL, which is potentially expensive.
  fetchCrateAlternativeRegistryExpensive = { index, name, version, sha256 }: with buildPackages; stdenvNoCC.mkDerivation {
    name = "${name}-${version}.tar.gz";

    inherit (fetchgitPrivate { url = git://dummy; }) GIT_SSH SSH_AUTH_SOCK;
    INDEX = index;
    CRATE_NAME = name;
    CRATE_VERSION = version;

    outputHashAlgo = "sha256";
    outputHashMode = "flat";
    outputHash = sha256;

    nativeBuildInputs = [ git curl cacert jq ];

    builder = builtins.toFile "builder.sh" ''
      source "$stdenv/setup"
      git clone --depth=1 "$INDEX" ./index
      dl="$(jq -r ".dl" ./index/config.json)"
      if [[ "$dl" =~ "{crate}" ]]; then
        url="$(sed -e "s/{crate}/$CRATE_NAME/" -e "s/{version}/$CRATE_VERSION/" <<< "$dl")"
      else
        url="$dl/$CRATE_NAME/$CRATE_VERSION/download"
      fi
      curl -L "$url" -o "$out"
    '';
  };
}
