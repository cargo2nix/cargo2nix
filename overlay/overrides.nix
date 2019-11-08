{ rustLib, lib, buildPackages }:
let
  inherit (rustLib) makeOverride nullOverride;
  envize = s: builtins.replaceStrings ["-"] ["_"] (lib.toUpper s);

  patchOpenssl = pkgs: (pkgs.openssl.override {
    # `perl` is only used at build time, but the derivation incorrectly uses host `perl` as an input.
    perl = pkgs.buildPackages.buildPackages.perl;
  }).overrideAttrs (_: {
    installTargets = "install_sw";
    outputs = [ "dev" "out" "bin" ];
  });

  joinOpenssl = openssl: buildPackages.symlinkJoin {
    name = "openssl"; paths = with openssl; [ out dev ];
  };

  patchPostgresql = pkgs: (pkgs.postgresql.override {
    openssl = patchOpenssl pkgs;
  }).overrideAttrs (drv: {
    # We don't need `systemd`. It breaks cross compilation.
    buildInputs = builtins.filter (d: !lib.hasPrefix "systemd" d.name) drv.buildInputs;
    configureFlags = builtins.filter (flag: flag != "--with-systemd") drv.configureFlags;
  });


  patchCurl = pkgs:
    let
      openssl = patchOpenssl pkgs;
    in pkgs.curl.override {
      inherit openssl;
      nghttp2 = pkgs.nghttp2.override { inherit openssl; };
      libssh2 = pkgs.libssh2.override { inherit openssl; };
      libkrb5 = pkgs.libkrb5.override { inherit openssl; };
    };

in
rec {
  patches = [ patchOpenssl patchCurl ];

  # Don't forget to add new overrides here.
  all = pkgs: [
    capLints
    (openssl-sys pkgs)
    (curl-sys pkgs)
    (libgit2-sys pkgs)
    (pq-sys pkgs)
    (prost-build pkgs)
    (rand_os pkgs)
    (rand pkgs)
  ];

  capLints = makeOverride {
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    overrideArgs = old: { rustcflags = old.rustcflags or [ ] ++ [ "--cap-lints" "warn" ]; };
  };

  openssl-sys = pkgs: makeOverride {
    name = "openssl-sys";
    overrideAttrs = _:
      # We don't use key literals here, as they might collide if `hostPlatform == buildPlatform`.
      builtins.listToAttrs [
        { name = "${envize pkgs.stdenv.buildPlatform.config}_OPENSSL_DIR"; value = joinOpenssl (patchOpenssl pkgs.buildPackages); }
        { name = "${envize pkgs.stdenv.hostPlatform.config}_OPENSSL_DIR"; value = joinOpenssl (patchOpenssl pkgs); }
      ];
  };

  curl-sys = pkgs: makeOverride {
    name = "curl-sys";
    overrideAttrs = drv: {
      propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [ (patchCurl pkgs) ];
    };
  };

  libgit2-sys = pkgs:
    if pkgs.stdenv.hostPlatform.isDarwin
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

  pq-sys = pkgs:
    let
      binEcho = s: "${pkgs.buildPackages.writeShellScriptBin "bin-echo" "echo ${s}"}/bin/bin-echo";
    in
      makeOverride {
        name = "pq-sys";
        overrideAttrs = _:
          # We don't use key literals here, as they might collide if `hostPlatform == buildPlatform`.
          # We can't use the host `pg_config` here either, as it might not run on build platform. `pq-sys` only needs
          # to know the `lib` directory for `libpq`, so just create a fake binary that gives it exactly that.
          builtins.listToAttrs [
            { name = "PG_CONFIG_${envize pkgs.stdenv.buildPlatform.config}"; value = binEcho "${(patchPostgresql pkgs.buildPackages).lib}/lib"; }
            { name = "PG_CONFIG_${envize pkgs.stdenv.hostPlatform.config}"; value = binEcho "${(patchPostgresql pkgs).lib}/lib"; }
          ];
      };

  prost-build = pkgs: makeOverride {
    name = "prost-build";
    overrideAttrs = _: {
      PROTOC = "${pkgs.buildPackages.buildPackages.protobuf}/bin/protoc";
    };
  };

  rand_os = pkgs:
    if pkgs.stdenv.hostPlatform.isDarwin
    then makeOverride {
      name = "rand_os";
      overrideAttrs = drv: {
        propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [ pkgs.darwin.apple_sdk.frameworks.Security ];
      };
    }
    else nullOverride;

  rand = pkgs:
    if pkgs.stdenv.hostPlatform.isDarwin
    then makeOverride {
      name = "rand";
      overrideAttrs = drv: {
        propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [ pkgs.darwin.apple_sdk.frameworks.Security ];
      };
    }
    else nullOverride;

}
