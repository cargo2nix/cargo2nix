{
  pkgs,
  buildPackages,
  stdenv,
  rustBuilder,
}:
args@{
  # required arg
  packageFun,

  # optional args
  rustChannel ? null,
  rustVersion ? null,
  rustToolchain ? null,
  rustProfile ? "minimal",
  extraRustComponents ? [],
  packageOverrides ? pkgs: pkgs.rustBuilder.overrides.all,
  target ? null,
  workspaceSrc ? null,
  ignoreLockHash ? false,
  ...
}:
let
  # These are used in this function, and we clean them out for downstream
  extraArgs = builtins.removeAttrs args [ "rustChannel"
                                          "rustVersion"
                                          "rustProfile"
                                          "rustToolchain"
                                          "extraRustComponents"
                                          "packageFun"
                                          "nixifiedLockHash"
                                          "packageOverrides"
                                          "target" ];

  # Rust targets don't always map perfectly to Nix targets, so they are allowed
  # to be independent by specicying an explicit Rust target.
  toolchainArgs = {
    extensions = [ "rust-src" ] ++ extraRustComponents;
    targets = [(rustBuilder.rustLib.rustTriple stdenv.buildPlatform)] ++
              (if target != null
               then [ target ]
               else [ (rustBuilder.rustLib.rustTriple stdenv.hostPlatform) ]);
  };

  # Normalize the toolchain args and build a toolchain or used the provided
  # toolchain.  This logic is a bit complicated by legacy use of "rustChannel"
  # wich could be a version string in previous eras.  Can deprecate at some
  # point after pointing everyone to correct usage.  Note that rustToolchain
  # comes from buildPackages.rust-bin.  The overlay has been applied and
  # returned via callPackage.
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


  # Cargo2nix requires a rustc in order to run.  This runtime dependency is
  # grafted on here to avoid noise in the flake and because we know what Rust
  # toolchain is in use at this point of expression.
  packageOverrides' = pkgs: packageOverrides (pkgs) ++ [(pkgs.rustBuilder.rustLib.makeOverride {
    name = "cargo2nix";
    overrideAttrs = drv: {
      nativeBuildInputs = drv.nativeBuildInputs or [] ++ [ pkgs.makeWrapper ];
      postFixup = ''
        if [[ -x $bin/bin/cargo2nix ]]; then
          wrapProgram $bin/bin/cargo2nix --prefix PATH : ${pkgs.lib.makeBinPath [ rustToolchain' ]};
        fi
      '';
    };
  })];

# This expression finally evaluates the result of makePackageSet.
# makePackageSetInternal is where overrides are applied and the splice is
# performed.  Note that buildRustPackages is just buildPackages with a null
# target.
in rustBuilder.makePackageSetInternal (extraArgs // {
  inherit packageFun ignoreLockHash workspaceSrc target;
  rustToolchain = rustToolchain';
  packageOverrides = packageOverrides' pkgs;
  buildRustPackages = buildPackages.rustBuilder.makePackageSetInternal (extraArgs // {
    inherit packageFun ignoreLockHash workspaceSrc;
    rustToolchain = rustToolchain';
    target = null;
    packageOverrides = packageOverrides' buildPackages;
  });
})
