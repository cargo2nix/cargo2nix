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
  extraArgs = builtins.removeAttrs args [ "rustChannel" "packageFun" "packageOverrides" ];
  rustChannel = buildPackages.rust-bin.stable.${args.rustChannel}.minimal.override {
    extensions = [ "rust-src" ];
    targets = [
      (rustBuilder.rustLib.realHostTriple stdenv.targetPlatform)
    ];
  };
in rustBuilder.makePackageSet (extraArgs // {
  inherit packageFun workspaceSrc rustChannel;
  packageOverrides = packageOverrides pkgs;
  buildRustPackages = buildPackages.rustBuilder.makePackageSet (extraArgs // {
    inherit rustChannel packageFun;
    packageOverrides = packageOverrides buildPackages;
  });
})
