{ pkgs, rustPackages, rustToolchain }:
# The resulting function is a decoration of mkShell.  Usually mkShell is only
# given an inputsFrom that is a single package or packages without overlap in
# dependencies.  However, we seek to provide a shell that is complete for every
# rust crate in the entire workspace.  However, if we naively pass all rust
# crates to inputsFrom, many dependencies will be duplicated via propagation or
# multiple inclusion.  Therefore, instead create the dependency sets from the
# rust crates are collected and de-duplicated before passing them to the normal
# mkShell.  This is also done for the shellHook, just slightly differently.  The
# source is really similar to nixpkgs mkShell that it decorates, so study one
# and understand both.
{ name ? "nix-shell"
, # a list of packages to add to the shell environment
  packages ? [ ]
, # propagate all the inputs from the given derivations
  inputsFrom ? [ ]
, buildInputs ? [ ]
, nativeBuildInputs ? [ ]
, propagatedBuildInputs ? [ ]
, propagatedNativeBuildInputs ? [ ]
, ...
}@attrs:
let
  lib = pkgs.lib;

  # mkShell in the end will pass through arguments that it doesn't explicitly
  # handle onward to mkDerivation.  Arguments removed at this point will be
  # consumed and propagated by this function.
  rest = builtins.removeAttrs attrs [
    "buildInputs"
    "nativeBuildInputs"
    "propagatedBuildInputs"
    "propagatedNativeBuildInputs"
    "shellHook"
  ];

  # The crate functions from which we will gather the inputs must be called to
  # yield finished crate derivations.  It is important to note that they will be
  # called with their default arguments.  Augmentation of the crates which may
  # affect their dependencies in the user's flake will result in inconsistency,
  # so if such behavior exists or is added by the user, a mechanism must be
  # introduced to propagate these effects on dependencies into the shell.

  # TODO note that if package set is created from nixpkgs for another platform,
  # it will be inappropriate for creating a workspace shell.  Flakes written for
  # cross compilation but still get their workspaceShell from a package set for
  # the build platform.

  # TODO This is fragile because any path in the entire set that is not a crate
  # function will cause failure.  Recent changes to overlay/make-package-set or
  # overlay/default, even changes to Nix itself could add a path.  Replace this
  # with some construct with no possibility of non-crate contamination.
  crateFunctions = builtins.removeAttrs rustPackages
    ["workspace"
     "workspaceShell"
     "cargo2nixVersion"
     "rustToolchain"
     "rustPackages"
     "pkgs"
     "noBuild"
     "mkRustCrate"
     "callPackage"
     "buildRustPackages"
     "__unfix__"
     "__splicedPackages"];

  # Note that out paths must match between the crate and the crates dependencies
  # (crates depend on crate.out) or else you will get multiple inclusion and
  # crates themselves in the shell depencnedies.  Cargo can build rust deps, so
  # they are not needed in the development shell, nor will they be used by cargo
  # outside of nix builds.
  crates = map (pkg: (pkg { }).out) (pkgs.lib.collect builtins.isFunction crateFunctions);

  # This function will extract the attr "name" from all crates, augment this
  # list with the "name" from @attrs, remove explicit overlap with inputsFrom,
  # and finally de-duplicate with unique.
  mergeCrateInputs = name:
    (lib.unique
      (lib.subtractLists (packages ++ inputsFrom ++ crates)
        ((attrs.${name} or [ ]) ++ (lib.flatten (lib.catAttrs name crates)))));

in pkgs.mkShell (rest // {

  # TODO investigate if cacert is needed or had been omitted in previous implementation
  buildInputs = mergeCrateInputs "buildInputs";
  nativeBuildInputs = (mergeCrateInputs "nativeBuildInputs") ++ [ rustToolchain ] ++ (with pkgs; [cacert]);
  propagatedBuildInputs = mergeCrateInputs "propagatedBuildInputs";
  propagatedNativeBuildInputs = mergeCrateInputs "propagatedNativeBuildInputs";

  # Create a composite shellHook from the user passed shellHook and the rust
  # crates' shellHooks.  This hook will be merged by mkShell with the shellHooks
  # in inputsFrom
  shellHook = lib.concatStringsSep "\n" (lib.unique (lib.catAttrs "shellHook"
    (lib.reverseList crates ++ [ attrs ])));

  # Configures tools like Rust Analyzer to locate the correct rust-src
  RUST_SRC_PATH = "${rustToolchain}/lib/rustlib/src/rust/library";
})
