{
  inputs = {
    cargo2nix.url = "path:../../";
    # Use the github URL for real packages
    # cargo2nix.url = "github:cargo2nix/cargo2nix/master";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/master";
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

          # crossSystem = {
          #   config = "aarch64-unknown-linux-gnu";
          # };


          # crossSystem = {
          #   config = "x86_64-unknown-linux-musl";
          # };

          crossSystem = {
            config = "wasm32-unknown-wasi";
            # Nixpkgs currently only supports LLVM lld linker for wasm32-wasi.
            useLLVM = true;
          };

          overlays = [ cargo2nix.overlay ];
        };

        # create the workspace & dependencies package set
        rustPkgs = pkgs.rustBuilder.makePackageSet' {
          rustVersion = "1.56.1";
          packageFun = import ./Cargo.nix;

          # If your specific build target requires a difference between Rust and
          # nixpkgs, set this target
          # target = "aarch64-unknown-linux-gnu";
          # target = "x86_64-unknown-linux-musl";
          # target = "wasm32-wasi";
        };

      in rec {
        # this is the output (recursive) set (expressed for each system)

        # the packages in `nix build .#packages.<system>.<name>`
        packages = {
          # nix build .#cross-compiling
          # nix build .#packages.x86_64-linux.cross-compiling
          cross-compiling = (rustPkgs.workspace.cross-compiling {}).bin;
        };

        # nix build
        defaultPackage = packages.cross-compiling;
      }
    );
}
