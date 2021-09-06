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
  target ? (rustBuilder.rustLib.realHostTriple stdenv.targetPlatform),
  ...
}:
let
  rustChannel' = buildPackages.rustChannelOf ({
    channel = args.rustChannel;
  });
  inherit (rustChannel') cargo;
  rustc = rustChannel'.rust.override {
    targets = [
      target
    ];
  };
  extraArgs = builtins.removeAttrs args [ "rustChannel" "packageFun" "packageOverrides" "target" ];
in let
  rustChannel = rustChannel' // {inherit rustc cargo;};
in rustBuilder.makePackageSet (extraArgs // {
  inherit rustChannel packageFun workspaceSrc target;
  packageOverrides = packageOverrides pkgs;
  buildRustPackages = buildPackages.rustBuilder.makePackageSet (extraArgs // {
    inherit rustChannel packageFun;
    target = (rustBuilder.rustLib.realHostTriple stdenv.hostPlatform);
    packageOverrides = packageOverrides buildPackages;
  });
})
