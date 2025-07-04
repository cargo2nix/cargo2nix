# This file was @generated by cargo2nix 0.12.0.
# It is not intended to be manually edited.

args@{
  release ? true,
  rootFeatures ? [
    "cross-compiling/default"
  ],
  rustPackages,
  buildRustPackages,
  hostPlatform,
  hostPlatformCpu ? null,
  hostPlatformFeatures ? [],
  target ? null,
  codegenOpts ? null,
  profileOpts ? null,
  cargoUnstableFlags ? null,
  rustcLinkFlags ? null,
  rustcBuildFlags ? null,
  mkRustCrate,
  rustLib,
  lib,
  workspaceSrc,
  ignoreLockHash,
  cargoConfig ? {},
}:
let
  nixifiedLockHash = "c787740d469acf71a36abd0a236a69f5b797b67eff93b9b6bd0321ea533a45ef";
  workspaceSrc = if args.workspaceSrc == null then ./. else args.workspaceSrc;
  currentLockHash = builtins.hashFile "sha256" (workspaceSrc + /Cargo.lock);
  lockHashIgnored = if ignoreLockHash
                  then builtins.trace "Ignoring lock hash" ignoreLockHash
                  else ignoreLockHash;
in if !lockHashIgnored && (nixifiedLockHash != currentLockHash) then
  throw ("Cargo.nix ${nixifiedLockHash} is out of sync with Cargo.lock ${currentLockHash}")
else let
  inherit (rustLib) fetchCratesIo fetchCrateLocal fetchCrateGit fetchCrateAlternativeRegistry expandFeatures decideProfile genDrvsByProfile;
  cargoConfig' = if cargoConfig != {} then cargoConfig else
                 if builtins.pathExists ./.cargo/config then lib.importTOML ./.cargo/config else
                 if builtins.pathExists ./.cargo/config.toml then lib.importTOML ./.cargo/config.toml else {};
  profilesByName = {
  };
  rootFeatures' = expandFeatures rootFeatures;
  overridableMkRustCrate = f:
    let
      drvs = genDrvsByProfile profilesByName ({ profile, profileName }: mkRustCrate ({
        inherit release profile hostPlatformCpu hostPlatformFeatures target profileOpts codegenOpts cargoUnstableFlags rustcLinkFlags rustcBuildFlags; 
        cargoConfig = cargoConfig';
      } // (f profileName)));
    in { compileMode ? null, profileName ? decideProfile compileMode release }:
      let drv = drvs.${profileName}; in if compileMode == null then drv else drv.override { inherit compileMode; };
in
{
  cargo2nixVersion = "0.12.0";
  workspace = {
    cross-compiling = rustPackages.unknown.cross-compiling."0.1.0";
  };
  "registry+https://github.com/rust-lang/crates.io-index".arrayvec."0.5.2" = overridableMkRustCrate (profileName: rec {
    name = "arrayvec";
    version = "0.5.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "23b62fc65de8e4e7f52534fb52b0f3ed04746ae267519eef2a83941e8085068b"; };
    features = builtins.concatLists [
      [ "array-sizes-33-128" ]
    ];
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".base64."0.11.0" = overridableMkRustCrate (profileName: rec {
    name = "base64";
    version = "0.11.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "b41b7ea54a0c9d92199de89e20e58d49f02f8e699814ef3fdf266f6f748d15c7"; };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".bitflags."1.3.2" = overridableMkRustCrate (profileName: rec {
    name = "bitflags";
    version = "1.3.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "bef38d45163c2f1dde094a7dfd33ccf595c92905c8f8f4fdc18d06fb1037718a"; };
    features = builtins.concatLists [
      [ "default" ]
    ];
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".bytecount."0.6.4" = overridableMkRustCrate (profileName: rec {
    name = "bytecount";
    version = "0.6.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "ad152d03a2c813c80bb94fedbf3a3f02b28f793e39e7c214c8a0bcc196343de7"; };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".cfg-if."1.0.0" = overridableMkRustCrate (profileName: rec {
    name = "cfg-if";
    version = "1.0.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"; };
  });
  
  "unknown".cross-compiling."0.1.0" = overridableMkRustCrate (profileName: rec {
    name = "cross-compiling";
    version = "0.1.0";
    registry = "unknown";
    src = fetchCrateLocal workspaceSrc;
    buildDependencies = {
      ructe = (buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".ructe."0.9.2" { profileName = "__noProfile"; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".either."1.9.0" = overridableMkRustCrate (profileName: rec {
    name = "either";
    version = "1.9.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "a26ae43d7bcc3b814de94796a5e736d4029efb0ee900c12e2d54c993ad1a1e07"; };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".itertools."0.8.2" = overridableMkRustCrate (profileName: rec {
    name = "itertools";
    version = "0.8.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "f56a2d0bc861f9165be4eb3442afd3c236d8a98afd426f65d92324ae1091a484"; };
    features = builtins.concatLists [
      [ "default" ]
      [ "use_std" ]
    ];
    dependencies = {
      either = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".either."1.9.0" { inherit profileName; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".lexical-core."0.7.6" = overridableMkRustCrate (profileName: rec {
    name = "lexical-core";
    version = "0.7.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "6607c62aa161d23d17a9072cc5da0be67cdfc89d3afb1e8d9c842bebc2525ffe"; };
    features = builtins.concatLists [
      [ "arrayvec" ]
      [ "correct" ]
      [ "default" ]
      [ "ryu" ]
      [ "static_assertions" ]
      [ "std" ]
      [ "table" ]
    ];
    dependencies = {
      arrayvec = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".arrayvec."0.5.2" { inherit profileName; }).out;
      bitflags = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".bitflags."1.3.2" { inherit profileName; }).out;
      cfg_if = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."1.0.0" { inherit profileName; }).out;
      ryu = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".ryu."1.0.15" { inherit profileName; }).out;
      static_assertions = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".static_assertions."1.1.0" { inherit profileName; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".md5."0.7.0" = overridableMkRustCrate (profileName: rec {
    name = "md5";
    version = "0.7.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "490cc448043f947bae3cbee9c203358d62dbee0db12107a74be5c30ccfd09771"; };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".memchr."2.6.4" = overridableMkRustCrate (profileName: rec {
    name = "memchr";
    version = "2.6.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "f665ee40bc4a3c5590afb1e9677db74a508659dfd71e126420da8274909a0167"; };
    features = builtins.concatLists [
      [ "alloc" ]
      [ "std" ]
      [ "use_std" ]
    ];
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".nom."5.1.3" = overridableMkRustCrate (profileName: rec {
    name = "nom";
    version = "5.1.3";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "08959a387a676302eebf4ddbcbc611da04285579f76f88ee0506c63b1a61dd4b"; };
    features = builtins.concatLists [
      [ "alloc" ]
      [ "default" ]
      [ "lexical" ]
      [ "lexical-core" ]
      [ "std" ]
    ];
    dependencies = {
      lexical_core = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".lexical-core."0.7.6" { inherit profileName; }).out;
      memchr = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".memchr."2.6.4" { inherit profileName; }).out;
    };
    buildDependencies = {
      version_check = (buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".version_check."0.9.4" { profileName = "__noProfile"; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".ructe."0.9.2" = overridableMkRustCrate (profileName: rec {
    name = "ructe";
    version = "0.9.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "c85620b8046f88a870d93d90fa56904dec76cc79139bfcc22e71e87f0cd2169f"; };
    dependencies = {
      base64 = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".base64."0.11.0" { inherit profileName; }).out;
      bytecount = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".bytecount."0.6.4" { inherit profileName; }).out;
      itertools = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".itertools."0.8.2" { inherit profileName; }).out;
      md5 = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".md5."0.7.0" { inherit profileName; }).out;
      nom = (rustPackages."registry+https://github.com/rust-lang/crates.io-index".nom."5.1.3" { inherit profileName; }).out;
    };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".ryu."1.0.15" = overridableMkRustCrate (profileName: rec {
    name = "ryu";
    version = "1.0.15";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "1ad4cc8da4ef723ed60bced201181d83791ad433213d8c24efffda1eec85d741"; };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".static_assertions."1.1.0" = overridableMkRustCrate (profileName: rec {
    name = "static_assertions";
    version = "1.1.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "a2eb9349b6444b326872e140eb1cf5e7c522154d69e7a0ffb0fb81c06b37543f"; };
  });
  
  "registry+https://github.com/rust-lang/crates.io-index".version_check."0.9.4" = overridableMkRustCrate (profileName: rec {
    name = "version_check";
    version = "0.9.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo { inherit name version; sha256 = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"; };
  });
  
}
