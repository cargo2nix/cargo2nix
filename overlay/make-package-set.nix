args@{
  rustLib,
  pkgs,
  packageFun,
  rustPackageConfig,
  stdenv,
  lib,
  cargo,
  rustc,
  mkRustCrate,
  buildRustPackages ? null,
  localPatterns ? [ ''^(src)(/.*)?'' ''[^/]*\.(rs|toml)$'' ],
}:
lib.fix' (self:
  let
    rustPackages = self;
    buildRustPackages = if args.buildRustPackages == null then self else rustPackages;
    mkScope = scope:
      let
        prevStage = pkgs.__splicedPackages;
        scopeSpliced = rustLib.splicePackages (args.buildRustPackages != null) {
          pkgsBuildBuild = scope.buildRustPackages.buildRustPackages;
          pkgsBuildHost = scope.buildRustPackages;
          pkgsBuildTarget = {};
          pkgsHostHost = {};
          pkgsHostTarget = scope;
          pkgsTargetTarget = {};
        } // {
          inherit (scope) pkgs buildRustPackages cargo rustc config __splicedPackages;
        };
      in
        prevStage // prevStage.xorg // prevStage.gnome2 // { inherit stdenv; } // scopeSpliced;
    defaultScope = mkScope self;
    callPackage = lib.callPackageWith defaultScope;

    mkRustCrate_ =
      lib.makeOverridable
        (callPackage mkRustCrate {
          inherit rustLib;
          config = rustPackageConfig;
        });
  in packageFun {
    inherit rustPackages buildRustPackages lib;
    inherit (stdenv) hostPlatform buildPlatform;
    mkRustCrate = mkRustCrate_;
    rustLib = rustLib // { fetchCrateLocal = path: (lib.sourceByRegex path localPatterns).outPath; };
  } // {
    inherit rustPackages buildRustPackages callPackage cargo rustc pkgs;
    config = rustPackageConfig;
    mkRustCrate = mkRustCrate_;
    __splicedPackages = defaultScope;
  })
