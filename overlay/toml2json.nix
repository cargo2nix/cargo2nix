{ lib, remarshal, runCommand }:
toml:
let
  json = runCommand
    "to.json"
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
