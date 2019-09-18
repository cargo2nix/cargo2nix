{
  nixpkgsPath ? <nixpkgs>,
  system ? builtins.currentSystem,
  overlays ? [],
  crossSystem ? (import <nixpkgs/lib>).systems.examples.musl64,
}:
let
  version = "0.2.0";

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

  # macos frameworks supply, if on darwin
  macosFrameworks = if pkgs.stdenv.isDarwin
    then
      with pkgs.darwin.apple_sdk.frameworks;
      [Security CoreServices]
    else [];

  # choice of rustc
  rustChannel = pkgs.buildPackages.rustChannelOf {
    channel = "1.37.0";
  };

  inherit (rustChannel) cargo;
  rustc = rustChannel.rust.override {
    targets = [
      (pkgs.rustBuilder.rustLib.realHostTriple pkgs.stdenv.targetPlatform)
      "aarch64-unknown-linux-gnu"
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
  resolver = let version' = version; in { source, name, version, ... }: {
    unknown.cargo2nix.${version'} = pkgs.rustBuilder.rustLib.cleanLocalSource srcFilter ./.;
  }.${source}.${name}.${version};

  # build your crate
  packageFun = import ./deps.nix;

  config = pkgs: {
    rustcflags = {
      "registry+https://github.com/rust-lang/crates.io-index"."*" = [
        "--cap-lints"
        "warn"
      ];
    };
    environment = {
      "registry+https://github.com/rust-lang/crates.io-index".openssl-sys."*".OPENSSL_DIR = openssl pkgs;
    };

    buildInputs = {
      unknown.cargo2nix."*" = with pkgs; [ libiconv ] ++ macosFrameworks;
      "registry+https://github.com/rust-lang/crates.io-index".cargo."*" = with pkgs; [ libiconv ] ++ macosFrameworks;
      "registry+https://github.com/rust-lang/crates.io-index".curl-sys."*" = with pkgs; [ nghttp2 ] ++ macosFrameworks;
      "registry+https://github.com/rust-lang/crates.io-index".libgit2-sys."*" = with pkgs; [ libiconv ] ++ macosFrameworks;
    };
  };

  rustPackages = pkgs.callPackage ./crate.nix {
    inherit packageFun rustc cargo resolver;
    config = config pkgs;
    buildConfig = config pkgs.buildPackages;
  };

  # done

  # your rust build is available here
  package = rustPackages.unknown.cargo2nix.${version} {
    freezeFeatures = true;
    meta.platforms = lib.platforms.darwin ++ lib.platforms.linux;
  };

  # how to use cargo2nix to speed up resolution:

  resolveResponse =
    let
      request =
        builtins.toFile
          "resolve-request.json"
          (builtins.toJSON
            (pkgs.rustBuilder.rustLib.buildResolveRequest {
              initial = [
                {
                  package-id = "cargo2nix ${version}";
                }
              ];
              inherit (pkgs) stdenv;
              inherit packageFun;
            }));
    in
    lib.importJSON
      (pkgs.runCommand
        "resolve"
        { nativeBuildInputs = [package]; }
        "cargo2nix resolve <${request} >$out");

  rustPackagesWithResolve = pkgs.callPackage ./crate.nix {
    inherit packageFun rustc cargo resolver;
    config = config pkgs // { resolve = resolveResponse; };
    buildConfig = config pkgs.buildPackages // { resolve = resolveResponse; };
  };

in
{
  inherit package;

  package' = rustPackagesWithResolve.unknown.cargo2nix.${version} {};


  # and you can make a development shell
  shell = pkgs.rustBuilder.makeShell {
    inherit packageFun cargo rustc;
    packageResolver = { source, name, version, sha256, ... }:
      {
        src = resolver { inherit source name version; };
      };
    excludeCrates.unknown = "*";
    environment.OPENSSL_DIR = openssl pkgs;
    nativeBuildInputs = [ pkgs.buildPackages.buildPackages.jq ];

    inherit (rustPackages.config) features;
  };
}
