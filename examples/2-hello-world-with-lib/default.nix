{
  nixpkgs ? builtins.fetchTarball {
    url = https://github.com/NixOS/nixpkgs/archive/47b551c6a854a049045455f8ab1b8750e7b00625.tar.gz;
    sha256 = "0p0p6gf3kimcan4jgb4im3plm3yw68da09ywmyzhak8h64sgy4kg";
  },
  nixpkgsMozilla ? builtins.fetchTarball {
    url = https://github.com/mozilla/nixpkgs-mozilla/archive/50bae918794d3c283aeb335b209efd71e75e3954.tar.gz;
    sha256 = "07b7hgq5awhddcii88y43d38lncqq9c8b2px4p93r5l7z0phv89d";
  },
  cargo2nix ? builtins.fetchTarball {
    url = https://github.com/tenx-tech/cargo2nix/archive/v0.8.0.tar.gz;
    sha256 = "1qmfijg6l4v3wrlhppv1ayllxlhag7y97xiyh9ihvgjsz4pbcb7b";
  },
  system ? builtins.currentSystem,
  overlays ? [ ],
  crossSystem ? null,
}:
let
  pkgs = import nixpkgs {
    inherit system crossSystem;
    overlays =
      let
        rustOverlay = import "${nixpkgsMozilla}/rust-overlay.nix";
        cargo2nixOverlay = import "${cargo2nix}/overlay";
      in
        overlays ++ [ cargo2nixOverlay rustOverlay ];
  };

  rustPkgs = pkgs.rustBuilder.makePackageSet' {
    rustChannel = "stable";
    packageFun = import ./Cargo.nix;
    packageOverrides = pkgs: pkgs.rustBuilder.overrides.all;
  };
in
  rec {
    inherit rustPkgs;
    package = rustPkgs.workspace.hello-world-with-lib { };
    ci = pkgs.rustBuilder.runTests rustPkgs.workspace.hello-world-with-lib { };
    shell = pkgs.mkShell {
      inputsFrom =  pkgs.lib.mapAttrsToList (_: pkg: pkg { }) rustPkgs.noBuild.workspace;
      nativeBuildInputs = with rustPkgs; [ cargo rustc ];
    };
  }
