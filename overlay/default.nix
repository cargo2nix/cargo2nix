self: super:
let
  inherit (self) callPackage lib newScope;
  scope = self: let inherit (self) callPackage; in
  {
    mkLocalRegistry = callPackage ./local-registry.nix {};

    mkDirectorySource = callPackage ./directory-source.nix {};

    mkCrate = callPackage ./crate.nix {};

    cleanLocalSrc = callPackage ./clean-local-src.nix {};

    cratesIoRegistry = callPackage ./crates-io-registry.nix {};

    rustLib = callPackage ./lib.nix { };

    makePackageSet = callPackage ./make-package-set.nix;

    mkRustCrate = import ./mkcrate.nix;

    buildRustPackages = callPackage ./build-rust-packages.nix { };

    makeShell = callPackage ./make-shell.nix;
  };
in
{
  rustBuilder = lib.makeScope newScope scope;
}
