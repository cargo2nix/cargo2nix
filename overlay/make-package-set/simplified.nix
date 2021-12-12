{
  pkgs,
  buildPackages,
  stdenv,
  rustBuilder,
}:
args@{
  rustVersion ? null,
  rustChannel ? null,
  rustToolchain ? null,
  rustProfile ? "minimal",
  extraRustComponents ? [],
  packageFun,
  workspaceSrc ? null,
  packageOverrides ? pkgs: pkgs.rustBuilder.overrides.all,
  target ? null,
  ...
}:
let
  extraArgs = builtins.removeAttrs args [ "rustChannel"
                                          "rustVersion"
                                          "rustToolchain"
                                          "packageFun"
                                          "packageOverrides"
                                          "target"];

  toolchainArgs = {
    extensions = [ "rust-src" ] ++ extraRustComponents;
    targets = [(rustBuilder.rustLib.rustTriple stdenv.buildPlatform)] ++
              (if target != null
               then [ target ]
               else [ (rustBuilder.rustLib.rustTriple stdenv.hostPlatform) ]);
  };

  # This logic is a little complex because of legacy use of "rustChannel" wich
  # could be a version string in previous eras.  Can deprecate at some point
  # after pointing everyone to correct usage.
  rustToolchain' =
    if rustToolchain != null
    then
      rustToolchain
    else
      if rustChannel == "nightly"
      then
        if rustVersion == null || rustVersion == "latest"
        then
          # don't use explicit "latest" attribute!  See oxalica README for more details.
          buildPackages.rust-bin.selectLatestNightlyWith
            (toolchain: toolchain.${rustProfile}.override toolchainArgs)
        else
          buildPackages.rust-bin.nightly
            .${args.rustVersion}
            .${rustProfile}.override toolchainArgs
      else
        if ((rustChannel != null &&
             (builtins.match "[0-9]\.[0-9]{1,2}\.[0-9]{1,2}" rustChannel) != null))
        then
          if rustVersion != null
          then
              builtins.throw "You gave rustChannel a version but also specified rustVersion (╯=▃= )╯︵┻━┻"
          else
            # rustChannel is actually a rustVersion.  Treat argument as legacy.
            buildPackages.rust-bin.stable
              .${args.rustChannel}
              .${rustProfile}.override toolchainArgs
        else
          let
            rustChannel' = if rustChannel != null then rustChannel else "stable";
          in
            buildPackages.rust-bin
              .${rustChannel'}
              .${args.rustVersion}
              .${rustProfile}.override toolchainArgs;

in rustBuilder.makePackageSet (extraArgs // {
  inherit packageFun workspaceSrc target;
  rustToolchain = rustToolchain';
  packageOverrides = packageOverrides pkgs;
  buildRustPackages = buildPackages.rustBuilder.makePackageSet (extraArgs // {
    inherit packageFun;
    rustToolchain = rustToolchain';
    target = null;
    packageOverrides = packageOverrides buildPackages;
  });
})
