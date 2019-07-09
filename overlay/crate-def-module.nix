{ lib, options, config, ...}:
with lib;
let
  dependency = {...}: {
    options = {
      version = mkOption {
        description = "Version of dependency";
        type = with types; string;
      };
      default-features = mkOption {
        description = "Switch for enabling default features";
        type = with types; bool;
        default = true;
      };
      optional = mkOption {
        description = "Switch for setting this dependency as optional";
        type = with types; bool;
        default = false;
      };
      features = mkOption {
        description = "Features enabled";
        type = with types; listOf string;
        default = [];
      };
      registry = mkOption {
        description = "Name of the registry this crate belongs to";
        type = with types; nullOr string;
        default = null;
      };
    };
  };
  dependency-specification = {...}: {
    options = {
      dependencies = mkOption {
        description = "Runtime dependencies";
        type = with types; attrsOf (submodule dependency);
        default = {};
      };
      build-dependencies = mkOption {
        description = "Build time dependencies";
        type = with types; attrsOf (submodule dependency);
        default = {};
      };
      dev-dependencies = mkOption {
        description = "Development dependencies";
        type = with types; attrsOf (submodule dependency);
        default = {};
      };
    };
  };
in
fix (self: {
  options = {
    src = mkOption {
      description = "Source of this library crate";
      type = with types; path;
    };
    name = mkOption {
      description = "Name of the crate";
      type = with types; string;
    };
    registry.name = mkOption {
      description = "Name of registry";
      type = with types; string;
    };
    registry.index = mkOption {
      description = "Index URI of registry";
      type = with types; string;
    };
    environment = mkOption {
      description = "Build time environment";
      type = with types; attrsOf string;
      default = {};
    };
    dev-environment = mkOption {
      description = "Development time environment";
      type = with types; attrsOf string;
      default = {};
    };
    buildInputs = mkOption {
      description = "Target platform dependencies";
      type = with types; listOf package;
      default = [];
    };
    nativeBuildInputs = mkOption {
      description = "Build platform dependencies";
      type = with types; listOf package;
      default = [];
    };
    default-platform-deps = mkOption {
      description = "Dependency specification on the default platform";
      type = with types; submodule dependency-specification;
      default = {
        dependencies = {};
        dev-dependencies = {};
        build-dependencies = {};
      };
    };
    target-platform-deps = mkOption {
      description = "Dependency specification on target platforms";
      type = with types; attrsOf (submodule dependency-specification);
      default = {};
    };
    managed-deps = mkOption {
      description = "Managed crates by this module system";
      type = with types; listOf (submodule self);
      default = [];
    };
    manifest = mkOption {
      description = "Unmanaged portion of Cargo.toml, including the [package] section";
      type = with types; string;
    };
  };
})
