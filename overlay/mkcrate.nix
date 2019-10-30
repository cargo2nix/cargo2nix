{ # The first argument is provided by `callPackage`.
  cargo,
  rustc,

  config,
  lib,
  pkgs,
  buildPackages,
  rustLib,
  stdenv,
}:
{ # The second argument is provided by code generation.
  release, # Compiling in release profile?
  name,
  version,
  registry,
  profiles,
  src,
  features,
  dependencies,
  devDependencies,
  buildDependencies,
  manifest,
}:
{ # The third argument is customizable by user.
  compileMode ? "build", # build, test, or bench.
  meta ? { },
}:
with builtins; with lib;
let
  inherit (rustLib) realHostTriple;

  accessConfig = type: default:
    let
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

  environment = accessConfig "environment" {};

  env-setup =
    let
      mapToEnv = key: val:
        "export ${key}=${escapeShellArg val}";
    in
      concatStringsSep "\n" (mapAttrsToList mapToEnv environment);

  isProcMacro = manifest.lib.proc-macro or manifest.lib.proc_macro or false;

  patchedManifest =
    let
      profileName = if release then "release" else compileMode;
      profile = profiles.${profileName} or { };
      patchedProfile = if isProcMacro && profile ? panic then profile // { panic = "unwind"; } else profile;
    in
      manifest // {
        features = genAttrs features (_: [ ]);
        profile.${profileName} = patchedProfile;
      };

  force = x: builtins.deepSeq x x;
  ftraceWith = a: x: builtins.trace (force [a x]) x;

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

  ccForBuild="${buildPackages.stdenv.cc}/bin/${buildPackages.stdenv.cc.targetPrefix}cc";
  cxxForBuild="${buildPackages.stdenv.cc}/bin/${buildPackages.stdenv.cc.targetPrefix}c++";
  targetPrefix = stdenv.cc.targetPrefix;
  cc = stdenv.cc;
  ccForHost="${cc}/bin/${targetPrefix}cc";
  cxxForHost="${cc}/bin/${targetPrefix}c++";
  host-triple = realHostTriple stdenv.hostPlatform;
  depMapToList = deps:
    flatten
      (sort (a: b: elemAt a 0 < elemAt b 0)
        (mapAttrsToList (name: value: [ name "${value}" ]) deps));
  buildCmd =
    let
      hasDefaultFeature = elem "default" features;
      featuresWithoutDefault = if hasDefaultFeature
        then filter (feature: feature != "default") features
        else features;
      buildMode = {
        "test" = "--tests";
        "bench" = "--benches";
      }.${compileMode} or "";
      featuresArg = if featuresWithoutDefault == [ ]
        then ""
        else "--features ${concatStringsSep "," featuresWithoutDefault}";
    in
      ''
        cargo build -vvv ${optionalString release "--release"} --target ${host-triple} ${buildMode} \
          ${featuresArg} ${optionalString (!hasDefaultFeature) "--no-default-features"}
      '';

  drvAttrs = {
    name = "crate-${name}-${version}${optionalString (compileMode != "build") "-${compileMode}"}";
    inherit src version meta;
    crateName = manifest.lib.name or (replaceChars ["-"] ["_"] name);
    buildInputs = sort (a: b: "${a}" < "${b}") (accessConfig "buildInputs" [ ]);
    nativeBuildInputs = sort (a: b: "${a}" < "${b}")
      ([ cargo buildPackages.pkg-config ] ++ accessConfig "nativeBuildInputs" [ ]);
    depsBuildBuild = [ buildPackages.buildPackages.stdenv.cc buildPackages.buildPackages.jq ];

    # Running the default `strip -S` command on Darwin corrupts the
    # .rlib files in "lib/".
    #
    # See https://github.com/NixOS/nixpkgs/pull/34227
    stripDebugList = if stdenv.isDarwin then [ "bin" ] else null;

    passthru = {
      inherit
        name
        version
        registry
        patchedManifest
        dependencies
        devDependencies
        buildDependencies
        features;
      shell = pkgs.mkShell (removeAttrs drvAttrs ["src"]);
    };

    dependencies = depMapToList dependencies;
    buildDependencies = depMapToList buildDependencies;
    devDependencies = depMapToList (optionalAttrs (compileMode == "test") devDependencies);

    isProcMacro = optionalString isProcMacro "1";

    extraRustcFlags = accessConfig "rustcflags" [ ];

    extraRustcBuildFlags = accessConfig "rustcBuildFlags" [ ];

    shellHook = env-setup;

    # HACK: 2019-08-01: wasm32-wasi always uses `wasm-ld`
    configureCargo = ''
      mkdir -p .cargo
      cat > .cargo/config <<'EOF'
      [target."${realHostTriple stdenv.buildPlatform}"]
      linker = "${ccForBuild}"
    '' + optionalString (stdenv.buildPlatform != stdenv.hostPlatform && !(stdenv.hostPlatform.isWasi or false)) ''
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
      cp ${rustLib.json2toml { inherit name; json = patchedManifest; }} Cargo.toml
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
        set -euox pipefail
        env \
          "CC_${stdenv.buildPlatform.config}"="${ccForBuild}" \
          "CXX_${stdenv.buildPlatform.config}"="${cxxForBuild}" \
          "CC_${host-triple}"="${ccForHost}" \
          "CXX_${host-triple}"="${cxxForHost}" \
          "''${depKeys[@]}" \
          ${buildCmd}
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
      export NIX_RUST_BUILD_LINK_FLAGS="''${buildLinkFlags[@]} -L dependency=$(realpath build_deps) $extraRustcBuildFlags"
      export RUSTC=${wrapper "rustc"}/bin/rustc
      export RUSTDOC=${wrapper "rustdoc"}/bin/rustdoc

      echo $NIX_RUST_LINK_FLAGS
      echo $NIX_RUST_BUILD_LINK_FLAGS
      depKeys=(`loadDepKeys $dependencies`)
      for key in ''${depKeys[@]}; do
        echo $key
      done
    '';

    buildPhase = ''
      runHook overrideCargoManifest
      runHook setBuildEnv
      ${accessConfig "preBuild" ""}
      runHook runCargo
    '';

    installPhase = ''
      mkdir -p $out/lib
      cargo_links=${manifest.package.links or ""}
      install_crate ${host-triple}
    '';
  };
in
  stdenv.mkDerivation drvAttrs
