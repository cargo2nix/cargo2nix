{ lib }:
extraFilter:
let
  extraFilter' = if extraFilter == null then (_: true) else extraFilter;
in
src:
assert builtins.pathExists src;
let
  isTargetSrc = base: name: type:
    type == "directory" && name == "${toString base}/target";
  isCargoHome = base: name: type:
    type == "directory" && name == "${toString base}/.cargo";
  cleanedSrc = lib.cleanSourceWith {
    inherit src;
    filter = name: type:
      lib.cleanSourceFilter name type &&
      ! isTargetSrc src name type &&
      ! isCargoHome src name type &&
      extraFilter' {
        inherit src name type;
      };
  };
in
cleanedSrc.outPath
