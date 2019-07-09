{
  rustLib,
  pkgs,
  packageFun,
  rustPackageConfig,
  stdenv,
  lib,
  cargo,
  rustc,
  mkRustCrate,
  buildRustPackages ? null
}:
lib.fix' (self:
  let
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

    mkRustCrate_ =
      lib.makeOverridable
        (callPackage mkRustCrate {
          inherit rustLib;
          config = rustPackageConfig;
        });
  in
  packageFun
    {
      inherit pkgs stdenv callPackage rustLib;
      mkRustCrate = mkRustCrate_;
      config = rustPackageConfig;
    }
    self //
  {
    inherit callPackage buildRustPackages cargo rustc pkgs;
    rustPackages = self;
    config = rustPackageConfig;
    mkRustCrate = mkRustCrate_;
    __splicedPackages = defaultScope;
  })
