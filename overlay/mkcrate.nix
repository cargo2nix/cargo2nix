{
  rustToolchain,
  lib,
  pkgs,
  buildPackages,
  rustLib,
  stdenv,
  writers,
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
  profileOpts ? null,
  codegenOpts ? null,
  meta ? { },
  cargoUnstableFlags ? [ ],
  rustcLinkFlags ? [ ],
  rustcBuildFlags ? [ ],
  target ? null,
  hostPlatformCpu ? null,
  hostPlatformFeatures ? [],
  NIX_DEBUG ? 0,
  cargoConfig ? {}
}:
with builtins; with lib;
let
  inherit (rustLib) rustTriple decideProfile;
  wrapper = rustpkg: pkgs.writeScriptBin rustpkg ''
    #!${stdenv.shell}
    . ${./mkcrate-utils.sh}
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
      args+=($NIX_RUST_BUILD_FLAGS)
    else
      args+=($NIX_RUST_LINK_FLAGS)
    fi
    touch invoke.log
    echo "''${args[@]}" >>invoke.log
    exec ${rustToolchain}/bin/${rustpkg} "''${args[@]}"
  '';

  ccForBuild="${buildPackages.stdenv.cc}/bin/${buildPackages.stdenv.cc.targetPrefix}cc";
  cxxForBuild="${buildPackages.stdenv.cc}/bin/${buildPackages.stdenv.cc.targetPrefix}c++";
  targetPrefix = stdenv.cc.targetPrefix;
  cc = stdenv.cc;
  ccForHost="${cc}/bin/${targetPrefix}cc";
  cxxForHost="${cc}/bin/${targetPrefix}c++";
  rustBuildTriple = rustTriple stdenv.buildPlatform;
  rustHostTriple = if (target != null) then target else rustTriple stdenv.hostPlatform;
  buildCargoConfig = lib.foldl lib.recursiveUpdate cargoConfig [
    {
      net.offline = true;
      target.${rustBuildTriple}.linker = ccForBuild;
    }
    (lib.optionalAttrs (codegenOpts != null && codegenOpts ? "${rustBuildTriple}") {
      target.${rustBuildTriple}.rustflags = lib.flatten (map (v: ["-C" v]) codegenOpts."${rustBuildTriple}");
    })
    # HACK: 2019-08-01: wasm32-wasi always uses `wasm-ld`
    # HACK: 2021-12-29: x86_64-fortanix-unknown-sgx always use `ld`
    (lib.optionalAttrs (rustBuildTriple != rustHostTriple && rustHostTriple != "wasm32-wasi" && rustHostTriple != "wasm32-unknown-unknown" && rustHostTriple != "x86_64-fortanix-unknown-sgx") {
      target.${rustHostTriple}.linker = ccForHost;
    })
    (lib.optionalAttrs ((rustBuildTriple != rustHostTriple && rustHostTriple != "wasm32-wasi" && rustHostTriple != "wasm32-unknown-unknown" && rustHostTriple != "x86_64-fortanix-unknown-sgx") && (codegenOpts != null && codegenOpts ? "${rustHostTriple}")) {
      rustflags = lib.flatten (map (v: ["-C" v]) codegenOpts."${rustHostTriple}");
    })
    (lib.optionalAttrs (profileOpts != null && profileOpts."${decideProfile compileMode release}" != null) {
      target.${rustHostTriple}.profile = profileOpts.${decideProfile compileMode release};
    })
  ];
  cargoConfigFile = writers.writeTOML "config.toml" buildCargoConfig;
  
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
      if compileMode != "doctest" then ''
        ${rustToolchain}/bin/cargo build $CARGO_VERBOSE ${optionalString release "--release"} --target ${rustHostTriple} ${buildMode} \
          ${featuresArg} ${optionalString (!hasDefaultFeature) "--no-default-features"} \
          ${optionalString (builtins.length cargoUnstableFlags > 0) "-Z ${lib.strings.concatStringsSep "," cargoUnstableFlags}"} \
          --message-format json-diagnostic-rendered-ansi | tee .cargo-build-output \
          1> >(jq 'select(.message != null) .message.rendered' -r)
      ''
      # Note: Doctest doesn't yet support no-run https://github.com/rust-lang/rust/pull/83857
      # So instead of persiting the binaries with
      # RUSTDOCFLAGS="-Zunstable-options --persist-doctests $(pwd)/target/rustdoctest -o $(pwd)/target/rustdoctest" cargo test --doc | tee .cargo-doctest-output
      # we just introduce a new compile mode
      #
      # We also filter -l linkage flags, as rustdoc doesn't support them
      #
      # And _also_ detect if there are no lib crates, in which case skip, because thats an error for rustdoc
      #
      # This does not abort on failure. The output should be inspected for failures
      else ''
        echo "Performing Doctests"
        export NIX_RUST_LINK_FLAGS=$(echo "$NIX_RUST_LINK_FLAGS" | sed 's/ \-l \w*//g')
        ${rustToolchain}/bin/cargo read-manifest | jq -e '.targets | .[] | select(.crate_types[] | contains ("lib")) | any' >/dev/null && \
          ( ${rustToolchain}/bin/cargo test --doc --no-fail-fast \
              ${featuresArg} ${optionalString (!hasDefaultFeature) "--no-default-features"} \
              -- -Z unstable-options --format json \
              | tee results.json \
          || true) \
          || echo "No lib crate detected"
      '';

  inherit
    (({ right, wrong }: { runtimeDependencies = right; buildtimeDependencies = wrong; })
      (partition (drv: drv.stdenv.hostPlatform == stdenv.hostPlatform)
        (concatLists [
          (attrValues dependencies)
          (optionals (compileMode != "build") (attrValues devDependencies))
          (attrValues buildDependencies)
        ])))
    runtimeDependencies buildtimeDependencies;

  drvAttrs = {
    inherit src version meta NIX_DEBUG;
    name = "crate-${name}-${version}${optionalString (compileMode != "build") "-${compileMode}"}";

    buildInputs = runtimeDependencies ++ lib.optionals stdenv.hostPlatform.isDarwin [ pkgs.libiconv ];
    propagatedBuildInputs = lib.unique (concatMap (drv: drv.propagatedBuildInputs) runtimeDependencies);
    nativeBuildInputs = [ rustToolchain ] ++ buildtimeDependencies;

    depsBuildBuild =
      let inherit (buildPackages.buildPackages) stdenv jq remarshal;
      in [ stdenv.cc jq remarshal ];

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
        dependencies
        devDependencies
        buildDependencies
        features;
      shell = pkgs.mkShell (removeAttrs drvAttrs ["src"]);
    };

    dependencies = depMapToList dependencies;
    buildDependencies = depMapToList buildDependencies;
    devDependencies = depMapToList (optionalAttrs (compileMode != "build") devDependencies);

    extraRustcLinkFlags =
      optionals (hostPlatformCpu != null) ([("-Ctarget-cpu=" + hostPlatformCpu)]) ++
      optionals (hostPlatformFeatures != []) [("-Ctarget-feature=" + (concatMapStringsSep "," (feature: "+" + feature) hostPlatformFeatures))] ++
      rustcLinkFlags;

    extraRustcBuildFlags = rustcBuildFlags;

    configureCargo = ''
      mkdir -p .cargo
      rm -f .cargo/config .cargo/config.toml
      ln -s ${cargoConfigFile} .cargo/config${if lib.versionOlder rustToolchain.version "1.39.0" then "" else ".toml"}
    '';

    configurePhase = ''
      runHook preConfigure
      runHook configureCargo
      runHook postConfigure
    '';

    manifestPatch = toJSON {
      features = genAttrs features (_: [ ]);
      profile.${ decideProfile compileMode release } = profile;
    };

    overrideCargoManifest = ''
      . ${./mkcrate-utils.sh}

      # Synthesize a lock file
      echo "[[package]]" > Cargo.lock
      echo name = \"${name}\" >> Cargo.lock
      echo version = \"${version}\" >> Cargo.lock
      registry="${registry}"
      if [ "$registry" != "unknown" ]; then
        echo source = \"registry+''${registry}\" >> Cargo.lock
      fi

      manifest_path=$(cargoRelativeManifest ${name})
      manifest_dir=''${manifest_path%Cargo.toml}

      # Rewrite the crate's toml
      if [ -n "$manifest_dir" ]; then pushd $manifest_dir; fi
      mv Cargo.toml Cargo.original.toml
      sanitizeTomlForRemarshal Cargo.original.toml
      reducePackageToml Cargo.original.toml Cargo.toml "$manifestPatch"
      if [ -n "$manifest_dir" ]; then popd; fi

      # If the crate is a workspace, reduce it to a crate of just a workspace of a single crate
      if [ $manifest_path != "Cargo.toml" ]; then
        mv Cargo.toml Cargo.workspace.toml
        sanitizeTomlForRemarshal Cargo.workspace.toml
        reduceWorkspaceToml Cargo.workspace.toml Cargo.toml "$manifest_dir"
      fi

    '';

    setBuildEnv = ''
      CARGO_BUILD_INCREMENTAL=0  #builds inside nix sandbox use nix caching, not cargo target caching
      MINOR_RUSTC_VERSION="$(${rustToolchain}/bin/rustc --version | cut -d . -f 2)"

      if (( MINOR_RUSTC_VERSION < 41 )); then
        isProcMacro="$(
          remarshal -if toml -of json "''${manifest_dir}Cargo.original.toml" \
          | jq -r 'if .lib."proc-macro" or .lib."proc_macro" then "1" else "" end' \
        )"
      fi

      crateName="$(
        remarshal -if toml -of json "''${manifest_dir}Cargo.original.toml" \
        | jq -r 'if .lib."name" then .lib."name" else "${replaceStrings ["-"] ["_"] name}" end' \
      )"

      . ${./mkcrate-utils.sh}

      export CARGO_VERBOSE=`cargoVerbosityLevel $NIX_DEBUG`
      export NIX_RUST_METADATA=`extractHash $out`
      export CARGO_HOME=`pwd`/.cargo

      mkdir -p deps build_deps
      linkFlags=(`makeExternCrateFlags $dependencies $devDependencies | sort -u`)
      buildLinkFlags=(`makeExternCrateFlags $buildDependencies | sort -u`)
      linkExternCrateToDeps `realpath deps` $dependencies $devDependencies
      linkExternCrateToDeps `realpath build_deps` $buildDependencies

      export NIX_RUST_LINK_FLAGS="''${linkFlags[@]} -L dependency=$(realpath deps) $extraRustcLinkFlags"
      export NIX_RUST_BUILD_FLAGS="''${buildLinkFlags[@]} -L dependency=$(realpath build_deps) $extraRustcBuildFlags"
      export RUSTC=${wrapper "rustc"}/bin/rustc
      export CLIPPY_DRIVER=${wrapper "clippy-driver"}/bin/clippy-driver
      export RUSTDOC=${wrapper "rustdoc"}/bin/rustdoc

      readarray -t depKeys <<< `loadDepKeys $dependencies`

      if (( NIX_DEBUG >= 1 )); then
        echo $NIX_RUST_LINK_FLAGS
        echo $NIX_RUST_BUILD_FLAGS
        for key in ''${depKeys[@]}; do
          echo $key
        done
      fi
    '';

    runCargo = ''
      (
        set -euo pipefail
        if (( NIX_DEBUG >= 1 )); then
          set -x
        fi
        env \
          "CC_${stdenv.buildPlatform.config}"="${ccForBuild}" \
          "CXX_${stdenv.buildPlatform.config}"="${cxxForBuild}" \
          "CC_${rustHostTriple}"="${ccForHost}" \
          "CXX_${rustHostTriple}"="${cxxForHost}" \
          ''${depKeys:+"''${depKeys[@]}"} \
          ${buildCmd}
      )
    '';

    buildPhase = ''
      runHook preBuild
      runHook overrideCargoManifest
      runHook setBuildEnv
      runHook runCargo
      runHook postBuild
    '';

    outputs = ["bin" "out"];

    installPhase = ''
      runHook preInstall
    '' + (if compileMode != "doctest" then ''
      mkdir -p $out/lib
      cargo_links="$(remarshal -if toml -of json "''${manifest_dir}Cargo.original.toml" | jq -r '.package.links | select(. != null)')"
      if (( MINOR_RUSTC_VERSION < 41 )); then
        install_crate ${rustHostTriple} ${if release then "release" else "debug"}
      else
        install_crate2 ${rustHostTriple}
      fi
    '' else ''
      mkdir -p $out/share
      mkdir -p $bin
      touch results.json
      mv results.json $out/share/
    '') + ''
      runHook postInstall
    '';
  };
in
  stdenv.mkDerivation drvAttrs
