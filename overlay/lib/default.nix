{ callPackage, pkgs }:
{
  inherit (callPackage ./features.nix { }) expandFeatures;
  inherit (callPackage ./splice.nix { }) splicePackages;
  inherit (callPackage ./fetch.nix { }) fetchCrateLocal fetchCrateGit fetchCratesIo;

  json2toml = pkgs.buildPackages.buildPackages.callPackage ./json2toml.nix { };
  toml2json = pkgs.buildPackages.buildPackages.callPackage ./toml2json.nix { };

  realHostTriple = import ./real-host-triple.nix;
}
