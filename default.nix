{
  nixpkgs ? builtins.fetchTarball {
    url = https://github.com/NixOS/nixpkgs/archive/47b551c6a854a049045455f8ab1b8750e7b00625.tar.gz;
    sha256 = "0p0p6gf3kimcan4jgb4im3plm3yw68da09ywmyzhak8h64sgy4kg";
  },
  nixpkgsMozilla ? builtins.fetchTarball {
    url = https://github.com/mozilla/nixpkgs-mozilla/archive/50bae918794d3c283aeb335b209efd71e75e3954.tar.gz;
    sha256 = "07b7hgq5awhddcii88y43d38lncqq9c8b2px4p93r5l7z0phv89d";
  },
  system ? builtins.currentSystem,
  overlays ? [ ],
  crossSystem ? null,
  rustChannel ? "1.43.0",
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

  # 2. Builds the rust package set, which contains all crates in your cargo workspace's dependency graph.
  # `makePackageSet'` accepts the following arguments:
  # - `packageFun` (required): The generated `Cargo.nix` file, which returns the whole dependency graph.
  # - `rustChannel` (required): The Rust channel used to build the package set.
  # - `packageOverrides` (optional):
  #     A function taking a package set and returning a list of overrides.
  #     Overrides are introduced to provide native inputs to build the crates generated in `Cargo.nix`.
  #     See `overlay/lib/overrides.nix` on how to create overrides and `overlay/overrides.nix` for a list of predefined overrides.
  #     Most of the time, you can just use `overrides.all`. You can hand-pick overrides later if your build becomes too slow.
  # - `localPatterns` (optional):
  #     A list of regular expressions that specify what should be included in the sources of your workspace's crates.
  #     The expressions are relative to each crate's manifest directory.
  #     This argument is optional and defaults to include the `src` directory and all `toml` files at the root of the manifest directory.
  # - `rootFeatures` (optional):
  #     A list of activated features on your workspace's crates.
  #     Each feature should be of the form `<crate_name>[/<feature>]`.
  #     If `/<feature>` is omitted, the crate is activated with no default features.
  #     The default behavior is to activate all crates with default features.
  # - `fetchCrateAlternativeRegistry` (optional): A fetcher for crates on alternative registries.
  # - `release` (optional): Whether to enable release mode (equivalent to `cargo build --release`), defaults to `true`.
  rustPkgs = pkgs.rustBuilder.makePackageSet' {
    packageFun = import ./Cargo.nix;
    inherit rustChannel;
    packageOverrides = pkgs: pkgs.rustBuilder.overrides.all;
    localPatterns = [ ''^(src|tests|templates)(/.*)?'' ''[^/]*\.(rs|toml)$'' ];
  };
in
  # `rustPkgs` now contains all crates in the dependency graph.
  # To build normal binaries, use `rustPkgs.<registry>.<crate>.<version> { }`.
  # To build test binaries (equivalent to `cargo build --tests`), use
  #   `rustPkgs.<registry>.<crate>.<version>{ compileMode = "test"; }`.
  # To build bench binaries (equivalent to `cargo build --benches`), use
  #   `rustPkgs.<registry>.<crate>.<version>{ compileMode = "bench"; }`.
  # For convenience, you can also refer to the crates in the workspace using
  #   `rustPkgs.workspace.<crate>`.
rec {
  inherit rustPkgs;
  package = (rustPkgs.workspace.cargo2nix { }).overrideAttrs (drv: {
    nativeBuildInputs = drv.nativeBuildInputs or [ ] ++ [ pkgs.buildPackages.makeWrapper ];
    installPhase = ''
      ${drv.installPhase or ""}
      wrapProgram $out/bin/cargo2nix --prefix PATH ":" "${pkgs.nix-prefetch-git}/bin"
    '';
  });
  # `runTests` runs all tests for a crate inside a Nix derivation.
  # This may be problematic as Nix may restrict filesystem, network access,
  # socket creation, ... which the test binary may need.
  # If you run to those problems, build test binaries (as shown above) and run them
  # manually outside a Nix derivation.
  ci = pkgs.rustBuilder.runTests rustPkgs.workspace.cargo2nix { };
  # `noBuild` is a special crate set used to create a development shell
  # containing all native dependencies provided by the overrides above.
  # `cargo build` with in the shell should just work.
  shell = pkgs.mkShell {
    inputsFrom = pkgs.lib.mapAttrsToList (_: pkg: pkg { }) rustPkgs.noBuild.workspace;
    nativeBuildInputs = with rustPkgs; [ cargo rustc ];
  };
  examples =
    let
      importExprsInDir = with pkgs.lib; dir:
        mapAttrsToList (name: _: import (dir + "/${name}") {})
          (pkgs.lib.filterAttrs (name: kind: kind == "directory")
            (builtins.readDir dir));
    in
      importExprsInDir ./examples;
}
