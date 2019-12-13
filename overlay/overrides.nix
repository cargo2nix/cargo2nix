{ rustLib, lib, pkgs, buildPackages }:
let
  inherit (rustLib) makeOverride nullOverride;
  envize = s: builtins.replaceStrings ["-"] ["_"] (lib.toUpper s);

  patchOpenssl = pkgs: (pkgs.openssl.override {
    # We only need `perl` at build time. It's also used as the interpreter for one
    # of the produced binaries (`c_rehash`), but they'll be removed later.
    perl = pkgs.buildPackages.buildPackages.perl;
  }).overrideAttrs (drv: {
    installTargets = "install_sw";
    outputs = [ "dev" "out" "bin" ];
    # Remove binaries, we need only libraries.
    postFixup = ''
      ${drv.postFixup}
      rm -rf $bin/*
    '';
  });

  joinOpenssl = openssl: buildPackages.symlinkJoin {
    name = "openssl"; paths = with openssl; [ out dev ];
  };

  patchPostgresql = pkgs: pkgs.postgresql.override {
    openssl = patchOpenssl pkgs;
    # Remove `systemd` input as it breaks cross compilation.
    enableSystemd = false;
  };

  patchCurl = pkgs:
    let
      openssl = patchOpenssl pkgs;
    in pkgs.curl.override {
      inherit openssl;
      nghttp2 = pkgs.nghttp2.override { inherit openssl; };
      libssh2 = pkgs.libssh2.override { inherit openssl; };
      libkrb5 = pkgs.libkrb5.override { inherit openssl; };
    };

  propagateEnv = name: envs: buildPackages.stdenv.mkDerivation {
    name = "${name}-propagate-env";
    setupHook = buildPackages.writeText "exports.sh" ''
      ${name}-setup-env() {
        ${lib.concatMapStringsSep
            "\n"
            ({ name, value }: "export ${name}=${lib.escapeShellArg value}")
            envs}
      }
      addEnvHooks "$hostOffset" ${name}-setup-env
    '';
    phases = "installPhase fixupPhase";
    installPhase = "mkdir -p $out";
    preferLocalBuild = true;
    allowSubstitutes = false;
  };

in rec {
  patches = { inherit patchOpenssl patchCurl patchPostgresql joinOpenssl propagateEnv; };

  # Don't forget to add new overrides here.
  all = [
    capLints
    openssl-sys
    curl-sys
    libgit2-sys
    pq-sys
    prost-build
    rand_os
    rand
    rdkafka-sys
  ];

  capLints = makeOverride {
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    overrideArgs = old: { rustcflags = old.rustcflags or [ ] ++ [ "--cap-lints" "warn" ]; };
  };

  openssl-sys = makeOverride {
    name = "openssl-sys";
    overrideAttrs = drv: {
      propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [
        (propagateEnv "openssl-sys" [
          { name = "${envize pkgs.stdenv.buildPlatform.config}_OPENSSL_DIR"; value = joinOpenssl (patchOpenssl pkgs.buildPackages); }
          { name = "${envize pkgs.stdenv.hostPlatform.config}_OPENSSL_DIR"; value = joinOpenssl (patchOpenssl pkgs); }
        ])
      ];
    };
  };

  curl-sys = makeOverride {
    name = "curl-sys";
    overrideAttrs = drv: {
      propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [ (patchCurl pkgs) ];
    };
  };

  libgit2-sys = if pkgs.stdenv.hostPlatform.isDarwin
    then makeOverride {
      name = "libgit2-sys";
      overrideAttrs = drv: {
        propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [
          pkgs.libiconv
          pkgs.darwin.apple_sdk.frameworks.Security
          pkgs.darwin.apple_sdk.frameworks.CoreFoundation
        ];
      };
    }
    else nullOverride;

  pq-sys =
    let
      binEcho = s: "${pkgs.buildPackages.writeShellScriptBin "bin-echo" "echo ${s}"}/bin/bin-echo";
    in
      makeOverride {
        name = "pq-sys";
        overrideAttrs = drv: {
          # We can't use the host `pg_config` here, as it might not run on build platform. `pq-sys` only needs
          # to know the `lib` directory for `libpq`, so just create a fake binary that gives it exactly that.
          propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [
            (propagateEnv "pq-sys" [
              { name = "PG_CONFIG_${envize pkgs.stdenv.buildPlatform.config}"; value = binEcho "${(patchPostgresql pkgs.buildPackages).lib}/lib"; }
              { name = "PG_CONFIG_${envize pkgs.stdenv.hostPlatform.config}"; value = binEcho "${(patchPostgresql pkgs).lib}/lib"; }
            ])
          ];
        };
      };

  prost-build = makeOverride {
    name = "prost-build";
    overrideAttrs = drv: {
      propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [
        (propagateEnv "prost-build" [
          { name = "PROTOC"; value = "${pkgs.buildPackages.buildPackages.protobuf}/bin/protoc"; }
        ])
      ];
    };
  };

  rand_os = if pkgs.stdenv.hostPlatform.isDarwin
    then makeOverride {
      name = "rand_os";
      overrideAttrs = drv: {
        propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [ pkgs.darwin.apple_sdk.frameworks.Security ];
      };
    }
    else nullOverride;

  rand = if pkgs.stdenv.hostPlatform.isDarwin
    then makeOverride {
      name = "rand";
      overrideAttrs = drv: {
        propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [ pkgs.darwin.apple_sdk.frameworks.Security ];
      };
    }
    else nullOverride;

  rdkafka-sys = makeOverride {
    name = "rdkafka-sys";
    overrideAttrs = drv: {
      postConfigure = ''
        ${drv.postConfigure or ""}
        patchShebangs --build librdkafka/configure
      '';
    };
  };
}
