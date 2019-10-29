{ remarshal, runCommand }:
{ name, json }:
  runCommand
    "${name}-to.toml"
    {
      nativeBuildInputs = [remarshal];
      passAsFile = [ "json" ];
      json = builtins.toJSON json;
    }
    ''
      cat $jsonPath | json2toml -i - -o $out
    ''
