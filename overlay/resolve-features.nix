{ pkgName, pkgVersion, pkgRegistry, lib, resolveFeatures }:
with builtins; with lib;
root:
let
  inherit (root.passthru) package-id;
  depsFeatureMap =
    map
      resolveFeatures
      (
        attrValues root.passthru.dependencies ++
        attrValues root.passthru.buildDependencies ++
        attrValues root.passthru.devDependencies
      );
in
foldl'
  recursiveUpdate
  {
    ${root.stdenv.hostPlatform.config}
    .${pkgRegistry package-id}
    .${pkgName package-id}
    .${pkgVersion package-id} = root.passthru.features;
  }
  depsFeatureMap
