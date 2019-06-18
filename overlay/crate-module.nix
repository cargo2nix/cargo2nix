{ lib, options, config, mkLocalRegistry, mkDirectorySource, ... }:
with lib;
let
  crate = {...}: {
    options = {
      Cargo-toml = mkOption {
        type = with types; attrs;
      };
      cargo-checksum = mkOption {
        type = with types; path;
      };
      cksum = mkOption {
        type = with types; string;
      };
      crate = mkOption {
        type = with types; path;
      };
      name = mkOption {
        type = with types; string;
      };
      registry-entry = mkOption {
        type = with types; attrs;
      };
      src = mkOption {
        type = with types; path;
      };
      version = mkOption {
        type = with types; string;
      };
    };
  };

  registryOptions = { ... }: {
    options = {
      name = mkOption {
        type = with types; string;
        description = "Registry name";
      };
      index = mkOption {
        type = with types; string;
        description = "Registry index URI";
      };
      crates = mkOption {
        type = with types; listOf (submodule crate);
        default = [];
        description = "List of source packages of crates";
      };
    };
  };
  inherit (config) stdenv;
in
{
  options = {
    name = mkOption {
      type = with types; string;
      description = "Name of the crate";
    };

    src = mkOption {
      type = with types; path;
      description = ''
        Source of Rust crate
      '';
    };

    stdenv = mkOption {
      type = with types; package;
      description = ''
        Nix `stdenv` toolchain
      '';
    };

    cargo = mkOption {
      type = with types; package;
      description = ''
        Rust (Cargo) Compiler
      '';
    };

    environment = mkOption {
      type = with types; attrsOf string;
      description = ''
        Environment variables required by build
      '';
      example = ''
        environment.OPENSSL_DIR = "path/to/openssl"
      '';
    };

    dev-environment = mkOption {
      type = with types; attrsOf string;
      description = ''
        Environment variables required by development
      '';
      example = ''
        dev-environment.OPENSSL_DIR = "path/to/openssl"
      '';
    };

    buildInputs = mkOption {
      type = with types; listOf package;
      default = [];
      description = ''
        Packages that will run on the target machine, such as libraries
      '';
    };

    nativeBuildInputs = mkOption {
      type = with types; listOf package;
      default = [];
      description = ''
        Packages that will run on the build machine, such as libraries
      '';
    };

    derivationAttrs = mkOption {
      type = with types; attrsOf string;
      default = {};
      description = ''
        Arbitrary attributes passed into the derivation
      '';
    };

    registries = mkOption {
      default = {};
      type = with types; attrsOf (submodule registryOptions);
      description = "Registry configuration";
    };

    features = mkOption {
      default = [];
      type = with types; listOf string;
      description = ''
        List of features to be enabled
      '';
    };

    dev = mkOption {
      type = with types; package;
      description = "Development shell";
    };

    build = mkOption {
      type = with types; package;
      description = "Build output";
    };

    test = mkOption {
      type = with types; package;
      description = "test output";
    };
  };

  config =
  let
    indexDefs = {dev ? false}:
      map
        (registry:
          ''
            [registries.'${registry.name}']
            index = "${registry.index}"
            [source.'${registry.name}']
            registry = "${registry.index}"
            replace-with = "vendored-${registry.name}"
            [source.'vendored-${registry.name}']
          '' +
            (if dev then
              "local-registry = \"${mkLocalRegistry { inherit (registry) name crates; }}\""
            else
              "directory = \"${mkDirectorySource { inherit (registry) name crates; }}\"")
          )
        (attrValues (removeAttrs config.registries (optional dev "crates-io")));
    cargoConfigFile = {dev ? false}:
      stdenv.mkDerivation {
        name = "cargo-config";
        cargoConfig = concatStringsSep "\n" (indexDefs { inherit dev; });
        passAsFile = [ "cargoConfig" "buildCommand" ];
        buildCommand = ''
          cp $cargoConfigPath $out
        '';
      };
    environmentHook = env:
      concatStringsSep
        "\n"
        (mapAttrsToList
          (key: value: "export ${key}=${escapeShellArg value}")
          env);
    featureFlags = concatStringsSep " " config.features;
    featureArgs = lib.optionalString (length config.features > 0) "--features ${featureFlags}";
    derivationAttrs =
      removeAttrs
        config.derivationAttrs
        [
          "buildInputs"
          "nativeBuildInputs"
          "preBuild"
        ];
  in
  {
    dev =
      stdenv.mkDerivation ({
        name = "${config.name}-shell";
        nativeBuildInputs = config.nativeBuildInputs ++ [ config.cargo ];
        inherit (config) buildInputs;
        shellHook =
          ''
            mkdir -p .cargo
            cp ${cargoConfigFile { dev = true; }} .cargo/config
            echo 'package = []' > Cargo.lock
            cargo generate-lockfile
            ${environmentHook (config.environment // config.dev-environment)}
            ${config.preBuild or ""}
          '';
      } // derivationAttrs);

    test =
      stdenv.mkDerivation ({
        name = "${config.name}-test";
        nativeBuildInputs = config.nativeBuildInputs ++ [ config.cargo ];
        inherit (config) buildInputs src;
        message = "${config.name} ok";
        passAsFile = [ "message" ];
        preBuild =
          ''
            mkdir -p .cargo
            export HOME=`pwd`
            export CARGO_HOME=$HOME/.cargo
            cp ${cargoConfigFile {}} .cargo/config
            ${environmentHook config.environment}
            ${config.preBuild or ""}
          '';
        checkPhase = ''
          cargo test ${featureArgs} --frozen
        '';
        installPhase = ''
          cp $messagePath $out
        '';
      } // derivationAttrs);

    build =
      stdenv.mkDerivation ({
        nativeBuildInputs = with config; nativeBuildInputs ++ [ config.cargo ];
        inherit (config) buildInputs src name;
        configurePhase =
          ''
            mkdir -p .cargo
            export HOME=`pwd`
            export CARGO_HOME=$HOME/.cargo
            cp ${cargoConfigFile {}} .cargo/config
            ${environmentHook config.environment}
            ${config.preBuild or ""}
            echo cargo setup
          '';
        buildPhase = ''
          echo cargo build
          cargo build --release ${featureArgs} --frozen
        '';
        checkPhase = ''
          cargo test ${featureArgs} --frozen
        '';
        installPhase = ''
          mkdir -p $out/bin
          cargo install --frozen --path . --root $out/bin ${featureArgs}
        '';
      } // derivationAttrs);
  };
}
