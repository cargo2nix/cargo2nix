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
}:
{
  src,
  package-id,
  cargo-manifest,
  panicAbortOk ? true,
  features ? [],
  dependencies ? {},
  buildDependencies ? {},
  devDependencies ? {},
  buildInputs ? [],
  nativeBuildInputs ? [],
  doCheck ? false,
}:
with builtins; with lib;
let
  origFeatures = features;

  inherit (rustLib) pkgName pkgVersion pkgRegistry computeFinalFeatures;

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
      reg = config.${type}.${registry}."*" or default;
      crate = config.${type}.${registry}.${name}."*" or default;
      ver = config.${type}.${registry}.${name}.${version} or default;
    in
      if isAttrs reg && isAttrs crate && isAttrs ver then
        recursiveUpdate reg (recursiveUpdate crate ver)
      else if isList reg && isList crate && isList ver then
        reg ++ crate ++ ver
      else if isString reg && isString crate && isString ver then
        reg + crate + ver
      else
        throw "do not know how to merge registry, crate and version config values";

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

  patchManifest = final-features: panic-strategy: manifest:
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
        release.panic = panic-strategy;
      };
    in
    intersectAttrs
      { package = true; lib = true; bin = true; }
      manifest //
    {
      inherit features profile;
    };

  final-features = computeFinalFeatures cargo-manifest features;

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
            (pred == platform.config || rustLib.parseCfg pred platform)
            specset.${type} or {})
        manifest.target or {});

  depPkgs =
    final-features:
    activatedPackages
      final-features
      (getDepSpecs
        "dependencies"
        stdenv.hostPlatform
        cargo-manifest)
      dependencies;
  buildDepPkgs =
    final-features:
    activatedPackages
      final-features
      (getDepSpecs
        "build-dependencies"
        stdenv.hostPlatform
        cargo-manifest)
      dependencies;
  devDepPkgs =
    final-features:
    activatedPackages
      final-features
      (getDepSpecs
        "dev-dependencies"
        stdenv.hostPlatform
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
  ccForHost="${stdenv.cc}/bin/${stdenv.cc.targetPrefix}cc";
  cxxForHost="${stdenv.cc}/bin/${stdenv.cc.targetPrefix}c++";
in
let
  selectPlatform = pkg:
    if pkg.drv.isProcMacro or false then
      nativeDrv pkg.drv
    else
      crossDrv pkg.drv;

  computeDependencies =
    final-features:
    let
      dependencies =
        mapAttrs
          (_: pkg:
            pkg // {
              drv =
              (selectPlatform pkg).override
                (_: { inherit panicAbortOk; });
            })
          (depPkgs final-features);
      buildDependencies =
        mapAttrs
          (_: pkg:
            pkg // {
              drv = (nativeDrv pkg.drv).override (_: { panicAbortOk = false; });
            })
          (buildDepPkgs final-features);
      devDependencies =
        mapAttrs
          (_: pkg: pkg // { drv = selectPlatform pkg; })
          (optionalAttrs doCheck (devDepPkgs final-features));
    in
    { inherit dependencies buildDependencies devDependencies; };

  computePackageFeatures =
    features:
    let
      final-features = computeFinalFeatures cargo-manifest features;
      inherit (computeDependencies final-features) dependencies buildDependencies devDependencies;
      all-deps = attrValues dependencies ++ attrValues buildDependencies ++ attrValues devDependencies;
    in
    foldl recursiveUpdate {
      ${stdenv.hostPlatform.config}
      .${pkgRegistry package-id}
      .${pkgName package-id}
      .${pkgVersion package-id} = final-features;
    } (map (dep: dep.drv.passthru.computePackageFeatures dep.features) all-deps);

  inherit (computeDependencies final-features) dependencies buildDependencies devDependencies;

  panic-strategy =
    if
      cargo-manifest ? profile &&
      cargo-manifest.profile ? release &&
      cargo-manifest.profile.release ? panic &&
      panicAbortOk
    then
      cargo-manifest.profile.release.panic
    else if any (dep: dep.drv.passthru.panic-strategy == "abort") (attrValues dependencies) then
      "abort"
    else
      "unwind";

  patched-manifest = patchManifest final-features panic-strategy cargo-manifest;

  depMapToList = deps: flatten (mapAttrsToList (name: value: [ name value.drv ]) deps);
in
stdenv.mkDerivation {
  inherit src name version;
  crateName = cargo-manifest.lib.name or (replaceChars ["-"] ["_"] name);
  buildInputs =
    map accessPackage buildInputs ++
    accessConfig "buildInputs" [] package-id;
  nativeBuildInputs =
    [ buildPackages.jq cargo buildPackages.pkg-config ] ++
    map accessPackage nativeBuildInputs ++
    accessConfig "nativeBuildInputs" [] package-id;

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
    debug.features = features;
    debug.dependencies = dependencies;
    debug.devDependencies = devDependencies;
    debug.origFeatures = origFeatures;
  };

  dependencies = depMapToList dependencies;
  buildDependencies = depMapToList buildDependencies;
  devDependencies = depMapToList devDependencies;

  features = sort (a: b: a < b) (attrNames final-features);
  isProcMacro = optionalString isProcMacro "1";

  extraRustcFlags = accessConfig "rustcflags" [] package-id;

  shellHook = env-setup;

  outputs = [ "out" ] ++ optional doCheck "tests";

  configureCargo = ''
    mkdir -p .cargo
    cat > .cargo/config <<'EOF'
    [target."${stdenv.buildPlatform.config}"]
    linker = "${ccForBuild}"
  '' + optionalString (stdenv.buildPlatform.config != stdenv.hostPlatform.config) ''
    [target."${stdenv.hostPlatform.config}"]
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
      env \
        "CC_${stdenv.buildPlatform.config}"="${ccForBuild}" \
        "CXX_${stdenv.buildPlatform.config}"="${cxxForBuild}" \
        "CC_${stdenv.hostPlatform.config}"="${ccForHost}" \
        "CXX_${stdenv.hostPlatform.config}"="${cxxForHost}" \
        "''${depKeys[@]}" \
        cargo build -vvv --release --target ${stdenv.hostPlatform.config} --features "$features"
  '' + optionalString doCheck ''
      env \
        "CC_${stdenv.buildPlatform.config}"="${ccForBuild}" \
        "CXX_${stdenv.buildPlatform.config}"="${cxxForBuild}" \
        "CC_${stdenv.hostPlatform.config}"="${ccForHost}" \
        "CXX_${stdenv.hostPlatform.config}"="${cxxForHost}" \
        "''${depKeys[@]}" \
        cargo build -vvv --tests --target ${stdenv.hostPlatform.config} --features "$features"
  '' + ''
    )
  '';

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
  '' + accessConfig "preBuild" "" package-id + ''
    runHook runCargo
  '';

  installPhase = ''
    mkdir -p $out/lib
    pushd target/${stdenv.hostPlatform.config}/release
    cargo_links=${cargo-manifest.package.links or ""}
    needs_deps=
    has_output=
    for output in *; do
      if [ -d "$output" ]; then
        continue
      elif [ -x "$output" ]; then
        mkdir -p $out/bin
        cp $output $out/bin/
        has_output=1
      else
        case `extractFileExt "$output"` in
        rlib)
          mkdir -p $out/lib/.dep-files
          cp $output $out/lib/
          link_flags=$out/lib/.link-flags
          dep_keys=$out/lib/.dep-keys
          touch $link_flags $dep_keys
          for depinfo in build/*/output; do
            dumpDepInfo $link_flags $dep_keys "$cargo_links" $out/lib/.dep-files $depinfo
          done
          needs_deps=1
          has_output=1
          ;;
        a) ;&
        so) ;&
        dylib)
          mkdir -p $out/lib
          cp $output $out/lib/
          has_output=1
          ;;
        *)
          continue
        esac
      fi
    done
    popd

    touch $out/lib/.link-flags
    loadExternCrateLinkFlags $dependencies >> $out/lib/.link-flags

    if [ "$isProcMacro" ]; then
      pushd target/release
      for output in *; do
        if [ -d "$output" ]; then
          continue
        fi
        case `extractFileExt "$output"` in
        so) ;&
        dylib)
          isProcMacro=`basename $output`
          mkdir -p $out/lib
          cp $output $out/lib
          needs_deps=1
          has_output=1
          ;;
        *)
          continue
        esac
      done
      popd
    fi

    if [ ! "$has_output" ]; then
      echo NO OUTPUT IS FOUND
      exit 1
    fi

    if [ "$needs_deps" ]; then
      mkdir -p $out/lib/deps
      linkExternCrateToDeps $out/lib/deps $dependencies
    fi

    echo {} | jq \
      '{name:$name, metadata:$metadata, version:$version, proc_macro:$procmacro}' \
      --arg name $crateName \
      --arg metadata $NIX_RUST_METADATA \
      --arg procmacro "$isProcMacro" \
      --arg version $version >$out/.cargo-info
  '' + optionalString doCheck ''
    mkdir -p $tests
    pushd target/${stdenv.hostPlatform.config}/debug
      for output in *; do
        if [ -d "$output" ]; then
          continue
        elif [ -x "$output" ]; then
          mkdir -p $tests/bin
          cp $output $tests/bin/
        fi
      done
    popd
  '';
}
