{
  inputs = {
    cargo2nix.url = "path:../../";
    # Use the github URL for real packages
    # cargo2nix.url = "github:cargo2nix/cargo2nix/master";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs?ref=release-21.05";
  };

  outputs = { self, nixpkgs, cargo2nix, flake-utils, ... }:

    # Build the output set for each default system and map system sets into
    # attributes, resulting in paths such as:
    # nix build .#packages.x86_64-linux.<name>
    flake-utils.lib.eachDefaultSystem (system:

      # let-in expressions, very similar to Rust's let bindings.  These names
      # are used to express the output but not themselves paths in the output.
      let

        # create nixpkgs that contains rustBuilder from cargo2nix overlay
        pkgs = import nixpkgs {
          inherit system;
          overlays = [cargo2nix.overlay];
        };

        # create the workspace & dependencies package set
        rustPkgs = pkgs.rustBuilder.makePackageSet' {
          rustVersion = "1.57.0";
          packageFun = import ./Cargo.nix;
        };

      in rec {
        # this is the output (recursive) set (expressed for each system)

        # the packages in `nix build .#packages.<system>.<name>`
        packages = {
          # nix build .#hello-world
          # nix build .#packages.x86_64-linux.hello-world
          hello-world = (rustPkgs.workspace.hello-world {}).bin;
        };

        # nix build
        defaultPackage = packages.hello-world;
      }
    );
}
