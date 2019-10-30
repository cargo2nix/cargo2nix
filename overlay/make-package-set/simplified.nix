args@{
  pkgs,
  buildPackages,
  stdenv,
  rustBuilder,
  rustChannel,
  packageFun,
  rustPackageConfig ? _: { },
  ...
}:
let
  rustChannel = buildPackages.rustChannelOf {
    channel = "1.37.0";
  };
  inherit (rustChannel) cargo;
  rustc = rustChannel.rust.override {
    targets = [
      (rustBuilder.rustLib.realHostTriple stdenv.targetPlatform)
    ];
  };
  extraArgs = builtins.removeAttrs args [ "stdenv" "pkgs" "buildPackages" "rustBuilder" "rustChannel" "packageFun" "rustPackageConfig" ];
in
rustBuilder.makePackageSet (extraArgs // {
  inherit cargo rustc packageFun;
  rustPackageConfig = rustPackageConfig pkgs;
  buildRustPackages = buildPackages.rustBuilder.makePackageSet (extraArgs // {
      inherit cargo rustc packageFun;
      rustPackageConfig = rustPackageConfig buildPackages;
  });
})
