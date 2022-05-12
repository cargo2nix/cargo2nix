{ buildPackages, lib }:
rec {
  fetchCratesIo = { name, version, sha256 }: buildPackages.fetchurl {
    name = "${name}-${version}.tar.gz";
    url = "https://crates.io/api/v1/crates/${name}/${version}/download";
    inherit sha256;
  };

  fetchCrateGit = { url, name, version, rev, ref ? "HEAD" }: builtins.fetchGit {
    inherit url rev ref;
  };

  # This implementation of `fetchCrateAlternativeRegistry` assumes that the download URL is updated frequently
  # on the registry index as a workaround for the lack of authentication for crate downloads. Each time a crate needs
  # to be downloaded, the whole index needs to be recloned to get the download URL, which is potentially expensive.
  fetchCrateAlternativeRegistryExpensive = { index, name, version, sha256 }: with buildPackages; stdenvNoCC.mkDerivation {
    name = "${name}-${version}.tar.gz";
    src = builtins.fetchGit { url = index; ref = "master"; };

    CRATE_NAME = name;
    CRATE_VERSION = version;

    outputHashAlgo = "sha256";
    outputHashMode = "flat";
    outputHash = sha256;

    nativeBuildInputs = [ curl cacert jq ];

    builder = builtins.toFile "builder.sh" ''
      source "$stdenv/setup"
      dl="$(jq -r ".dl" "$src/config.json")"
      if [[ "$dl" =~ "{crate}" ]]; then
        url="$(sed -e "s/{crate}/$CRATE_NAME/" -e "s/{version}/$CRATE_VERSION/" <<< "$dl")"
      else
        url="$dl/$CRATE_NAME/$CRATE_VERSION/download"
      fi
      curl -L "$url" -o "$out"
    '';
  };
}
