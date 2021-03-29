{
  system ? builtins.currentSystem,
  rust-overlay ? builtins.fetchTarball {
    url = https://github.com/oxalica/rust-overlay/archive/a9309152e39974309a95f3350ccb1337734c3fe5.tar.gz;
    sha256 = "04428wpwc5hyaa4cvc1bx52i9m62ipavj0y7qs0h9cq9a7dl1zki";
  },
  cargo2nix ? builtins.fetchGit {
    url = https://github.com/cargo2nix/cargo2nix;
    rev = "4bbd3137ff1422ef3565748eae33efe6e2ffbf39";
  },
}:
let
  rustOverlay = import rust-overlay;
  cargo2nixOverlay = import "${cargo2nix}/overlay";

  pkgs = import <nixpkgs> {
    inherit system;
    overlays = [ cargo2nixOverlay rustOverlay ];
  };

  rustPkgs = pkgs.rustBuilder.makePackageSet' {
    rustChannel = "1.50.0";
    packageFun = import ./Cargo.nix;
  };
in
  rustPkgs.workspace.hello-world {}
