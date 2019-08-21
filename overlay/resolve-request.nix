{ lib }:
{ packageFun, initial, stdenv }:
let
  isPackage = { f = {}: {}; };
  packageSet =
    packageFun
      {
        config = {};
        pkgs = {};
        callPackage = null;
        mkRustCrate =
          {package-id, dependencies, cargo-manifest, ...}: {
            inherit isPackage package-id;
            ${package-id} = {
              inherit package-id cargo-manifest dependencies;
            };
          };
      }
      packageSet;
  inherit (packageSet) sources;

  collectedPackages =
    map
      (p: { ${p.package-id} = p.${p.package-id}; })
      (lib.collect
        (p: p.isPackage or null == isPackage)
        packageSet);

  serializePlatform = platform:
    {
      inherit (platform)
        is32bit
        is64bit
        isAndroid
        isBigEndian
        isLittleEndian
        isFreeBSD
        isNetBSD
        isOpenBSD
        isiOS
        isLinux
        isMacOS
        isMips
        isUnix
        isWindows
        config
        libc
      ;
      parsed = {
        cpu.name = platform.parsed.cpu.name;
        vendor.name = platform.parsed.vendor.name;
      };
    };
in
{
  packages = lib.foldl lib.recursiveUpdate {} collectedPackages;
  buildPlatform = serializePlatform stdenv.buildPlatform;
  hostPlatform = serializePlatform stdenv.hostPlatform;
  inherit initial;
}
