{
  pkgs,
  lib,
  rustLib,
  stdenv,
  mkRustCrate,
}:
{
  packageFun,
  cargo,
  rustc,
  buildRustPackages ? null,
  localPatterns ? [ ''^(src)(/.*)?'' ''[^/]*\.(rs|toml)$'' ],
  packageOverrides ? [ ],
  release ? null,
  rootFeatures ? null,
}:
lib.fix' (self:
  let
    rustPackages = self;
    buildRustPackages' = if buildRustPackages == null then self else buildRustPackages;
    mkScope = scope:
      let
        prevStage = pkgs.__splicedPackages;
        scopeSpliced = rustLib.splicePackages (buildRustPackages != null) {
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

    mkRustCrate' = lib.makeOverridable (callPackage mkRustCrate { inherit rustLib; });
  in packageFun {
    inherit rustPackages lib;
    inherit (stdenv) hostPlatform;
    buildRustPackages = buildRustPackages';
    mkRustCrate =
      let
        combinedOverride = builtins.foldl'
          rustLib.combineOverrides
          (_: { overrideArgs = null; overrideAttrs = null; })
          packageOverrides;
      in
        rustLib.runOverride combinedOverride mkRustCrate';
    rustLib = rustLib // { fetchCrateLocal = path: (lib.sourceByRegex path localPatterns).outPath; };
    ${ if release == null then null else "release" } = release;
    ${ if rootFeatures == null then null else "rootFeatures" } = rootFeatures;
  } // {
    inherit rustPackages callPackage cargo rustc pkgs;
    mkRustCrate = mkRustCrate';
    buildRustPackages = buildRustPackages';
    __splicedPackages = defaultScope;
  })
