# Independent Packaging

This is how to use cargo2nix to package Rust software indpenendently of its
hosting repository.  This example uses flakes.

## Introduction

It's not always desireable or best to nixify projects by embedding nix files
into their repositories. This is in fact avoided in nixpkgs. Instead, you can
ship a pre-made Cargo.nix and a default.nix that locates and provides the
external source to produce a build.  Rust Analyzer is packaged here as a
demonstration.

First clone the target repository at the commit you wish to generate a build
for:

```shell
git clone --depth 1 --branch 2021-11-08 git@github.com:rust-analyzer/rust-analyzer.git 
```

Inside the clone, generate / update the lock file and then create a `Cargo.nix`

```shell
cargo generate-lockfile
cargo2nix
```

Copy just the generated `Cargo.nix` to the repository you wish to host the new
package. Now we need to make a `flake.nix` to consume the `Cargo.nix` (also
called `packageFun`).

In flakes, we cannot just use a `fetchGit` etc to insert dependencies ad hoc.
The proper way to get our source is to create a flake input and pass it into the
outputs function.  (remember to add this to the argument list)

```nix
# in the inputs
rust-analyzer-src = {
  url = "github:rust-analyzer/rust-analyzer?rev=2c0f433fd2e838ae181f87019b6f1fefe33c6f54";
  flake = false;
};

```

We will also pass a `workspaceSrc` argument to `makePackageSet`.

```nix

  rustPkgs = pkgs.rustBuilder.makePackageSet {
    rustVersion = "1.61.0";
    packageFun = import ./Cargo.nix;

    workspaceSrc = rust-analyzer-src
    # You can also use local paths for local development with a checked out copy
    # workspaceSrc = ../../../upstream/rust-analyzer;
  };

```

The latest version of Rust Analyzer requires a library that we can provide via
an inline override

```nix

    # Provide the gperfools lib for linking the final rust-analyzer binary
    packageOverrides = pkgs: pkgs.rustBuilder.overrides.all ++ [
      (pkgs.rustBuilder.rustLib.makeOverride {
        name = "rust-analyzer";
        overrideAttrs = drv: {
          propagatedNativeBuildInputs = drv.propagatedNativeBuildInputs or [ ] ++ [
            pkgs.gperftools
          ];
        };
      })
    ];
    
```

Nix will by default build packages that contain some extra outputs (which
cargo2nix utilizes to coordinate between dependencies) that might be necessary
when being used as a `buildDependency` but will collide when attempting to
install finished software into a profile. We can expose just the `bin` output by
selecting it explicitly in the final expression of our `default.nix`:

```nix
  #... previously expressed rustPkgs
  
  in rec {
    packages = {
      rust-analyzer = (rustPkgs.workspace.rust-analyzer {}).bin;
      default = packages.rust-analyzer;
    };
  }
```

You can test that this package builds like so:

```
# with flakes
nix build
```

You will now see a clean binary output at `result-bin/bin/rust-analyzer`

### Errata

The version of Rust Analyzer built here will generate a Cargo.nix that enables
both allocators.  Search the [Cargo.nix](./Cargo.nix) for `mimalloc` to see
where this erroneously enabled feature was commented out by hand.
