{
  system ? builtins.currentSystem,
  nixpkgs ? builtins.fetchTarball {
    url = https://github.com/NixOS/nixpkgs/archive/e34208e10033315fddf6909d3ff68e2d3cf48a23.tar.gz;
    sha256 = "0ngkx5ny7bschmiwc5q9yza8fdwlc3zg47avsywwp8yn96k2cpmg";
  },
  rust-overlay ? builtins.fetchTarball {
    url = https://github.com/oxalica/rust-overlay/archive/a9309152e39974309a95f3350ccb1337734c3fe5.tar.gz;
    sha256 = "04428wpwc5hyaa4cvc1bx52i9m62ipavj0y7qs0h9cq9a7dl1zki";
  },
  cargo2nix ? ../../.,
  rustChannel ? "1.50.0",
}:
let
  pkgs = import nixpkgs {
    inherit system;
    overlays =
      let
        rustOverlay = import rust-overlay;
        cargo2nixOverlay = import "${cargo2nix}/overlay";
      in
        [ cargo2nixOverlay rustOverlay ];
  };

  rustPkgs = pkgs.rustBuilder.makePackageSet' {
    inherit rustChannel;
    packageFun = import ./Cargo.nix;

    workspaceSrc = pkgs.fetchFromGitHub {
      owner = "rust-analyzer";
      repo = "rust-analyzer";
      rev = "5ba7852cf153688d5b5035a9a2a2145aa7334d79";
      sha256 = "150gydm0mg72bbhgjjks8qc5ldiqyzhai9z4yfh4f1s2bwdfh3yf";
    };

    # You can also use local paths for local development with a checked out copy
    # workspaceSrc = ../../../rust-analyzer;
  };

in {
  rust-analyzer = (rustPkgs.workspace.rust-analyzer {}).bin;
}
