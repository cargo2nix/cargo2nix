{ mkCrate, mkDirectorySource, mkLocalRegistry, fetchurl }:
{ lockFileContent }:
let
  Cargo-lock = builtins.fromTOML lockFileContent;

  crates =
    map
      (crate:
        mkCrate {
          tarball = (fetchurl {
            name = "${crate.name}-${crate.version}.tar.gz";
            url = "https://crates.io/api/v1/crates/${crate.name}/${crate.version}/download";
            sha256 = Cargo-lock.metadata."checksum ${crate.name} ${crate.version} (${crate.source})";
          });
        })
      (builtins.filter
        (pkg: pkg.source or "" == "registry+https://github.com/rust-lang/crates.io-index")
        Cargo-lock.package);
in
{
  name = "crates-io";
  index = "https://github.com/rust-lang/crates.io-index";
  inherit crates;
}
