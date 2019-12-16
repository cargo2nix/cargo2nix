{
  cargo,
  rustc,

  lib,
  pkgs,
  buildPackages,
  rustLib,
  stdenv,
}:
{
  release, # Compiling in release mode?
  name,
  version,
  registry,
  src,
  features ? [ ],
  dependencies ? { },
  devDependencies ? { },
  buildDependencies ? { },
  compileMode ? "build",
  profile,
  meta ? { },
  rustcflags ? [ ],
  rustcBuildFlags ? [ ],
}:
with builtins; with lib;
let
  inherit (rustLib) realHostTriple decideProfile;

  manifest = builtins.fromTOML (builtins.readFile "${src}/Cargo.toml");

  isProcMacro = manifest.lib.proc-macro or manifest.lib.proc_macro or false;

  patchedManifest =
      {
        ${ if manifest ? package then "package" else null } = manifest.package;
        ${ if manifest ? lib then "lib" else null } = manifest.lib;
        ${ if manifest ? bin then "bin" else null } = manifest.bin;
        ${ if manifest ? bench && registry == "unknown" then "bench" else null } = manifest.bench;
        ${ if manifest ? test then "test" else null } = manifest.test;
        ${ if manifest ? example then "example" else null } = manifest.example;
        features = genAttrs features (_: [ ]);
        profile.${ decideProfile compileMode release } = profile;
      };

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

    inherit
      (({ right, wrong }: { runtimeDependencies = right; buildtimeDependencies = wrong; })
        (partition (drv: drv.stdenv.hostPlatform == stdenv.hostPlatform)
          (concatLists [
            (attrValues dependencies)
            (optionals (compileMode == "test") (attrValues devDependencies))
            (attrValues buildDependencies)
          ])))
      runtimeDependencies buildtimeDependencies;

  drvAttrs = {
    name = "crate-${name}-${version}${optionalString (compileMode != "build") "-${compileMode}"}";
    inherit src version meta;
    crateName = manifest.lib.name or (replaceChars ["-"] ["_"] name);
    buildInputs = runtimeDependencies;
    propagatedBuildInputs = concatMap (drv: drv.propagatedBuildInputs) runtimeDependencies;
    nativeBuildInputs = [ cargo buildPackages.pkg-config ] ++ buildtimeDependencies;

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

    extraRustcFlags = rustcflags;

    extraRustcBuildFlags = rustcBuildFlags;

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
