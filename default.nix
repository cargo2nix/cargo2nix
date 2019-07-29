{
  nixpkgsPath ? <nixpkgs>,
  system ? builtins.currentSystem,
  overlays ? [],
  crossSystem ? null,
}:
let

  # mozilla nixpkgs rust overlay
  nixpkgs-mozilla = builtins.fetchGit {
    url = https://github.com/mozilla/nixpkgs-mozilla;
    ref = "master";
    rev = "50bae918794d3c283aeb335b209efd71e75e3954";
  };
  rustOverlay = import "${nixpkgs-mozilla}/rust-overlay.nix";

  # bootstrap Nixpkgs with the overlays
  pkgs = import nixpkgsPath {
    inherit system crossSystem;
    overlays = overlays ++ [ rustOverlay (import ./overlay) ];
  };

  inherit (pkgs) lib;

  # openssl supply
  openssl =
    pkgs:
      pkgs.buildPackages.symlinkJoin {
        name = "openssl";
        paths = with pkgs.openssl; [out dev];
      };


  # choice of rustc
  rustChannel = pkgs.buildPackages.rustChannelOf {
    channel = "1.36.0";
  };

  inherit (rustChannel) cargo;
  rustc = rustChannel.rust.override {
    targets = [
      (pkgs.rustBuilder.rustLib.realHostTriple pkgs.stdenv.targetPlatform)
    ];
  };

  # source filter
  srcFilter = {src, name, type}:
    (type == "directory" && name == "${toString src}/overlay" -> false) &&
    (type == "regular" && lib.hasSuffix ".nix" (baseNameOf name) -> false) &&
    (type == "regular" && lib.hasPrefix "." (baseNameOf name) -> false) &&
    (type == "symlink" && lib.hasPrefix "${toString src}/result" name -> false) &&
    (type == "unknown" -> false)
  ;

  # define source location
  resolver = { source, name, version, ... }: {
    unknown.cargo2nix."0.1.0" = pkgs.rustBuilder.rustLib.cleanLocalSource srcFilter ./.;
  }.${source}.${name}.${version};

  # build your crate
  packageFun = import ./deps.nix;

  config = pkgs: {
    rustcflags = {
      "registry+https://github.com/rust-lang/crates.io-index".failure."0.1.5" = [
        "--cap-lints"
        "warn"
      ];
    };
    environment = {
      "registry+https://github.com/rust-lang/crates.io-index".openssl-sys."*".OPENSSL_DIR = openssl pkgs;
    };

    buildInputs = {
      "registry+https://github.com/rust-lang/crates.io-index".curl-sys."*" = with pkgs; [ nghttp2 ];
    };
  };
  rustPackages = pkgs.callPackage ./crate.nix {
    inherit packageFun rustc cargo resolver;
    config = config pkgs;
    buildConfig = config pkgs.buildPackages;
  };

  # done

in
{
  # your rust build is available here
  package = rustPackages.unknown.cargo2nix."0.1.0";

  # and you can make a development shell
  shell = pkgs.rustBuilder.makeShell {
    inherit packageFun cargo rustc;
    packageResolver = { source, name, version, sha256, ... }:
      {
        src = resolver { inherit source name version; };
      };
    excludeCrates.unknown = "*";
    environment.OPENSSL_DIR = openssl pkgs;

    inherit (rustPackages.config) features;
  };
}
