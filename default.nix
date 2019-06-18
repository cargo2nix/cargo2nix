{
  nixpkgsPath ? <nixpkgs>,
  system ? builtins.currentSystem,
  overlays ? [],
  crossSystem ? null,
}:
let

  nixpkgs-mozilla = builtins.fetchGit {
    url = https://github.com/mozilla/nixpkgs-mozilla;
    ref = "master";
    rev = "50bae918794d3c283aeb335b209efd71e75e3954";
  };
  rustOverlay = import "${nixpkgs-mozilla}/rust-overlay.nix";

  pkgs = import nixpkgsPath {
    inherit system crossSystem;
    overlays = overlays ++ [ rustOverlay (import ./overlay) ];
  };

  inherit (pkgs) lib;

  srcFilter = {src, name, type}:
    (type == "directory" && name == "${toString src}/overlay" -> false) &&
    (name == "${toString src}/.git" -> false) &&
    (name == "${toString src}/.gitignore" -> false) &&
    (type == "file" && lib.hasSuffix ".nix" (baseNameOf name) -> false)
  ;

  openssl = pkgs.symlinkJoin {
    name = "openssl";
    paths = with pkgs.openssl; [out dev];
  };

  rustChannel = pkgs.rustChannelOf {
    channel = "1.35.0";
  };

  inherit (rustChannel) cargo;
  rustc = rustChannel.rust;

  rustPackages = pkgs.callPackage ./crate.nix {
    inherit rustc cargo;
    packageFun = import ./deps.nix;
    config = {
      rustcflags = {
        "registry+https://github.com/rust-lang/crates.io-index".failure."0.1.5" = [
          "--cap-lints"
          "warn"
        ];
      };
      environment = {
        "registry+https://github.com/rust-lang/crates.io-index".openssl-sys."*".OPENSSL_DIR = openssl;
      };

      buildInputs = {
        "registry+https://github.com/rust-lang/crates.io-index".curl-sys."*" = with pkgs; [ nghttp2 ];
      };
    };
    resolver = { source, name, version, ... }: {
      unknown.cargo2nix."0.1.0" = pkgs.rustBuilder.rustLib.cleanLocalSource srcFilter ./.;
    }.${source}.${name}.${version};
  };
in
rustPackages.unknown.cargo2nix."0.1.0"
