{ lib, remarshal, runCommand }:
{ name, toml }:
let
  json = runCommand
    "${name}-to.json"
    {
      nativeBuildInputs = [remarshal];
      passAsFile = [ "toml" ];
      inherit toml;
    }
    ''
      cat $tomlPath | toml2json -i - -o $out
    '';
in
lib.importJSON json
