{ lib, runCommandNoCC, linkFarm }:
{ name, crates ? [] }:
let
  cratesByName =
    lib.foldl'
      (crates: crate:
        lib.recursiveUpdate
          crates
          {
            ${crate.name}.${crate.version} = crate;
          })
      {}
      crates;

  crateVersions = versions:
    lib.sort
      (lib.flip lib.versionOlder)
      (lib.attrNames versions);

  crateToSourcePath = name: versions:
    let
      versionList = crateVersions versions;
    in
    lib.imap0
      (idx: version:
        let
          crate = versions.${version};
        in
        {
          name = "${name}" + lib.optionalString (idx > 0) "-${crate.version}";
          path = runCommandNoCC "${name}-source" {} ''
            mkdir -p $out
            find ${crate.src} -mindepth 1 -maxdepth 1 -exec ln -st $out {} \+
            ln -s ${crate.cargo-checksum} $out/.cargo-checksum.json
          '';
        })
      versionList;
in
linkFarm
  "${name}-directory-source"
  (lib.flatten
    (lib.mapAttrsToList
      crateToSourcePath
      cratesByName))
