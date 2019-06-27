{ lib }:
with builtins; with lib;
let
  enabledFeatures = features: manifest:
    fix
      (self: super:
        let
          new-features =
            concatMap (f: manifest.features.${f} or []) super;
        in
        if length new-features > 0 then
          super ++ self new-features
        else
          super)
      features;

  pkgFeatures = features:
    let
      matcher = match "([^/]+)/([^/]+)";
      selfFeatures = filterAttrs (n: _: matcher n == null) features;
      depFeatures = filter (n: matcher n != null) (attrNames features);
      depFeaturesMap =
        map
          (n:
            let
              m = matcher n;
              dep = elemAt m 0;
              feature = elemAt m 1;
            in
            { ${dep}.${feature} = true; }
          )
          depFeatures;
    in
    foldl' recursiveUpdate selfFeatures depFeaturesMap;

  computeFinalFeatures =
    cargo-manifest: features:
      pkgFeatures (genAttrs (enabledFeatures features cargo-manifest) (_: {}));
in
computeFinalFeatures
