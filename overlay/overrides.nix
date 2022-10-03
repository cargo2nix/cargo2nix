{ rustLib, lib, pkgs, buildPackages }:
let
  inherit (rustLib) makeOverride nullOverride;
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
    atk-sys
    capLints
    cc
    cairo-sys-rs
    curl-sys
    fsevent-sys
    gdk
    gdk-pixbuf-sys
    gdk-sys
    gdkx11-sys
    glib-sys
    javascriptcore-rs-sys
    libgit2-sys
    libdbus-sys
    libssh2-sys
    libudev-sys
    openssl-sys
    pango-sys
    pkg-config
    pq-sys
    prost-build
    protoc
    rand
    rand_os
    rdkafka-sys
    reqwest
    ring
    soup2-sys
    zmq-sys
  ];

  atk-sys = makeOverride {
    name = "atk-sys";
    overrideAttrs = drv: {
      buildInputs = drv.buildInputs or [ ] ++ [ pkgs.atk.dev ];
    };
  };

  cairo-sys-rs = makeOverride {
    name = "cairo-sys-rs";
    overrideAttrs = drv: {
      buildInputs = drv.buildInputs or [ ] ++ [ pkgs.cairo.dev ];
      propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [ pkgs.pkg-config ];
    };
  };

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

  glib-sys = makeOverride {
    name = "glib-sys";
    overrideAttrs = drv: {
      propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [ pkgs.glib.dev pkgs.pkg-config ];
    };
  };

  gdk-pixbuf-sys = makeOverride {
    name = "gdk-pixbuf-sys";
    overrideAttrs = drv: {
      buildInputs = drv.buildInputs or [ ] ++ [ pkgs.gdk-pixbuf.dev ];
    };
  };

  gdk-sys = makeOverride {
    name = "gdk-sys";
    overrideAttrs = drv: {
      propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [ pkgs.gtk3.dev ];
    };
  };

  gdk = makeOverride {
    name = "gdk";
    overrideAttrs = drv: {
      buildInputs = drv.buildInputs or [ ] ++ [ pkgs.gtk3.dev ];
    };
  };

  gdkx11-sys = makeOverride {
    name = "gdkx11-sys";
    overrideAttrs = drv: {
      buildInputs = drv.buildInputs or [ ] ++ [ pkgs.gtk3.dev ];
    };
  };

  javascriptcore-rs-sys = makeOverride {
    name = "javascriptcore-rs-sys";
    overrideAttrs = drv: {
      propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [ pkgs.webkitgtk.dev ];
    };
  };

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

      # shellHook = ''
      #   # shellHook is also a means of injecting the build environment for this dependency
      #   # export FOO=BAR
      # '';
      setupHook = buildPackages.writeText "openssl-sys-setup-env.sh" ''
          openssl-sys-setup-env() {
            export ${envize (pkgs.rustBuilder.rustLib.rustTriple pkgs.stdenv.buildPlatform)}_OPENSSL_DIR=${lib.escapeShellArg (joinOpenssl (patchOpenssl pkgs.buildPackages))}
            export ${envize (pkgs.rustBuilder.rustLib.rustTriple pkgs.stdenv.hostPlatform)}_OPENSSL_DIR=${lib.escapeShellArg (joinOpenssl (patchOpenssl pkgs))}
            export OPENSSL_NO_VENDOR=1 # fixed 0.9.60
            # export RUSTFLAGS="''${RUSTFLAGS:-} --cfg ossl111 --cfg ossl110 --cfg ossl101"
          }
          addEnvHooks "$hostOffset" openssl-sys-setup-env
      '';
    };
  };

  pango-sys = makeOverride {
    name = "pango-sys";
    overrideAttrs = drv: {
      buildInputs = drv.buildInputs or [ ] ++ [ pkgs.pango.dev ];
    };
  };

  pkg-config = makeOverride {
    name = "pkg-config";
    overrideAttrs = drv: {
      # Every crate that depends on the pkg-config crate also gets pkg-config and this environment
      propagatedNativeBuildInputs = drv.propagatedNativeBuildInputs or [ ] ++ [
        pkgs.pkg-config
        # (propagateEnv "pkg-config" [
        #   { name = "PKG_CONFIG_ALLOW_CROSS"; value = "1"; }
        # ])
      ];
      # Every dependent also gets this variable?
      setupHook = buildPackages.writeText "openssl-sys-setup-env.sh" ''
          pkg-config-setup-env() {
            export PGK_CONFIG_ALLOW_CROSS=1
          }
          addEnvHooks "$hostOffset" pkg-config-setup-env
      '';
    };
  };

  pq-sys =
    let
      binEcho = s: "${pkgs.buildPackages.writeShellScriptBin "bin-echo" "echo ${s}"}/bin/bin-echo";
    in
      makeOverride {
        name = "pq-sys";
        overrideAttrs = drv: {
          # We can't use the host `pg_config` here, as it might not run on build platform. `pq-sys` only needs
          # to know the `lib` directory for `libpq`, so just create a fake binary that gives it exactly that.
          buildInputs = drv.buildInputs or [ ] ++ [
            (propagateEnv "pq-sys" [
              { name = "PG_CONFIG_${envize pkgs.stdenv.buildPlatform.config}"; value = binEcho "${(patchPostgresql pkgs.buildPackages).lib}/lib"; }
              { name = "PG_CONFIG_${envize pkgs.stdenv.hostPlatform.config}"; value = binEcho "${(patchPostgresql pkgs).lib}/lib"; }
            ])
          ];
        };
      };

  # Note that protobuff is from buildPackages and runs at the crate's
  # build-time, so it's a nativeBuildInput.  Every crate that depends on
  # prost-build might need protoc at runtime, so it's propagated.
  prost-build = makeOverride {
    name = "prost-build";
    overrideAttrs = drv: {
      propagatedNativeBuildInputs = drv.propagatedNativeBuildInputs or [ ] ++ [
        (propagateEnv "prost-build" [
          { name = "PROTOC"; value = "${pkgs.buildPackages.buildPackages.protobuf}/bin/protoc"; }
        ])
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

  rdkafka-sys = makeOverride {
    name = "rdkafka-sys";
    overrideAttrs = drv: {
      postConfigure = ''
        ${drv.postConfigure or ""}
        patchShebangs --build librdkafka/configure
      '';
    };
  };

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

  ring = if pkgs.stdenv.hostPlatform.isDarwin
    then makeOverride {
      name = "ring";
      overrideAttrs = drv: {
        propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [ pkgs.darwin.apple_sdk.frameworks.Security ];
      };
    }
    else nullOverride;

  soup2-sys = makeOverride {
    name = "soup2-sys";
    overrideAttrs = drv: {
      buildInputs = drv.buildInputs or [ ] ++ [ pkgs.libsoup.dev ];
    };
  };

  zmq-sys = makeOverride {
    name = "zmq-sys";
    overrideAttrs = drv: {
      buildInputs = drv.buildInputs or [ ] ++ [ pkgs.zeromq ];
    };
  };
}
