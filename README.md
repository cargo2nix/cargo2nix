# cargo2nix

[![all builds & CI](https://github.com/cargo2nix/cargo2nix/actions/workflows/ci.yml/badge.svg)](https://github.com/cargo2nix/cargo2nix/actions/?workflow=CI)
[![build on Linux](https://badgen.net/github/checks/cargo2nix/cargo2nix/master/ubuntu)](https://github.com/cargo2nix/cargo2nix/actions/?workflow=CI)
[![build on Darwin](https://badgen.net/github/checks/cargo2nix/cargo2nix/master/mac)](https://github.com/cargo2nix/cargo2nix/actions/?workflow=CI)
[![flakes supported](https://img.shields.io/badge/flake-supported-green)](https://nixos.wiki/wiki/Flakes)
[![latest release](https://img.shields.io/github/v/tag/cargo2nix/cargo2nix?color=%23009922&label=release)](https://github.com/cargo2nix/cargo2nix/releases)

Bring [Nix](https://nixos.org/nix) dependency management to your Rust project!

- **Development Shell** - knowing all the dependencies means seamless direnv
  integration.  `nix develop` or `direnv activate` in this repo and see!
- **Caching** - CI & CD pipelines move faster when purity guarantees allow
  skipping more work!
- **Reproducibility** - Pure builds.  Access to all of
  [nixpkgs](https://github.com/NixOS/nixpkgs) for repeatable environment setup
  across multiple distributions and platforms

## Run it now!

With [nix](https://nixos.org/nix) (with flake support) installed, generate a
`Cargo.nix` for your project:

```bash
# Use nix to get it on your path
nix shell github:cargo2nix/cargo2nix

# In directory with Cargo.lock & Cargo.toml files
cargo2nix

# Or skip the shell and run it right off the flake
nix run github:cargo2nix/cargo2nix

# You'll need this in version control
git add Cargo.nix
```

### Set up the rest!

To consume your new `Cargo.nix`, write a nix expression like that found in the
[hello world] example or for a more complete project with CI & CD mostly ready
to go, check out [Unixsocks].

[hello world]: https://github.com/cargo2nix/cargo2nix/blob/master/examples/1-hello-world/flake.nix
[Unixsocks]: https://github.com/positron-solutions/unixsocks

A bare minimum flake.nix:

```nix
{
  inputs = {
    cargo2nix.url = "github:cargo2nix/cargo2nix/master";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs?ref=release-21.05";
  };

  outputs = { self, nixpkgs, cargo2nix, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [cargo2nix.overlay];
        };

        rustPkgs = pkgs.rustBuilder.makePackageSet' {
          rustVersion = "1.57.0";
          packageFun = import ./Cargo.nix;
        };

      in rec {
        packages = {
          # replace hello-world with your package name
          hello-world = (rustPkgs.workspace.hello-world {}).bin;
        };
        defaultPackage = packages.hello-world;
      }
    );
}
```

#### Build with nix

```shell
# these must be in version control
git add flake.nix Cargo.nix

nix build
...
...
...
./result-bin/bin/hello
hello world!
```

Check out our series of [example projects](./examples) which showcase how to use
`cargo2nix` in more detail.

### Development environment

In this repo, simply use `nix develop` and even if you are on a bare NixOS
system or fresh OSX environment with no dependencies or toolchains installed,
you will have everything you need to run `cargo build`.  See the `devShell`
attribute in `flake.nix` to see how to prepare this kind of shell.

### More Options

`makePackageSet'` supports many options that control all of the crates that will
be created. See [flake.nix](./flake.nix) for a more detailed listing.
    
- `rustVersion` - is either a version string or YYYY-MM-DD date-string
- `rustChannel` - `"nightly"` `"beta"` `"stable"`
- `rustProfile` - `"default"` or `"minimal"` usually
- `extraRustComponents` - `["clippy" "miri"]` etc

- `workspaceSrc` - override where the source is supplied relative to the
  Cargo.nix
- `rootFeatures` - a list of `foo/feature` strings for workspace crate features
- `packageOverrides` - control over the individual crate overrides used to make
  them compatible on some platforms, for example to tweak C lib consumption
  
- `target` - setting an explicit target, useful when cross compiling to obtain a
  specific Rust target that doesn't align with the nixpkgs target

Each crate in the resulting `rustPkgs` is a function that also accepts some
arguments.

- `compileMode` - "build" "bench" "doctest" etc

## How it works

- The `cargo2nix` utility reads the workspace configs and `Cargo.lock` and
  generates nix expressions that encode some of the feature, platform, and
  target logic into a `Cargo.nix`

- The cargo2nix [Nixpkgs](https://github.com/NixOS/nixpkgs) [overlay] consumes
  the `Cargo.nix`, feeding it what you pass to `makePackageSet'` to provide
  workspace outputs you can expose in your nix flake
  
- Because we know all of the dependencies, it's easy to create a shell from those
  dependencies as environment setup using the `workspaceShell` function and then
  exposing it in your `devShell` flake output. 
  
[overlay]: ./overlay/
  
### Building crates isolated from each other

Just like regular `cargo` builds, there is a DAG of dependencies, but purity
means we only expose essential information to dependencies and manually invoke
`cargo`.  Communication from dependencies to dependents is handled by writing
some extra outputs and then reading them inside the next build.

There's two broad categories of information that need to be transmitted when
hand-building crates in isolation:

- **Global information**

  - target such as `x86_64-unknown-linux-gnu`
  - actions such as `build` or `test`
  - features which turn on optional dependencies & downstream features via logic
    in the [`Cargo.nix`] expressions

- **Propagated information**

  Linking information for dependents to consume dependency crates is written
  after each build and then consumed before each build by dependents farther up
  the DAG
  
  The linking, features, target, and other information is given to each
  derivation's build shell, defined in `mkcrate.nix`
  
You send some information in.  Derivations are evaluated in Nix.  During the
build, rlibs and dependency information are propagated back up the DAG.  Simple.

[`mkcrate.nix`]: ./overlay/mkcrate.nix
[`Cargo.nix`]: ./Cargo.nix

### Limitations implied by purity

Evaluation of nix derivations doesn't require building anything.  If you want to
build a specific crate in a workspace with Nix, we would have to know this when
building all of the dependencies.  This means certain behavior to switch
features and optional dependencies on and off depends on what _else_ is being
built.  We could tell the workspace up front which crates will be built, but
`cargo2nix` currently just builds dependencies as if every workspace crate might
be built.  This actually improves caching but may rarely result in a long build
for an unneeded dependency (which your workspace should put behind a top-level
feature).  Cargo isn't any better at this aspect of caching vs rebuilding.

## Common issues

1. Flakes require `flake.nix` and `Cargo.nix` to be in version control.  `git
   add flake.nix Cargo.nix` etc.  Remember to keep them up to date!
   
1. Old versions of the `cargo2nix.overlay` usually cannot consume newer versions
   of the `Cargo.nix` that an updated cargo2nix will produce.  Update your
   inputs with `nix flake lock --update-input cargo2nix` or `nix build
   --update-input cargo2nix`

1. When building `sys` crates, `build.rs` scripts may themselves attempt to
   provide native dependencies that could be missing. See the
   `overlay/overrides.nix` for patterns of common solutions for fixing up
   specific deps.
   
   To provide your own override, pass a modified `packageOverrides` to
   `pkgs.rustBuilder.makePackageSet'`:
   
   ```nix
     rustPkgs = pkgs.rustBuilder.makePackageSet' {
       # ... required arguments not shown
     
       # Use the existing all list of overrides and append your override
       packageOverrides = pkgs: pkgs.rustBuilder.overrides.all ++ [
       
         # parentheses disambiguate each makeOverride call as a single list element
         (pkgs.rustBuilder.rustLib.makeOverride {
             name = "fantasy-zlib-sys";
             overrideAttrs = drv: {
               propagatedNativeBuildInputs = drv.propagatedNativeBuildInputs or [ ] ++ [
                 pkgs.zlib.dev
               ];
             };
         })
         
       ];
     };
   ```


1. Non-deterministic rustc or linker behavior can lead to binary-incompatible
   crates.  Nix cannot protect from non-determinism, only impurity.  Override
   your builds with `preferLocalBuild = true;` `allowSubstitutes = false;` for
   the affected package.  This has been seen more often because of
   nondeterministic macros.  See #184 for more information.
   
1. Nixpkgs is a rolling release, and that means breakages occur but you have
   many potential successful versions to choose from.  View the [CI logs] and
   check the `flake.lock` for rev information from recent successes.  Update to
   a specific input version with:
   
   ```shell
    nix flake lock --override-input nixpkgs github:nixpgks/nixpkgs?rev=a284564b7f75ac4db73607db02076e8da9d42c9d
   ```
   
   [CI logs]: https://github.com/cargo2nix/cargo2nix/actions/?workflow=CI
   
1. Toml parsing / conversion issues `Error: Cannot convert data to TOML (Invalid
   type <class 'NoneType'>)`
   
   `jq` and `remarshal` are used to read & modify toml files in some
   cases. Lines of the form: ```[key."cfg(foo = \"a\", bar = \"b\"))".path]```
   could produce breakage when `jq` output was fed back to `remarshal`. There
   are workarounds in place to catch many cases. See #149 for more information
   and report any newly found breakage until a total solution is in place.

1. Git dependencies and crates from alternative Cargo registries rely on
   `builtins.fetchGit` to support fetching from private Git repositories. This
   means that such dependencies cannot be evaluated with `restrict-eval`
   applied.

   Also, if your Git dependency is tied to a Git branch, e.g. `master`, and you
   would like to force it to update on upstream changes, you should append
   `--option tarball-ttl 0` to your `nix-build` command.
   
## Declarative build debugging shell

You can load a `nix shell` for any crate derivation in the dependency tree. This
is the same environment the `cargo2nix` overlay will build them in.

To do this, first find the .drv for your dependency by using, for example, `nix
show-derivation | grep colorify`

```bash
nix show-derivation | rg -o "/nix.*crate.*colorify.*drv"
nix/store/whi3jprrpzlnvic9fsn5f69sddazp5sb-colorify-0.2.3.tar.gz

# ignore environment to remove your shell's impurities
nix develop --ignore-environment nix/store/whi3jprrpzlnvic9fsn5f69sddazp5sb-colorify-0.2.3.tar.gz

# the environment is now as it is when nix builds the package
echo $src 
nix/store/whi3jprrpzlnvic9fsn5f69sddazp5sb-colorify-0.2.3.tar.gz

# If you are working on a dependency and need the source (or a fresh copy) you
# can unpack the $src variable. Through nix stdenv, tar is available in pure 
# shells
mkdir debug
cp $src debug
cd debug
tar -xzfv whi3jprrpzlnvic9fsn5f69sddazp5sb-colorify-0.2.3.tar.gz
cd <unpacked source>
```

You will need to override your `Cargo.toml` and `Cargo.lock` in this shell, so
make sure that you have them backed up if your are directly using your clone of
your project instead of unpacking fresh sources like above.

Now you just need to run the `$configurePhase` and `$buildPhase` steps in order.
You can find additional phases that may exist in overrides by running `env |
grep Phase`

```bash
echo $configurePhase 
# runHook preConfigure runHook configureCargo runHook postConfigure

runHook preConfigure # usually does nothing
runHook configureCargo
runHook postConfigure # usually does nothing

echo $buildPhase
# runHook overrideCargoManifest runHook setBuildEnv runHook runCargo

runHook overrideCargoManifest  # This overrides your .cargo folder, e.g. for setting cross-compilers
runHook setBuildEnv  # This sets up linker flags for the `rustc` invocations
runHook runCargo
```

If `runCargo` succeeds, you will have a completed output ready for the (usually)
less interesting `$installPhase`. If there's a problem, inspecting the `env` or
reading the generated `Cargo.lock` etc should yield clues.  If you've unpacked a
fresh source and are using the `--ignore-environment` switch, everything is
identical to how the overlay builds the crate, cutting out guess work.

## Credits

The design for the Nix overlay is inspired by the excellent work done by James
Kay, which is described [here][blog-1] and [here][blog-2]. His source is
available [here][mkRustCrate]. This work would have been impossible without
these fantastic write-ups. Special thanks to James Kay!

[blog-1]: https://www.hadean.com/blog/managing-rust-dependencies-with-nix-part-i
[blog-2]: https://www.hadean.com/blog/managing-rust-dependencies-with-nix-part-ii
[mkRustCrate]: https://github.com/Twey/mkRustCrate

## License

`cargo2nix` is free and open source software distributed under the terms of the
[MIT License](./LICENSE).
