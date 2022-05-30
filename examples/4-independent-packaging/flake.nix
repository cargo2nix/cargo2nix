{
  inputs = {
    cargo2nix.url = "path:../../";
    # Use a github flake URL for real packages
    # cargo2nix.url = "github:cargo2nix/cargo2nix/release-0.11.0";
    flake-utils.follows = "cargo2nix/flake-utils";
    nixpkgs.follows = "cargo2nix/nixpkgs";
    rust-analyzer-src = {
      url = "github:rust-lang/rust-analyzer/?rev=f94fa62d69faf5bd63b3772d3ec4f0c76cf2db57";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, cargo2nix, flake-utils, rust-analyzer-src, ... }:

    # Build the output set for each default system, resulting in paths such as:
    # nix build .#pkgs.x86_64-linux.<name>
    flake-utils.lib.eachDefaultSystem (system:
      let

        # create nixpkgs that contains rustBuilder from cargo2nix overlay
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ cargo2nix.overlay ];
        };

        # create the workspace & dependencies package set
        rustPkgs = pkgs.rustBuilder.makePackageSet {
          # rust toolchain version
          rustVersion = "1.61.0";
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
