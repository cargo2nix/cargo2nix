{
  inputs = {
    # cargo2nix.url = "path:../../../cargo2nix";
    # Use the github URL for real packages
    cargo2nix.url = "github:cargo2nix/cargo2nix?rev=2b8b9b74e23f7f509c73a044b86a4bb07aea35f3";
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

  outputs = { self, nixpkgs, cargo2nix, flake-utils, rust-overlay, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        cargo2nixOverlay = import "${cargo2nix}/overlay";
        overlays = [
          cargo2nixOverlay
          rust-overlay.overlay
        ];

        pkgs = import nixpkgs {
          inherit system overlays;
        };

        rustPkgs = pkgs.rustBuilder.makePackageSet' {
          rustChannel = "1.56.1";
          packageFun = import ./Cargo.nix;
          localPatterns = [ ''^(src|crates|xpath|tests|templates)(/.*)?'' ''[^/]*\.(rs|toml)$'' ];

          # Provide the gperfools lib for linking the final rust-analyzer binary
          packageOverrides = pkgs: pkgs.rustBuilder.overrides.all ++ [
            (pkgs.rustBuilder.rustLib.makeOverride {
              name = "rust-analyzer";
              overrideAttrs = drv: {
                propagatedNativeBuildInputs = drv.propagatedNativeBuildInputs or [ ] ++ [
                  pkgs.gperftools
                ];
              };
            })
          ];

          workspaceSrc = pkgs.fetchFromGitHub {
            owner = "rust-analyzer";
            repo = "rust-analyzer";
            rev = "2c0f433fd2e838ae181f87019b6f1fefe33c6f54";
            sha256 = "sha256-nqRK5276uTKOfwd1HAp4iOucjka651MkOL58qel8Hug=";
          };
          # You can also use local paths for local development with a checked out copy
          # workspaceSrc = ../../../upstream/rust-analyzer;
        };

      in rec {
        packages = {
          rust-analyzer = (rustPkgs.workspace.rust-analyzer {}).bin;
        };

        defaultPackage = packages.rust-analyzer;
      }
    );
}
