{
  cargo,
  rustc,

  config,
  lib,
  pkgs,
  buildPackages,
  rustLib,
  rustPackages,
  stdenv,

  # custom target triple
  target ? null,
}:
{
  src,
  package-id,
  cargo-manifest,

  buildInputs ? [],
  dependencies ? [],
  features ? [],
  nativeBuildInputs ? [],
}:
{
  panic-strategy ? null,
  doCheck ? false,

  # profile is either release or dev
  profile ? "release",

  # optimization hint: feature flags are maximal, so there is no need to resolve further
  freezeFeatures ? false,
  meta ? {},
}:
with builtins; with lib;
let
  dependencies' = dependencies;
  hasResolve = config ? resolve;

  profile' = if doCheck then "test" else profile;
  default-panic-strategy =
    if doCheck || profile == "test" || profile == "bench" then
      "unwind"
    else
      cargo-manifest.profile.${profile'}.panic or "unwind";
  panic-strategy' =
    if panic-strategy == null then
      default-panic-strategy
    else
      panic-strategy;

  origFeatures = features;

  inherit (rustLib) pkgName pkgVersion pkgRegistry computeFinalFeatures realHostTriple;

  accessPackage = pkg-id:
    rustPackages
      .${pkgRegistry pkg-id}
      .${pkgName pkg-id}
      .${pkgVersion pkg-id};

  name = pkgName package-id;
  version = pkgVersion package-id;
  registry = pkgRegistry package-id;

  accessConfig = type: default: id:
    let
      name = pkgName id;
      version = pkgVersion id;
      registry = pkgRegistry id;
      all = config."*" or default;
      reg = config.${type}.${registry}."*" or default;
      crate = config.${type}.${registry}.${name}."*" or default;
      ver = config.${type}.${registry}.${name}.${version} or default;
    in
      if isAttrs all && isAttrs reg && isAttrs crate && isAttrs ver then
        recursiveUpdate all (recursiveUpdate reg (recursiveUpdate crate ver))
      else if isList all && isList reg && isList crate && isList ver then
        all ++ reg ++ crate ++ ver
      else if isString all && isString reg && isString crate && isString ver then
        all + reg + crate + ver
      else
        throw "do not know how to merge global, registry, crate and version config values";

  environment = accessConfig "environment" {} package-id;

  env-setup =
    let
      mapToEnv = key: val:
        "export ${key}=${escapeShellArg val}";
    in
    concatStringsSep
      "\n"
      (mapAttrsToList mapToEnv environment);

  features' = features ++ attrNames (accessConfig "features" {} package-id);
in
let
  features = features';
  panic-strategy = panic-strategy';

  patchManifest = let profile' = profile; in final-features: panic-strategy: manifest:
    let
      # https://doc.rust-lang.org/cargo/reference/manifest.html#rules
      packageToFeature = name: def:
        optionalAttrs def.optional or false { ${name} = []; };
      featureExt = xs: foldl' (a: b: a // b) {} (flatten xs);
      sanitized-features =
        mapAttrs
          (f: fs: filter (f: match "[^/]+/[^/]+" f == null) fs)
          (manifest.features or {});
      features =
        mapAttrs (_: _: []) final-features //
        sanitized-features //
        featureExt [
          (mapAttrsToList packageToFeature (manifest.dependencies or {}))
          (mapAttrsToList packageToFeature (manifest.build-dependencies or {}))
          (mapAttrsToList packageToFeature (manifest.dev-dependencies or {}))
          (mapAttrsToList
            (_: deps: [
              (mapAttrsToList packageToFeature (deps.dependencies or {}))
              (mapAttrsToList packageToFeature (deps.build-dependencies or {}))
              (mapAttrsToList packageToFeature (deps.dev-dependencies or {}))
            ])
            (manifest.target or {}))
        ] //
        { default = []; };
      profile = recursiveUpdate manifest.profile or {} {
        ${profile'}.panic = panic-strategy;
      };
    in
    intersectAttrs
      { package = true; lib = true; bin = true; }
      manifest //
    {
      inherit features profile;
    };

  final-features =
    if hasResolve then
      genAttrs config.resolve.features.${package-id} or [] (_: {})
    else if freezeFeatures then
      genAttrs features (_: {})
    else
      computeFinalFeatures cargo-manifest features;

  activatedPackages = features: specs: pkg-ids:
    let
      isActivated = pkg-name:
        any
          (spec:
            spec ? ${pkg-name} &&
            (spec.${pkg-name}.optional or false -> features ? ${pkg-name}))
          specs;
      activating-packages =
        filter
          (pkg: any isActivated pkg.toml-names)
          pkg-ids;
      pkgFeatures = pkg:
        let
          featuresToApply =
            concatMap
              (pkg-name:
                attrNames features.${pkg-name} or {} ++
                concatMap
                  (spec:
                    optionals
                      (spec.${pkg-name}.optional or false -> features ? ${pkg-name})
                      spec.${pkg-name}.features or [])
                  specs)
              pkg.toml-names;
          use-default-features =
            any
              (pkg-name:
                (features.${pkg-name} or {}) ? default ||
                any
                  (spec:
                    spec ? ${pkg-name} &&
                    spec.${pkg-name}.default-features or true)
                  specs)
              pkg.toml-names;
        in
        optional use-default-features "default" ++
        featuresToApply;
    in
    listToAttrs
      (map
        (pkg: {
          name = pkg.extern-name;
          value = {
            inherit (pkg) package-id;
            drv = accessPackage pkg.package-id;
            features = pkgFeatures pkg;
          };
        })
        activating-packages);

  getDepSpecs = type: platform: manifest:
    [ manifest.${type} or {} ] ++
    flatten
      (mapAttrsToList
        (pred: specset:
          optional
            (pred == realHostTriple platform || rustLib.parseCfg pred platform)
            specset.${type} or {})
        manifest.target or {});

  depPkgs =
    final-features:
    activatedPackages
      final-features
      (getDepSpecs
        "dependencies"
        ((if isNull target then stdenv.hostPlatform else target) // { crate-features = final-features; })
        cargo-manifest)
      dependencies;
  buildDepPkgs =
    final-features:
    activatedPackages
      final-features
      (getDepSpecs
        "build-dependencies"
        (stdenv.buildPlatform // { crate-features = final-features; })
        cargo-manifest)
      dependencies;
  devDepPkgs =
    final-features:
    activatedPackages
      final-features
      (getDepSpecs
        "dev-dependencies"
        ((if isNull target then stdenv.hostPlatform else target) // { crate-features = final-features; })
        cargo-manifest)
      dependencies;

  wrapper = rustpkg: pkgs.writeScriptBin rustpkg ''
    #!${stdenv.shell}
    . ${./utils.sh}
    isBuildScript=
    args=("$@")
    for i in "''${!args[@]}"; do
      if [ "xmetadata=" = "x''${args[$i]::9}" ]; then
        args[$i]=metadata=$NIX_RUST_METADATA
      elif [ "x--crate-name" = "x''${args[$i]}" ] && [ "xbuild_script_" = "x''${args[$i+1]::13}" ]; then
        isBuildScript=1
      fi
    done
    if [ "$isBuildScript" ]; then
      args+=($NIX_RUST_BUILD_LINK_FLAGS)
    else
      args+=($NIX_RUST_LINK_FLAGS)
    fi
    touch invoke.log
    echo "''${args[@]}" >>invoke.log
    exec ${rustc}/bin/${rustpkg} "''${args[@]}"
  '';

  nativeDrv = drv: drv.nativeDrv or drv;
  crossDrv = drv: drv.crossDrv or drv;

  isProcMacro = cargo-manifest.lib.proc-macro or cargo-manifest.lib.proc_macro or false;

  ccForBuild="${buildPackages.stdenv.cc}/bin/${buildPackages.stdenv.cc.targetPrefix}cc";
  cxxForBuild="${buildPackages.stdenv.cc}/bin/${buildPackages.stdenv.cc.targetPrefix}c++";
  targetPrefix = target.targetPrefix or stdenv.cc.targetPrefix;
  cc = target.cc or stdenv.cc;
  ccForHost="${cc}/bin/${targetPrefix}cc";
  cxxForHost="${cc}/bin/${targetPrefix}c++";
in
let
  selectPlatform = pkg:
    if pkg.isProcMacro or false then
      nativeDrv pkg
    else
      crossDrv pkg;

  computeDependencies =
    final-features:
    let
      dependencies =
        mapAttrs
          (_: pkg:
            pkg // {
              drv = selectPlatform (pkg.drv {
                inherit freezeFeatures profile meta;
                panic-strategy =
                  if (pkg.drv {}).isProcMacro then
                    "unwind"
                  else if panic-strategy == null then
                    default-panic-strategy
                  else
                    panic-strategy;
              });
            })
          (depPkgs final-features);
      buildDependencies =
        mapAttrs
          (_: pkg:
            pkg // {
              drv = nativeDrv (pkg.drv {
                inherit freezeFeatures profile meta;
                panic-strategy = "unwind";
              });
            })
          (buildDepPkgs final-features);
      devDependencies =
        mapAttrs
          (_: pkg:
            pkg // {
              drv = selectPlatform (pkg.drv {
                inherit freezeFeatures profile meta;
                panic-strategy =
                  if (pkg.drv {}).isProcMacro then
                    "unwind"
                  else if panic-strategy == null then
                    default-panic-strategy
                  else
                    panic-strategy;
              });
            })
          (optionalAttrs doCheck (devDepPkgs final-features));
    in
      {
        inherit dependencies buildDependencies devDependencies;
      };

  host-triple =
    if target == null then
      realHostTriple stdenv.hostPlatform
    else
      realHostTriple target;

  computePackageFeatures =
    features:
    let
      final-features = computeFinalFeatures cargo-manifest features;
      inherit (computeDependencies final-features) dependencies buildDependencies devDependencies;
      all-deps = attrValues dependencies ++ attrValues buildDependencies ++ attrValues devDependencies;
    in
    foldl recursiveUpdate {
      ${host-triple}
      .${pkgRegistry package-id}
      .${pkgName package-id}
      .${pkgVersion package-id} = final-features;
    } (map (dep: dep.drv.passthru.computePackageFeatures dep.features) all-deps);

  final-dependencies =
    let
      findMatchingPackage =
        pkg-id:
        findFirst
          (d: d.package-id == pkg-id)
          null
          dependencies';
      takeResolvedPackage =
        pkg-id:
        let
          pkg = findMatchingPackage pkg-id;
          name = pkg.extern-name;
        in
          {
            inherit name;
            value = {
              inherit (pkg) package-id;
              drv = accessPackage pkg-id;
              features = config.resolve.features.${pkg-id};
            };
          };
      dependencies =
        listToAttrs
          (map
            (pkg-id:
              let
                inherit (takeResolvedPackage pkg-id) name value;
                inherit (value) drv;
              in
                {
                  inherit name;
                  value = {
                    inherit (value) package-id features;
                    drv = selectPlatform (drv {
                      inherit freezeFeatures profile meta;
                      panic-strategy =
                        if (drv {}).isProcMacro then
                          "unwind"
                        else if panic-strategy == null then
                          default-panic-strategy
                        else
                          panic-strategy;
                    });
                  };
                }
            )
            config.resolve.dependencies.${package-id}.${host-triple} or []);
      buildDependencies =
        listToAttrs
          (map
            (pkg-id:
              let
                inherit (takeResolvedPackage pkg-id) name value;
                inherit (value) drv;
              in
                {
                  inherit name;
                  value = {
                    inherit (value) package-id features;
                    drv = nativeDrv (drv {
                      inherit freezeFeatures profile meta;
                      panic-strategy = "unwind";
                    });
                  };
                }
            )
            config.resolve.buildDependencies.${package-id}.${host-triple} or []);

      devDependencies = optionalAttrs doCheck (
        listToAttrs
          (map
            (pkg-id:
              let
                inherit (takeResolvedPackage pkg-id) name value;
                inherit (value) drv;
              in
                {
                  inherit name;
                  value = {
                    inherit (value) package-id features;
                    drv = selectPlatform (drv {
                      inherit freezeFeatures profile meta;
                      panic-strategy =
                        if (drv {}).isProcMacro then
                          "unwind"
                        else if panic-strategy == null then
                          default-panic-strategy
                        else
                          panic-strategy;
                    });
                  };
                }
            )
            config.resolve.devDependencies.${package-id}.${host-triple} or []));

    in
    if hasResolve then
      {
        inherit dependencies buildDependencies devDependencies;
      }
    else
      computeDependencies final-features;

  inherit (final-dependencies) dependencies buildDependencies devDependencies;

  patched-manifest = patchManifest final-features panic-strategy cargo-manifest;

  depMapToList =
    deps:
    flatten
      (sort
        (a: b: elemAt a 0 < elemAt b 0)
        (mapAttrsToList
          (name: value: [ name "${value.drv}" ])
          deps));
in
let
  buildRelease = ''
    cargo build -vvv --release --target ${host-triple} --features "$features"
  '';

  buildDev = ''
    cargo build -vvv --release --target ${host-triple} --features "$features"
  '';

  buildReleaseTest = ''
    cargo build -vvv --tests --release --target ${host-triple} --features "$features"
  '';

  buildDevTest = ''
    cargo build -vvv --tests --target ${host-triple} --features "$features"
  '';

  drvAttrs = {
    name = "crate-${name}-${version}";
    inherit src version meta;
    crateName = cargo-manifest.lib.name or (replaceChars ["-"] ["_"] name);
    buildInputs =
      sort
        (a: b: "${a}" < "${b}")
        (map accessPackage buildInputs ++
         accessConfig "buildInputs" [] package-id ++
         optional (!isNull target.buildInputs or null) target.buildInputs or []);
    nativeBuildInputs =
      sort
        (a: b: "${a}" < "${b}")
        ([ buildPackages.jq cargo buildPackages.pkg-config ] ++
         map accessPackage nativeBuildInputs ++
         accessConfig "nativeBuildInputs" [] package-id ++
         optional (!isNull target.nativeBuildInputs or null) target.nativeBuildInputs or []);

    passthru = {
      inherit
        buildDependencies
        cargo-manifest
        dependencies
        devDependencies
        isProcMacro
        package-id
        panic-strategy
        patched-manifest
        computePackageFeatures
        ;
      features = final-features;
      shell = pkgs.mkShell (removeAttrs drvAttrs ["src"]);
    };

    dependencies = depMapToList dependencies;
    buildDependencies = depMapToList buildDependencies;
    devDependencies = depMapToList devDependencies;

    features = sort (a: b: a < b) (attrNames final-features);
    isProcMacro = optionalString isProcMacro "1";

    extraRustcFlags = accessConfig "rustcflags" [] package-id;

    shellHook = env-setup;

    # HACK: 2019-08-01: wasm32-wasi always uses `wasm-ld`
    configureCargo = ''
      mkdir -p .cargo
      cat > .cargo/config <<'EOF'
      [target."${realHostTriple stdenv.buildPlatform}"]
      linker = "${ccForBuild}"
    '' + optionalString (stdenv.buildPlatform != stdenv.hostPlatform && !stdenv.hostPlatform.isWasi && isNull target) ''
      [target."${host-triple}"]
      linker = "${ccForHost}"
    '' + ''
      EOF
    '';

    overrideCargoManifest = ''
      echo [[package]] > Cargo.lock
      echo name = \"${name}\" >> Cargo.lock
      echo version = \"${version}\" >> Cargo.lock
      echo source = \"registry+${registry}\" >> Cargo.lock
      cp ${rustLib.json2toml patched-manifest} Cargo.toml
    '';

    configurePhase =
      ''
        runHook preConfigure
        runHook configureCargo
        runHook postConfigure
      '';

    runCargo = ''
      (
        ${env-setup}
        set -euo pipefail
        env \
          "CC_${stdenv.buildPlatform.config}"="${ccForBuild}" \
          "CXX_${stdenv.buildPlatform.config}"="${cxxForBuild}" \
          "CC_${host-triple}"="${ccForHost}" \
          "CXX_${host-triple}"="${cxxForHost}" \
          "''${depKeys[@]}" \
    '' +
    (if profile == "release" then
      if doCheck then
        buildReleaseTest
      else
        buildRelease
     else if profile == "dev" then
       if doCheck then
         buildDevTest
       else
         buildDev
     else
       throw "unknown profile") + ")";

    setBuildEnv = ''
      . ${./utils.sh}
      export NIX_RUST_METADATA=`extractHash $out`
      export CARGO_HOME=`pwd`/.cargo
      mkdir -p deps build_deps
      linkFlags=(`makeExternCrateFlags $dependencies $devDependencies`)
      buildLinkFlags=(`makeExternCrateFlags $buildDependencies`)
      linkExternCrateToDeps `realpath deps` $dependencies $devDependencies
      linkExternCrateToDeps `realpath build_deps` $buildDependencies

      export NIX_RUST_LINK_FLAGS="''${linkFlags[@]} -L dependency=$(realpath deps) $extraRustcFlags"
      export NIX_RUST_BUILD_LINK_FLAGS="''${buildLinkFlags[@]} -L dependency=$(realpath build_deps)"
      export RUSTC=${wrapper "rustc"}/bin/rustc
      export RUSTDOC=${wrapper "rustdoc"}/bin/rustdoc

      echo $NIX_RUST_LINK_FLAGS
      echo $NIX_RUST_BUILD_LINK_FLAGS
      depKeys=(`loadDepKeys $dependencies`)
      for key in ''${depKeys[@]}; do
        echo $key
      done

      echo enabling the following features on crate $name-$version
      for feature in $features; do
        echo $feature
      done
    '';

    buildPhase = ''
      runHook overrideCargoManifest
      runHook setBuildEnv
      ${accessConfig "preBuild" "" package-id}
      runHook runCargo
    '';

    installPhase = ''
      mkdir -p $out/lib
      cargo_links=${cargo-manifest.package.links or ""}
      install_crate ${host-triple}
    '';
  };
  installChecks = optionalString doCheck ''
    mkdir -p $tests
    touch $tests/names
    test_names=()
    cat .test-names | (
      cd target/${host-triple}/debug;
      while read path; do
        local name=`basename $path`
        if [ -d "$name" ]; then
          continue
        elif [ -x "$name" ]; then
          mkdir -p $tests/bin
          cp $name $tests/bin/
          echo $name >> $tests/names
        fi
      done
    )
  '';
in
stdenv.mkDerivation drvAttrs
