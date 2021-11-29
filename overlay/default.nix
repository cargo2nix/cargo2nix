final: prev:
let
  inherit (final) lib newScope;
  pkgs = final;
  scope = final: let inherit (final) callPackage; in
  {
    rustLib = callPackage ./lib { };

    makePackageSet = callPackage ./make-package-set/full.nix { };

    makePackageSet' = pkgs.callPackage ./make-package-set/simplified.nix { };

    mkRustCrate = import ./mkcrate.nix;

    mkRustCrateNoBuild = callPackage ./mkcrate-nobuild.nix;

    overrides = callPackage ./overrides.nix { };

    runTests = callPackage ./run-tests.nix { };

    workspaceShell = import ./workspace-shell.nix;
  };
in
{
  rustBuilder = lib.makeScope newScope scope;
}
