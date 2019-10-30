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
  ...
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

    mkRustCrate = callPackage args.mkRustCrate { inherit rustLib; config = rustPackageConfig; };
  in packageFun {
    inherit rustPackages buildRustPackages lib mkRustCrate;
    inherit (stdenv) hostPlatform;
    rustLib = rustLib // { fetchCrateLocal = path: (lib.sourceByRegex path localPatterns).outPath; };
    ${ if args ? release then "release" else null } = args.release;
    ${ if args ? rootFeatures then "rootFeatures" else null } = args.rootFeatures;
  } // {
    inherit rustPackages buildRustPackages callPackage cargo rustc pkgs mkRustCrate;
    config = rustPackageConfig;
    __splicedPackages = defaultScope;
  })
