{
  system ? builtins.currentSystem,
  nixpkgs ? builtins.fetchTarball {
    url = https://github.com/NixOS/nixpkgs/archive/e34208e10033315fddf6909d3ff68e2d3cf48a23.tar.gz;
    sha256 = "0ngkx5ny7bschmiwc5q9yza8fdwlc3zg47avsywwp8yn96k2cpmg";
  },
  nixpkgsMozilla ? builtins.fetchTarball {
    url = https://github.com/mozilla/nixpkgs-mozilla/archive/18cd4300e9bf61c7b8b372f07af827f6ddc835bb.tar.gz;
    sha256 = "1s0d1l5y7a3kygjbibssjnj7fcc87qaa5s9k4kda0j13j9h4zwgr";
  },
  cargo2nix ? ../../.,
  rustChannel ? "1.48.0",
}:
let
  pkgs = import nixpkgs {
    inherit system;
    overlays =
      let
        rustOverlay = import "${nixpkgsMozilla}/rust-overlay.nix";
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
      rev = "cadf0e9fb630d04367ef2611383865963d84ab54";
      sha256 = "0w5q8srjhv510398ay5m3rih3nkwcf4f2grb55f1gc2kd7m6bfww";
    };

    # You can also use local paths for local development with a checked out copy
    # workspaceSrc = ../../../rust-analyzer;

    localPatterns = [ ''^(src|tests|crates|xtask|assets|templates)(/.*)?'' ''[^/]*\.(rs|toml)$'' ];
  };

in {
  rust-analyzer = (rustPkgs.workspace.rust-analyzer {}).bin;
}
