{ callPackage, pkgs }:
{
  inherit (callPackage ./features.nix { }) expandFeatures;
  inherit (callPackage ./splice.nix { }) splicePackages;
  inherit (callPackage ./fetch.nix { }) fetchCrateLocal fetchCrateGit fetchCratesIo fetchCrateAlternativeRegistryExpensive;
  inherit (callPackage ./profiles.nix { }) decideProfile genDrvsByProfile;
  inherit (callPackage ./overrides.nix { }) makeOverride combineOverrides runOverride nullOverride;
  rustLinksToNixpkgs = import ./links.nix;
  rustTriple = import ./rust-triple.nix;
}
