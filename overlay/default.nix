final: prev:
let
  inherit (final) lib newScope;
  pkgs = final;
  scope = final: let inherit (final) callPackage; in
  {
    mkLocalRegistry = callPackage ./local-registry.nix {};

    mkCrate = callPackage ./crate.nix {};

    rustLib = callPackage ./lib { };

    makePackageSet = callPackage ./make-package-set/full.nix { };

    makePackageSet' = pkgs.callPackage ./make-package-set/simplified.nix { };

    mkRustCrate = import ./mkcrate.nix;

    mkRustCrateNoBuild = callPackage ./mkcrate-nobuild.nix;

    makeShell = callPackage ./make-shell.nix;

    overrides = callPackage ./overrides.nix { };

    runTests = callPackage ./run-tests.nix { };
  };
in
{
  rustBuilder = lib.makeScope newScope scope;
}
