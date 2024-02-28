{ rustLib, lib, pkgs, buildPackages }:

let
  inherit (rustLib) makeOverride nullOverride;

  # The bindings in this let expression are used below in the recursive set to
  # create overrides.  They are not themselves overrides.  See the list of `all`
  # overrides and their definitions below.

  # For example, openssl builds to separate directories in nixpkgs while the
  # Rust crate expects all of the output to be in one directory.  We use a
  # symlink join to create an output of the sum of two of openssl's normal
  # outputs.  This is one example of a nixpkg requiring some slight finesse to
  # be used as a buildInput for a Rust crate derivation.

  envize = s: builtins.replaceStrings ["-"] ["_"] (lib.toUpper s);

  patchOpenssl = pkgs:
    if pkgs.stdenv.hostPlatform.libc == "musl"
    then pkgs.openssl.override {
      static = true;
    }
    else if pkgs.stdenv.hostPlatform == pkgs.stdenv.buildPlatform
    then pkgs.openssl
    else (pkgs.openssl.override {
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

  # Copy shipped implib.
  # This is necessary for winapi-rs and windows crates.
  copyShippedWin32Implib = crateName: makeOverride {
      name = "${crateName}";
      overrideAttrs = drv: {
        postFixup = ''
          ${drv.postFixup or ""}
          jq -rR 'fromjson?
            | select(.reason == "build-script-executed")
            | (.linked_paths) | .[]
            | select(startswith("native=/build/")) | sub("native=/build/";"") ' \
          < .cargo-build-output >> /build/.copy-shipped-implib
          cat /build/.copy-shipped-implib | while read path; do
            parent=$(dirname "$out/lib/native/$path")
            mkdir -p "$parent"
            cp -r "/build/$path" "$parent"
            echo "-L native=$out/lib/native/$path" >> $out/lib/.link-flags
          done
        '';
      };
    };
  # TODO: only windows_x86_64_gnu and winapi-x86_64-pc-windows-gnu are tested.
  allWin32ImplibCrates = [
    "winapi-x86_64-pc-windows-gnu"
    "winapi_i686_pc_windows_gnu"
    "windows_aarch64_gnullvm"
    "windows_aarch64_msvc"
    "windows_i686_gnu"
    "windows_i686_msvc"
    "windows_x86_64_gnu"
    "windows_x86_64_gnullvm"
    "windows_x86_64_msvc"
  ];
  # convert array to dict
  allWin32ImplibOverrides = builtins.listToAttrs (builtins.map (crateName: {
    name = "copyShippedWin32Implib-${crateName}";
    value = copyShippedWin32Implib crateName;
  }) allWin32ImplibCrates);

in rec {
  patches = { inherit patchOpenssl patchCurl patchPostgresql joinOpenssl;};

  # Don't forget to add new overrides here.
  all = [
    capLints
    cc
    curl-sys
    fsevent-sys
    libgit2-sys
    libdbus-sys
    libssh2-sys
    libudev-sys
    openssl-sys
    pkg-config
    pq-sys
    prost-build
    protoc
    rand
    rand_os
    rdkafka-sys
    sqlx-macros
    reqwest
    ring
    zmq-sys
    FIXME-workaround-mcfgthread
  ] 
  ++ (builtins.attrValues allWin32ImplibOverrides)
  ;

  capLints = makeOverride {
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    overrideArgs = old: { rustcLinkFlags = old.rustcLinkFlags or [ ] ++ [ "--cap-lints" "warn" ]; };
  };

  # Every crate that depends on the cc crate (usually build scripts) will have the xcbuild
  cc = if pkgs.stdenv.hostPlatform.isDarwin
    then makeOverride {
      name = "cc";
      overrideAttrs = drv: {
        propagatedNativeBuildInputs = drv.propagatedNativeBuildInputs or [ ] ++ [
          pkgs.xcbuild
        ];
      };
    }
    else nullOverride;

  curl-sys = makeOverride {
    name = "curl-sys";
    overrideAttrs = drv: {
      propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [
        (patchCurl pkgs)
      ];
    };
  };

  fsevent-sys = if pkgs.stdenv.hostPlatform.isDarwin
    then makeOverride {
      name = "fsevent-sys";
      overrideAttrs = drv: {
        propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [
          pkgs.darwin.apple_sdk.frameworks.CoreServices
        ];
      };
    }
    else  nullOverride;

  reqwest = if pkgs.stdenv.hostPlatform.isDarwin
    then makeOverride {
      name = "reqwest";
      overrideAttrs = drv: {
        propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [
          pkgs.darwin.apple_sdk.frameworks.Security
        ];
      };
    }
    else  nullOverride;

  libdbus-sys = pkgs.rustBuilder.rustLib.makeOverride {
    name = "libdbus-sys";
    overrideAttrs = drv: {
      buildInputs = drv.buildInputs or [ ] ++ [
        pkgs.dbus
      ];
    };
  };

  libudev-sys = pkgs.rustBuilder.rustLib.makeOverride {
    name = "libudev-sys";
    overrideAttrs = drv: {
      buildInputs = drv.buildInputs or [ ] ++ [
        pkgs.udev
      ];
      buildPhase = ''
        runHook overrideCargoManifest
        runHook setBuildEnv
        export PATH=$PATH:$(dirname $RUSTC)
        runHook runCargo
      '';
    };
  };

  libgit2-sys = if pkgs.stdenv.hostPlatform.isDarwin
    then makeOverride {
      name = "libgit2-sys";
      overrideAttrs = drv: {
        propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [
          pkgs.darwin.apple_sdk.frameworks.Security
          pkgs.darwin.apple_sdk.frameworks.CoreFoundation
        ];
        buildInputs = drv.buildInputs or [ ] ++ [
          pkgs.libgit2
        ];
        preferLocalBuild = true;
        allowSubstitutes = false;
      };
    }
    else nullOverride;

  libssh2-sys = makeOverride {
    name = "libssh2-sys";
    overrideAttrs = drv: {
      buildInputs = drv.buildInputs or [ ] ++ [ pkgs.openssl.dev pkgs.zlib.dev ];
    };
  };

  libsqlite3-sys = pkgs.rustBuilder.rustLib.makeOverride {
    name = "libsqlite3-sys";
    overrideAttrs = drv: {
      buildInputs = drv.buildInputs or [ ] ++ [ pkgs.sqlite ];
    };
  };

  openssl-sys = makeOverride {
    name = "openssl-sys";
    overrideAttrs = drv: {
      # The setup hook will set the variables both for building openssl-sys and
      # in dependent derivations.  This mechanism will also set the variable
      # inside our development shell.  Because the setupHook does not add the
      # joinOpenssl derivation as a dependnecy, we have to include it in
      # nativeBuildInputs as well or the variable will point to a path not
      # visible to the derivation at build time.
      buildInputs = drv.buildInputs or [ ] ++ [(joinOpenssl (patchOpenssl pkgs.buildPackages))];

      shellHook = drv.shellHook or "" + ''
            export ${envize (pkgs.rustBuilder.rustLib.rustTriple pkgs.stdenv.buildPlatform)}_OPENSSL_DIR=${lib.escapeShellArg (joinOpenssl (patchOpenssl pkgs.buildPackages))}
            export ${envize (pkgs.rustBuilder.rustLib.rustTriple pkgs.stdenv.hostPlatform)}_OPENSSL_DIR=${lib.escapeShellArg (joinOpenssl (patchOpenssl pkgs))}
            export OPENSSL_NO_VENDOR=1 # fixed 0.9.60
            export RUSTFLAGS="''${RUSTFLAGS:-} --cfg ossl111 --cfg ossl110 --cfg ossl101"
      '';

      # setupHook is also a means of injecting the build environment for a dependency
      # setupHook = buildPackages.writeText "openssl-sys-setup-env.sh" ''
      #     openssl-sys-setup-env() {
      #       export ${envize (pkgs.rustBuilder.rustLib.rustTriple pkgs.stdenv.buildPlatform)}_OPENSSL_DIR=${lib.escapeShellArg (joinOpenssl (patchOpenssl pkgs.buildPackages))}
      #       export ${envize (pkgs.rustBuilder.rustLib.rustTriple pkgs.stdenv.hostPlatform)}_OPENSSL_DIR=${lib.escapeShellArg (joinOpenssl (patchOpenssl pkgs))}
      #       export OPENSSL_NO_VENDOR=1 # fixed 0.9.60
      #       export RUSTFLAGS="''${RUSTFLAGS:-} --cfg ossl111 --cfg ossl110 --cfg ossl101"
      #     }
      #     addEnvHooks "$hostOffset" openssl-sys-setup-env
      # '';
    };
  };

  pkg-config = makeOverride {
    name = "pkg-config";
    overrideAttrs = drv: {
      # Every crate that depends on the pkg-config crate also gets pkg-config and this environment
      propagatedNativeBuildInputs = drv.propagatedNativeBuildInputs or [ ] ++ [
        pkgs.pkg-config
      ];
      shellHook = drv.shellHook or "" + ''
        export PGK_CONFIG_ALLOW_CROSS=1
      '';
    };
  };

  pq-sys =
    let
      binEcho = s: "${pkgs.buildPackages.writeShellScriptBin "bin-echo" "echo ${s}"}/bin/bin-echo";
      fake_pg_config = binEcho "${(patchPostgresql pkgs.buildPackages).lib}/lib";
    in
      makeOverride {
        name = "pq-sys";
        overrideAttrs = drv: {
          # We can't use the host `pg_config` here, as it might not run on build platform. `pq-sys` only needs
          # to know the `lib` directory for `libpq`, so just create a fake binary that gives it exactly that.
          nativeBuildInputs = drv.nativeBuildInputs or [ ] ++ [
            fake_pg_config
          ];
          shellHook = drv.shellHook + ''
            PG_CONFIG_${envize pkgs.stdenv.buildPlatform.config}="${fake_pg_config}"
          '';
        };
      };

  # Note that protobuff is from buildPackages and runs at the crate's
  # build-time, so it's a nativeBuildInput.  Every crate that depends on
  # prost-build might need protoc at runtime, so it's propagated.
  prost-build = makeOverride {
    name = "prost-build";
    overrideAttrs = drv: {
      setupHook = buildPackages.writeText "prost-build-setup-env.sh" ''
        prost-build-setup-env () {
          PROTOC="${pkgs.buildPackages.buildPackages.protobuf}/bin/protoc"
        }
        addEnvHooks "$hostOffset" prost-build-setup-env
      '';
      propagatedNativeBuildInputs = drv.propagatedNativeBuildInputs or [ ] ++ [
        pkgs.buildPackages.buildPackages.protobuf
      ];
    };
  };

  protoc = makeOverride {
    name = "protoc";
    overrideAttrs = drv: {
      propagatedNativeBuildInputs = drv.propagatedNativeBuildInputs or [ ] ++ [ pkgs.buildPackages.buildPackages.protobuf ];
    };
  };

  rand = if pkgs.stdenv.hostPlatform.isDarwin
    then makeOverride {
      name = "rand";
      overrideAttrs = drv: {
        propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [ pkgs.darwin.apple_sdk.frameworks.Security ];
      };
    }
    else nullOverride;

  rand_os = if pkgs.stdenv.hostPlatform.isDarwin
    then makeOverride {
      name = "rand_os";
      overrideAttrs = drv: {
        propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [ pkgs.darwin.apple_sdk.frameworks.Security ];
      };
    }
    else nullOverride;

  sqlx-macros = if pkgs.stdenv.hostPlatform.isDarwin
  then makeOverride {
    name = "sqlx-macros";
    overrideAttrs = drv: {
      propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [ pkgs.darwin.apple_sdk.frameworks.SystemConfiguration ];
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

  ring = if pkgs.stdenv.hostPlatform.isDarwin
    then makeOverride {
      name = "ring";
      overrideAttrs = drv: {
        propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [ pkgs.darwin.apple_sdk.frameworks.Security ];
      };
    }
    else nullOverride;

  zmq-sys = makeOverride {
    name = "zmq-sys";
    overrideAttrs = drv: {
      buildInputs = drv.buildInputs or [ ] ++ [ pkgs.zeromq ];
    };
  };

  # FIXME: This is a temporary workaround for upstream Rust not supporting mcfgthread thread model!
  # See: https://github.com/cargo2nix/cargo2nix/issues/348
  FIXME-workaround-mcfgthread = if pkgs.stdenv.hostPlatform.isWindows && pkgs.threadsCross.model == "mcf" 
    then makeOverride{
      overrideArgs = old: { rustcLinkFlags = old.rustcLinkFlags or [ ] ++ [ "-L" ../lib/mingw-w64 ]; };
    }
    else nullOverride;
} // allWin32ImplibOverrides
