{ stdenv, cargo, lib, mkLocalRegistry, mkDirectorySource, instantiateCrate, mkCrate, cratesIoRegistry }:
{ def }:
with lib;
let
  initial = {...}: {
    _module.args = {
      inherit lib mkLocalRegistry mkDirectorySource;
    };
  };

  crate = evalModules {
    modules = [
      initial
      ./crate-def-module.nix
      def
    ];
  };

  depsToTomlConfig = cond: deps:
    let
      convert = type:
        mapAttrsToList (
          name: spec:
          ''
          [${type}.${name}]
          version = "${spec.version}"
          default-features = ${boolToString spec.default-features}
          features = [${concatStringsSep "," (map (f: "\"${f}\"") spec.features)}]
          optional = ${boolToString spec.optional}
          ${optionalString (spec.registry != null) "registry = \"${spec.registry}\""}
          '');
      table-header = optionalString (cond != null) "target.'${cond}'.";
    in
      convert "${table-header}dependencies" deps.dependencies ++
      convert "${table-header}dev-dependencies" deps.dev-dependencies ++
      convert "${table-header}build-dependencies" deps.build-dependencies;

  Cargo-toml-content = concatStringsSep "\n" (
    [ crate.config.manifest ] ++
    depsToTomlConfig null crate.config.default-platform-deps ++
    flatten
      (mapAttrsToList
        (cond: deps: depsToTomlConfig null deps)
        crate.config.target-platform-deps));

  Cargo-toml = builtins.toFile "Cargo.toml" Cargo-toml-content;

  depCrates = map (def: instantiateCrate { inherit def; }) crate.config.managed-deps;

  dev-environment =
    foldr
      (a: b: a // b)
      crate.config.dev-environment
      (map (dep: dep.config.dev-environment) depCrates);

  environment =
    foldr
      (a: b: a // b)
      crate.config.environment
      (map (dep: dep.config.environment) depCrates);

  buildInputs =
    crate.config.buildInputs ++
    flatten (map (dep: dep.config.buildInputs) depCrates);

  nativeBuildInputs =
    crate.config.nativeBuildInputs ++
    flatten (map (dep: dep.config.nativeBuildInputs) depCrates);

  depTests = map (dep: dep.config.test) depCrates;

  src = stdenv.mkDerivation {
    name = "source";
    inherit (crate.config) src;
    installPhase = ''
      mkdir -p $out
      cp -R ./. $out/
      cp ${Cargo-toml} $out/Cargo.toml
    '';
  };

  registries =
    let
      subRegs = map (dep: dep.config.registries) depCrates;

      crateRegs =
        map
          (dep: {
            ${dep.registry.name} = {
              inherit (dep.registry) name index;
              crates = [(mkCrate { inherit (dep) src; })];
            };
          })
          crate.config.managed-deps;

      lockFileContent = builtins.readFile "${crate.config.src}/Cargo.lock";

      cratesIoReg =
        {
          crates-io = cratesIoRegistry { inherit lockFileContent; };
        };
    in
    zipAttrsWith
      (name: rs: {
        inherit name;
        index = (elemAt rs 0).index;
        crates = concatMap (r: r.crates) rs;
      })
      (subRegs ++ crateRegs ++ [ cratesIoReg ]);

  crate-module = {...}: {
    inherit (crate.config) name;
    inherit
      buildInputs
      cargo
      dev-environment
      environment
      nativeBuildInputs
      registries
      src
      stdenv
      ;
  };
in
evalModules {
  modules = [
    initial
    ./crate-module.nix
    crate-module
  ];
}
