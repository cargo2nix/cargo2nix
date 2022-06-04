{ callPackage, pkgs }:
{
  inherit (callPackage ./features.nix { }) expandFeatures;
  inherit (callPackage ./splice.nix { }) splicePackages;
  inherit (callPackage ./fetch.nix { }) fetchCrateLocal fetchCrateGit fetchCratesIo fetchCrateAlternativeRegistryExpensive;
  inherit (import ./profiles.nix) decideProfile genDrvsByProfile;
  inherit (import ./overrides.nix) makeOverride combineOverrides runOverride nullOverride;

  rustTriple = import ./rust-triple.nix;
}
