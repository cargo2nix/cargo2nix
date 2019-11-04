{
  nixpkgs ? fetchGit {
    url = https://github.com/NixOS/nixpkgs;
    rev = "47b551c6a854a049045455f8ab1b8750e7b00625";
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
  # 1. Setup nixpkgs with nixpkgs-mozilla overlay and cargo2nix overlay.
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

  # 2. Configure environments for building crates.
  # `rustPackageConfig` takes a package set and returns a set describing additional dependencies for building
  # crates with that package set.
  # The returned set should be of the form:
  # {
  #   <input> = {
  #     <package_id> = {};
  #     <package_id> = {};
  #   };
  # }
  # where
  # `<input>` is one of:
  # - `environment: a set of environment variables available at build time.
  # - `buildInputs`: similar to its `std.mkDervation` cousin.
  # - `nativeBuildInputs`: similar to its `stdenv.mkDerivation` cousin.
  # - `rustcflags`: a list of extra flags that are passed to `rustc` when building the crate.
  # - `rustcBuildFlags`: a list of extra flags that are passed to `rustc` when building the crate's build script (`build.rs`).
  #
  # `<package_id>` follows the convention `<registry>.<crate>.<version>` as mentioned in `README`.
  rustPackageConfig = pkgs:
    let
      # A quick fix for missing frameworks errors on macOS.
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

  # 3. Builds the rust package set, which contains all crates in your cargo workspace's dependency graph.
  # `makePackageSet'` accepts the following arguments:
  # - `packageFun` (required): The generated `Cargo.nix` file, which returns the whole dependency graph.
  # - `rustChannel` (required): The Rust channel used to build the package set.
  # - `rustPackageConfig` (optional): See above.
  # - `localPatterns` (optional):
  #     A list of regular expressions that specify what should be included in the sources of your workspace's crates.
  #     The expressions are relative to each crate's manifest directory.
  #     This argument is optional and defaults to include the `src` directory and all `toml` files at the root of the manifest directory.
  # - `rootFeatures` (optional):
  #     A list of activated features on your workspace's crates.
  #     Each feature should be of the form `<crate_name>[/<feature>]`.
  #     If `/<feature>` is omitted, the crate is activated with no default features.
  # - `release` (optional): Whether to enable release mode (equivalent to `cargo build --release`), defaults to `true`.
  rustPkgs = pkgs.rustBuilder.makePackageSet' {
    inherit rustPackageConfig;
    rustChannel = "1.37";
    packageFun = import ./Cargo.nix;
  };
in
  # `rustPkgs` now contains all crates in the dependency graph.
  # To build normal binaries, use `rustPkgs.<registry>.<crate>.<version>`.
  # To build test binaries (equivalent to `cargo build --tests`), use
  #   `rustPkgs.<registry>.<crate>.<version>.override { compileMode = "test"; }`.
  # To build bench binaries (equivalent to `cargo build --benches`), use
  #   `rustPkgs.<registry>.<crate>.<version>.override { compileMode = "bench"; }`.
{
  package = rustPkgs."unknown".cargo2nix."0.4.0";
}
