self: super:
let
  inherit (self) lib newScope;
  scope = self: let inherit (self) callPackage; in
  {
    mkLocalRegistry = callPackage ./local-registry.nix {};

    mkCrate = callPackage ./crate.nix {};

    cleanLocalSrc = callPackage ./clean-local-src.nix {};

    rustLib = callPackage ./lib { };

    makePackageSet = callPackage ./make-package-set.nix;

    mkRustCrate = import ./mkcrate.nix;

    buildRustPackages = callPackage ./build-rust-packages.nix { };

    makeShell = callPackage ./make-shell.nix;
  };
in
{
  rustBuilder = lib.makeScope newScope scope;
}
