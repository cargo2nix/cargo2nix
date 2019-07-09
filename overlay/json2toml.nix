{ remarshal, runCommand }:
json:
  runCommand
    "to.toml"
    {
      nativeBuildInputs = [remarshal];
      passAsFile = [ "json" ];
      json = builtins.toJSON json;
    }
    ''
      cat $jsonPath | json2toml -i - -o $out
    ''
