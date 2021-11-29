{
  inputs = {
    cargo2nix.url = "path:../../";
    # Use the github URL for real packages
    # cargo2nix.url = "github:cargo2nix/cargo2nix?rev=1de0ee0a0a7396c09b17cae1d90862490bcd4b67";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
    rust-overlay.inputs.flake-utils.follows = "flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs?ref=release-21.05";
    rust-analyzer-src = {
      url = "github:rust-analyzer/rust-analyzer?rev=2c0f433fd2e838ae181f87019b6f1fefe33c6f54";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, cargo2nix, flake-utils, rust-overlay, rust-analyzer-src, ... }:

    # Build the output set for each default system, resulting in paths such as:
    # nix build .#pkgs.x86_64-linux.<name>
    flake-utils.lib.eachDefaultSystem (system:
      let

        # create nixpkgs that contains rustBuilder from cargo2nix overlay
        pkgs = import nixpkgs {
          inherit system;
          overlays = [(import "${cargo2nix}/overlay")
                      rust-overlay.overlay];
        };

        # create the workspace & dependencies package set
        rustPkgs = pkgs.rustBuilder.makePackageSet' {
          # rust toolchain version
          rustChannel = "1.56.1";
          # nixified Cargo.lock
          packageFun = import ./Cargo.nix;

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

          workspaceSrc = rust-analyzer-src;
          # You can also use local paths for local development with a checked out copy
          # workspaceSrc = ../../../upstream/rust-analyzer;
        };

      in rec {
        packages = {
          # nix build .#rust-analyzer
          rust-analyzer = (rustPkgs.workspace.rust-analyzer {}).bin;
        };

        # nix build
        defaultPackage = packages.rust-analyzer;
      }
    );
}
