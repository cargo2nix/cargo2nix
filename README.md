# cargo2nix

[![all builds & CI](https://github.com/cargo2nix/cargo2nix/actions/workflows/ci.yml/badge.svg)](https://github.com/cargo2nix/cargo2nix/actions/?workflow=CI)
[![build on Linux](https://badgen.net/github/checks/cargo2nix/cargo2nix/release-0.11.0/ubuntu)](https://github.com/cargo2nix/cargo2nix/actions/?workflow=CI)
[![build on Darwin](https://badgen.net/github/checks/cargo2nix/cargo2nix/release-0.11.0/mac)](https://github.com/cargo2nix/cargo2nix/actions/?workflow=CI)
[![flakes supported](https://img.shields.io/badge/flake-supported-green)](https://nixos.wiki/wiki/Flakes)
[![latest release](https://img.shields.io/github/v/tag/cargo2nix/cargo2nix?color=%23009922&label=release)](https://github.com/cargo2nix/cargo2nix/releases)

Bring [Nix](https://nixos.org/nix) dependency management to your Rust project!

- **Development Shell** - knowing all the dependencies means easy creation of
  complete shells.  Run `nix develop` or `direnv allow` in this repo and see!
- **Caching** - CI & CD pipelines move faster when purity guarantees allow
  skipping more work!
- **Reproducibility** - Pure builds.  Access to all of
  [nixpkgs](https://github.com/NixOS/nixpkgs) for repeatable environment setup
  across multiple distributions and platforms

## Run it now!

With [nix](https://nixos.org/nix) (with flake support) installed, generate a
`Cargo.nix` for your project:

```bash
# Use nix to get cargo2nix & rust toolchain on your path
nix develop github:cargo2nix/cargo2nix#bootstrap

# In directory with Cargo.toml & Cargo.lock files (cargo --generate-lockfile)
cargo2nix

# Or skip the shell and run it directly
nix run github:cargo2nix/cargo2nix

# You'll need this in version control
git add Cargo.nix
```

### Use what you generated!

To consume your new `Cargo.nix`, write a nix expression like that found in the
[hello world](./examples/1-hello-world/flake.nix) example.

A bare minimum flake.nix:

```nix
{
  inputs = {
    cargo2nix.url = "github:cargo2nix/cargo2nix/release-0.11.0";
    flake-utils.follows = "carog2nix/flake-utils";
    nixpkgs.follows = "cargo2nix/nixpkgs";
  };

  outputs = { self, nixpkgs, cargo2nix, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [cargo2nix.overlay];
        };

        rustPkgs = pkgs.rustBuilder.makePackageSet {
          rustVersion = "1.61.0";
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

For a more complete project with CI & CD mostly ready to go, check out
[Unixsocks][unixsocks] or cargo2nix's own [CI workflow.](./.github/workflows/ci.yml)

[unixsocks]: https://github.com/positron-solutions/unixsocks

#### Build with nix

```shell
# these must be in version control!
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

In this repo, simply use `nix develop` or `direnv allow`.  Even if you are on
a bare NixOS system or fresh OSX environment with no dependencies or toolchains
installed, you will have everything you need to run `cargo build`.  See the
`devShell` attribute in `flake.nix` to see how to prepare this kind of shell.

The `workspaceShell` function, created by [`makePackagSet`](#Arguments) accepts all the same options as the nix [`mkShell`] function.

[`mkShell`]: https://nixos.org/manual/nixpkgs/stable/#sec-pkgs-mkShell

### Maintaining your project

In your flake, you can choose your cargo2nix version by changing the URL.

| Flake URL                                 |                            Result                            |
|-------------------------------------------|:------------------------------------------------------------:|
| github:cargo2nix/cargo2nix/               | latest release (check repo's default branch, release-0.11.0) |
| github:cargo2nix/cargo2nix/release-0.11.0 |                    use a specific release                    |
| github:cargo2nix/cargo2nix/unstable       |                    latest features & fixes                   |

Only use unstable for developing with the latest features.  PR's against old
releases can be accepted but no active support will be done.  **The default
branch for this repo is updated whenever a new release tag is made.**  Only
specific release branches are "stable."

Update your flake lock with the latest or a specific version of cargo2nix:

```shell
nix flake lock --update-input cargo2nix
nix flake lock --update-input cargo2nix --override-input cargo2nix github:cargo2nix/cargo2nix/?rev=d45481420482fa7d9b0a62836555e24ec07d93be
```

If you need newer versions of Rust or the flake-utils inputs, just specify them
using url instead of follows.

### Arguments to `makePackageSet`

The `makePackageSet` function from [the
overlay](./overlay/make-package-set/user-facing.nix) accepts arguments that
adjust how the workspace is built.  Only the `packageFun` argument is required.
Cargo2nix's own [flake.nix](./flake.nix) has more information.
    
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

#### Contents of Package Set

`rustPkgs` contains all crates in the dependency graph and some extra
conveniences for development.  The workspace crates are also exposed via a
workspace attribute.

`rustPkgs.<registry>.<crate>.<version>` is an example of a crate **function**
path.  Calling the function results in a completed derivation, which can be used
as a flake output.  They support all the normal behaviors such as `override` and
`overrideAttrs`.  See [mkCrate.nix](./overlay/mkcrate.nix) for the full set of
arguments the crate function supports.

`rustPkgs.workspace.<crate>` are usually the packages you will use.  The other
paths look like:

`rustPkgs."registry+https://github.com/rust-lang/crates.io-index".openssl."0.10.30"`

`rustPkgs.workspaceShell` is a derivation using Nix's standard `mkShell`,
embelished with information we learned from the dependencies and their
overrides, enabling vanilla `cargo build` to work in a `nix develop` shell.

#### Overrides

_This is for finished derivations, not for dependencies.  Keep reading below for
using `makeOverride` in the dependency tree._

`workspaceShell` and crates both support [`override`](o) and
[`overrideAttrs`](oa) like normal Nix derivations.  This allows you to customize
the workspace shell or a build step in your workspace crate very easily.  See
`nix show-derivation` and `nix show-derivation #devShell` for more information.

[o]: https://nixos.org/manual/nixpkgs/stable/#sec-pkg-override 
[oa]: https://nixos.org/manual/nixpkgs/stable/#sec-pkg-overrideAttrs

#### More Control

You can make overrides to packages in the dependency tree.  See examples in
[overrides.nix](./overlay/overrides.nix).  Overriding the `buildPhase` etc is
possible for a single crate without modifying `mkcrate.nix` in cargo2nix
directly.  The output of `nix show-derivation` can be valuable when determining
what the current output result is.

**The most important function in cargo2nix source is mkcrate.nix** because it's
how we store information in dependents and replay them back when
building dependents.  It is vital for building crates in isolation.

## How it works

- The `cargo2nix` utility reads the Rust workspace configuration and
  `Cargo.lock` and generates nix expressions that encode some of the feature,
  platform, and target logic into a `Cargo.nix`

- The cargo2nix [Nixpkgs](https://github.com/NixOS/nixpkgs) [overlay](./overlay)
  consumes the `Cargo.nix`, feeding it what you pass to `makePackageSet` to
  provide workspace outputs you can expose in your nix flake
  
- Because we know all of the dependencies, it's easy to create a shell from those
  dependencies as environment setup using the `workspaceShell` function and
  exposing the result in the `devShell` flake output
  
### Building crates isolated from each other

Just like regular `cargo` builds, the Nix dependencies form a [DAG][DAG], but purity
means we only expose essential information to dependencies and manually invoke
`cargo`.  Communication from dependencies to dependents is handled by writing
some extra outputs and then reading those outputs inside the next dependent
build.

There's two broad categories of information that need to be transmitted when
hand-building crates in isolation:

- **Global information**

  - target such as `x86_64-unknown-linux-gnu`
  - cargo actions such as `build` or `test`
  - features which turn on optional dependencies & downstream features via logic
    in the [`Cargo.nix`](./Cargo.nix) expressions

  This information is known before any of the crates are built.  It's used at
  evaluation time to decide what will be built. See `nix show-derivation` results.

- **Propagated information**

  Each dependency writes information such as linker flags alongside its rlib and
  other outputs.  When the dependent is going to consume the dependency, it
  reads this information back.

Derivations are evaluated in Nix with global information available.  During the
build, rlibs and dependency information are propagated back up the DAG.  Each
derivation's build shell combines the linking, features, target, and other
information.  You can see how it's used in
[`mkcrate.nix`](./overlay/mkcrate.nix)

[DAG]: https://en.wikipedia.org/wiki/Directed_acyclic_graph

### Limitations implied by purity

Evaluation of nix derivations doesn't require building anything.  If you want to
build a specific variant of a crate in a workspace with Nix, we would have to
know this when building all of its dependencies.  This means certain behavior to
switch features and optional dependencies on or off depends on what _else_ is
being built.  By default `cargo2nix` will build crates as if all other crates in
the workspace _might_ be build.  This can be somewhat controlled with the
`rootFeatures` argument.  (see `rootFeatures` in [Cargo.nix](./Cargo.nix)).
This actually improves caching but may rarely result in a long build for an
unneeded dependency (which your workspace should put behind a non-default
top-level feature).  Cargo isn't any better at this aspect of caching vs
rebuilding.

## Common issues

1. Flakes require `flake.nix` and `Cargo.nix` to be in version control.  `git
   add flake.nix Cargo.nix` etc.  Remember to keep them up to date!  Before
   building the examples, you will usually need to update their pin of
   cargo2nix: `nix flake lock --update-input cargo2nix` or nix may complane
   about paths.
   
1. Old versions of the `cargo2nix.overlay` usually cannot consume newer versions
   of the `Cargo.nix` that an updated cargo2nix will produce.  Update your
   inputs with `nix flake lock --update-input cargo2nix` or `nix build
   --update-input cargo2nix`

1. When building `sys` crates, `build.rs` scripts may themselves attempt to
   provide native dependencies that could be missing. See the
   `overlay/overrides.nix` for patterns of common solutions for fixing up
   specific deps.
   
   To provide your own override, pass a modified `packageOverrides` to
   `pkgs.rustBuilder.makePackageSet`:
   
   ```nix
     rustPkgs = pkgs.rustBuilder.makePackageSet {
       # ... required arguments not shown
     
       # Use the existing all list of overrides and append your override
       packageOverrides = pkgs: pkgs.rustBuilder.overrides.all ++ [
       
         # parentheses disambiguate each makeOverride call as a single list element
         (pkgs.rustBuilder.rustLib.makeOverride {
             name = "fantasy-zlib-sys";
             overrideAttrs = drv: {
               propagatedBuildInputs = drv.propagatedBuildInputs or [ ] ++ [
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
runHook findCrate
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

## Contributing

See [Contributing](./CONTRIBUTING.md) for potentially more information.

1. Fork this repository into the personal GitHub account
2. Select the appropriate branch, release-<version> for stable changes, unstable
   for breaking changes
3. Make changes on the personal fork
4. Make a Pull Request against this repository
5. **Allow maintainers to make changes to your pull request** (there's a checkbox)
6. Once the pull request has been approved, you will be thanked and observe your
   changes applied with authorship preserved (if we remember)

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
