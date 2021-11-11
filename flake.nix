{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
    rust-overlay.inputs.flake-utils.follows = "flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs?ref=release-21.05";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };
  
  outputs = { self, nixpkgs, flake-utils, rust-overlay, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        cargo2nixOverlay = import ./overlay;
        overlays = [
          cargo2nixOverlay
          rust-overlay.overlay
        ];

        # 1. Setup nixpkgs with rust and cargo2nix overlays.
        pkgs = import nixpkgs {
          inherit system overlays;
        };

        # 2. Builds the rust package set, which contains all crates in your cargo workspace's dependency graph.
        # `makePackageSet'` accepts the following arguments:
        # - `packageFun` (required): The generated `Cargo.nix` file, which returns the whole dependency graph.
        # - `workspaceSrc` (optional): Sources for the workspace can be provided or default to the current directory.
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
        # - `hostPlatformCpu` (optional):
        #     Equivalent to rust's target-cpu codegen option. If specified "-Ctarget-cpu=<value>" will be added to the set of rust
        #     flags used for compilation of the package set.
        # - `hostPlatformFeatures` (optional):
        #     Equivalent to rust's target-feature codegen option. If specified "-Ctarget-feature=<values>" will be added to the set of rust
        #     flags used for compilation of the package set. The value should be a list of the features to be turned on, without the leading "+",
        #     e.g. `[ "aes" "sse2" "ssse3" "sse4.1" ]`.  They will be prefixed with a "+", and comma delimited before passing through to rust.
        #     Crates that check for CPU features such as the `aes` crate will be evaluated against this argument.
        rustPkgs = pkgs.rustBuilder.makePackageSet' {
          packageFun = import ./Cargo.nix;
          rustChannel = "1.56.1";
          packageOverrides = pkgs: pkgs.rustBuilder.overrides.all;
          localPatterns = [ ''^(src|tests|templates)(/.*)?'' ''[^/]*\.(rs|toml)$'' ];
        };

        # `noBuild` is a special crate set used to create a development shell
        # containing all native dependencies provided by the overrides above.
        # `cargo build` with in the shell should just work.
        devShell = pkgs.mkShell {
          inputsFrom = pkgs.lib.mapAttrsToList (_: pkg: pkg { }) rustPkgs.noBuild.workspace;
          nativeBuildInputs = [ rustPkgs.rustChannel ] ++ (with pkgs; [cacert]);
          RUST_SRC_PATH = "${rustPkgs.rustChannel}/lib/rustlib/src/rust/library";
        };

        examples = let
          cargo2nix = pkgs.lib.sourceByRegex ./. [
            ''^(overlay|src|tests|templates)(/.*)?''
            ''[^/]*\.(nix|rs|toml)$''
          ];
          importExprsInDir = with pkgs.lib; dir:
            mapAttrsToList
              (name: _: if name == "4-independent-packaging"
                        then import (dir + "/${name}")
                        else import (dir + "/${name}") { inherit cargo2nix rust-overlay; })
              (pkgs.lib.filterAttrs
                (name: kind: kind == "directory")
                (builtins.readDir dir)
              );
          in
            importExprsInDir ./examples;


      # `rustPkgs` now contains all crates in the dependency graph.
      # To build normal binaries, use `rustPkgs.<registry>.<crate>.<version> { }`.
      # To build test binaries (equivalent to `cargo build --tests`), use
      #   `rustPkgs.<registry>.<crate>.<version>{ compileMode = "test"; }`.
      # To build bench binaries (equivalent to `cargo build --benches`), use
      #   `rustPkgs.<registry>.<crate>.<version>{ compileMode = "bench"; }`.
      # For convenience, you can also refer to the crates in the workspace using
      #   `rustPkgs.workspace.<crate>`.
      #
      # When a crate is not associated with any registry, such as when building
      # locally, the registry is "unknown" as shown below:
      # rustPkgs.unknown.cargo2nix."0.9.0"
      # An example of a crates.io path:
      # rustPkgs."registry+https://github.com/rust-lang/crates.io-index".openssl."0.10.30"
      in rec {
        # We re-export the overlays here so that other projects can import them as well.
        inherit devShell overlays;

        packages = {
          inherit examples rustPkgs;
          package = rustPkgs.workspace.cargo2nix {};

          # `runTests` runs all tests for a crate inside a Nix derivation.
          # This may be problematic as Nix may restrict filesystem, network access,
          # socket creation, ... which the test binary may need.
          # If you run to those problems, build test binaries (as shown above) and run them
          # manually outside a Nix derivation.
          ci = pkgs.rustBuilder.runTests rustPkgs.workspace.cargo2nix { };
          shell = devShell;
        };

        defaultPackage = packages.package;
        overlay = cargo2nixOverlay;
      }
    );
}
