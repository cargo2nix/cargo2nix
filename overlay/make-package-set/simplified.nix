{
  pkgs,
  buildPackages,
  stdenv,
  rustBuilder,
}:
args@{
  rustChannel,
  packageFun,
  workspaceSrc ? null,
  packageOverrides ? pkgs: pkgs.rustBuilder.overrides.all,
  ...
}:
let
  rustChannel' = buildPackages.rustChannelOf ({
    channel = args.rustChannel;
  });
  inherit (rustChannel') cargo;
  rustc = rustChannel'.rust.override {
    targets = [
      (rustBuilder.rustLib.realHostTriple stdenv.targetPlatform)
    ];
  };
  extraArgs = builtins.removeAttrs args [ "rustChannel" "packageFun" "packageOverrides" ];
in let
  rustChannel = rustChannel' // {inherit rustc cargo;};
in rustBuilder.makePackageSet (extraArgs // {
  inherit rustChannel packageFun workspaceSrc;
  packageOverrides = packageOverrides pkgs;
  buildRustPackages = buildPackages.rustBuilder.makePackageSet (extraArgs // {
    inherit rustChannel packageFun;
    packageOverrides = packageOverrides buildPackages;
  });
})
