{
  nixpkgs ? fetchGit {
    url = https://github.com/NixOS/nixpkgs;
    ref = "release-19.09";
    rev = "63cdd9bd317e15e4a4f42dde455c73383ded1b41";
  },
  nixpkgsMozilla ? fetchGit {
    url = https://github.com/mozilla/nixpkgs-mozilla;
    rev = "50bae918794d3c283aeb335b209efd71e75e3954";
  },
  system ? builtins.currentSystem,
  overlays ? [ ],
  crossSystem ? (import nixpkgs {}).lib.systems.examples.musl64,
}:
let
  pkgs = import nixpkgs {
    inherit system crossSystem;
    overlays =
      let
        rustOverlay = import "${nixpkgsMozilla}/rust-overlay.nix";
        cargo2nixOverlay = import ./overlay;
      in
       overlays ++ [ cargo2nixOverlay rustOverlay ];
  };
  inherit (pkgs) lib buildPackages;

  rustChannel = buildPackages.rustChannelOf {
    channel = "1.37.0";
  };
  inherit (rustChannel) cargo;
  rustc = rustChannel.rust.override {
    targets = [
      (pkgs.rustBuilder.rustLib.realHostTriple pkgs.stdenv.targetPlatform)
    ];
  };

  packageFun = import ./Cargo.nix;
  rustPackageConfig =
    let
      darwinFrameworks = lib.optionals pkgs.hostPlatform.isDarwin
        (with pkgs.darwin.apple_sdk.frameworks; [ Security CoreServices ]);
    in
      {
        rustcflags = {
          "registry+https://github.com/rust-lang/crates.io-index"."*" = [ "--cap-lints" "warn" ];
        };
        nativeBuildInputs = {
          "registry+https://github.com/rust-lang/crates.io-index".curl-sys."*" = darwinFrameworks;
          "registry+https://github.com/rust-lang/crates.io-index".libgit2-sys."*" = darwinFrameworks;
        };
        buildInputs = {
          "registry+https://github.com/rust-lang/crates.io-index".libgit2-sys."*" = [ pkgs.libiconv ];
          "registry+https://github.com/rust-lang/crates.io-index".cargo."*" = [ pkgs.libiconv ] ++ darwinFrameworks;
          unknown.cargo2nix."*" = [ pkgs.libiconv ] ++ darwinFrameworks;
        };
        environment = {
          "registry+https://github.com/rust-lang/crates.io-index".openssl-sys."*" =
            let
              envize = s: builtins.replaceStrings ["-"] ["_"] (lib.toUpper s);
              envBuildPlatform = envize pkgs.buildPlatform.config;
              envHostPlatform = envize pkgs.hostPlatform.config;
              patchOpenssl = pkgs: (pkgs.openssl.override {
                # `perl` is only used at build time, but the derivation incorrectly uses host `perl` as an input.
                perl = pkgs.buildPackages.buildPackages.perl;
              }).overrideAttrs (drv: {
                installTargets = "install_sw";
                outputs = [ "dev" "out" "bin" ];
                postInstall = builtins.replaceStrings ["rm -r " "rmdir "] ["rm -rf " "rm -rf "] drv.postInstall;
              });

              joinOpenssl = openssl: buildPackages.symlinkJoin {
                name = "openssl"; paths = with openssl; [ out dev ];
              };
            in
              # We don't use key literals here, as they might collide if `hostPlatform == buildPlatform`.
              builtins.listToAttrs [
                { name = "${envBuildPlatform}_OPENSSL_DIR"; value = joinOpenssl (patchOpenssl buildPackages); }
                { name = "${envHostPlatform}_OPENSSL_DIR"; value = joinOpenssl (patchOpenssl pkgs); }
              ];
        };
      };

  rustPkgs = pkgs.rustBuilder.makePackageSet {
    inherit cargo rustc packageFun rustPackageConfig;
    buildRustPackages = buildPackages.rustBuilder.makePackageSet {
      inherit cargo rustc packageFun rustPackageConfig;
    };
  };
in
  rustPkgs."unknown".cargo2nix."0.4.0" { compileMode = "test"; }
