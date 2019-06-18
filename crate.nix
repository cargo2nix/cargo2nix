({
    pkgs
  , buildPackages
  , lib
  , resolver
  , packageFun
  , config
  , cargo
  , rustc
}:
  let
    inherit (lib) recursiveUpdate;
    config' = lib.recursiveUpdate config {
      resolver = (args@{
          source
        , name
        , version
        , sha256
        , source-info
      }:
        if source == "registry+https://github.com/rust-lang/crates.io-index" then
          pkgs.rustBuilder.rustLib.fetchCratesIo {
            inherit name;
            inherit version;
            inherit sha256;
          }
        else
          resolver args);
    };
    bootstrap = pkgs.rustBuilder.makePackageSet {
      inherit cargo;
      inherit rustc;
      inherit packageFun;
      rustPackageConfig = config';
      buildRustPackages = buildPackages.rustBuilder.makePackageSet {
        inherit cargo;
        inherit rustc;
        inherit packageFun;
        rustPackageConfig = config';
      };
    };
    features = lib.fold lib.recursiveUpdate {
    } [
      (pkgs.rustBuilder.rustLib.resolveFeatures bootstrap.unknown.cargo2nix."0.1.0")
    ];
  in
  pkgs.rustBuilder.makePackageSet {
    inherit cargo;
    inherit rustc;
    inherit packageFun;
    rustPackageConfig = lib.recursiveUpdate config' {
      features = features.${pkgs.stdenv.hostPlatform.config};
    };
    buildRustPackages = buildPackages.rustBuilder.makePackageSet {
      inherit cargo;
      inherit rustc;
      inherit packageFun;
      rustPackageConfig = lib.recursiveUpdate config' {
        features = features.${buildPackages.stdenv.hostPlatform.config};
      };
    };
  })