rust-overlay:

let
  # Overlay is what provides all of Cargo2nix's modifications to nixpkgs
  cargo2nixOverlay = final: prev:
    let
      inherit (final) lib newScope;
      pkgs = final;
      scope = final:
        let
          inherit (final) callPackage;
        in
          {
            rustLib = callPackage ./lib { };

            makePackageSetInternal = callPackage ./make-package-set/internal.nix { };

            makePackageSet = pkgs.callPackage ./make-package-set/user-facing.nix { };

            mkRustCrate = import ./mkcrate.nix;

            mkRustCrateNoBuild = callPackage ./mkcrate-nobuild.nix;

            overrides = callPackage ./overrides.nix { };

            runTests = callPackage ./run-tests.nix { };

            workspaceShell = import ./workspace-shell.nix;
          };
    in
      {
        # The single top-level attribute that user-facing API's are exposed through
        rustBuilder = lib.makeScope newScope scope;
      };
in rec {
  # These three overlays are exposed in the cargo2nix flake as cargo2nix.overlays
  # The combined overlay is the most conveient to use.
  inherit rust-overlay;
  cargo2nix = cargo2nixOverlay;
  default = combined;
  combined = final: prev:
    let
      composeOverlays = overlays: final: prev:
        prev.lib.foldl' (prev.lib.flip prev.lib.extends) (prev.lib.const prev) overlays final;
    in
      composeOverlays [ rust-overlay cargo2nixOverlay ] final prev;
}
