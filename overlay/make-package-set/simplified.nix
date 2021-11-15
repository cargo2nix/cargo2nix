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
  target ? null,
  ...
}:
let
  extraArgs = builtins.removeAttrs args [ "rustChannel" "packageFun" "packageOverrides" "target"];
  rustChannel = buildPackages.rust-bin.stable.${args.rustChannel}.minimal.override {
    extensions = [ "rust-src" ];
    targets = [
      (if (target != null) then target else (rustBuilder.rustLib.realHostTriple stdenv.hostPlatform))
    ];
  };
in rustBuilder.makePackageSet (extraArgs // {
  inherit packageFun workspaceSrc rustChannel target;
  packageOverrides = packageOverrides pkgs;
  buildRustPackages = buildPackages.rustBuilder.makePackageSet (extraArgs // {
    inherit rustChannel packageFun;
    target = (rustBuilder.rustLib.realHostTriple stdenv.buildPlatform);
    packageOverrides = packageOverrides buildPackages;
  });
})
