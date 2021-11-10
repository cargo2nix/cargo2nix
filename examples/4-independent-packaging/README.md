# Independent Packaging

This is how to use cargo2nix to package Rust software indpenendently of its
hosting repository.  This example uses flakes and flake-compat.

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
cargo2nix -f
```

Copy just the generated `Cargo.nix` to the repository you wish to host the new
package. Now we need to make a `default.nix` to consume the `Cargo.nix` (also
called `packageFun`). The main difference is that we will also pass a
`workspaceSrc` argument to `makePackageSet'`.

```nix

  rustPkgs = pkgs.rustBuilder.makePackageSet' {
    rustChannel = "1.56.1";
    packageFun = import ./Cargo.nix;

    workspaceSrc = pkgs.fetchFromGitHub {
      owner = "rust-analyzer";
      repo = "rust-analyzer";
      rev = "2c0f433fd2e838ae181f87019b6f1fefe33c6f54";
      sha256 = "sha256-nqRK5276uTKOfwd1HAp4iOucjka651MkOL58qel8Hug=";
    };
    # You can also use local paths for local development with a checked out copy
    # workspaceSrc = ../../../upstream/rust-analyzer;
  };

```

In Rust Analyzer's case, we also need to pass a custom optional `localPatterns`
argument because several of its crates are not in locations picked up by the
default.

```nix
  rustPkgs = pkgs.rustBuilder.makePackageSet' {  
    localPatterns = [ ''^(src|tests|crates|xtask|assets|templates)(/.*)?'' ''[^/]*\.(rs|toml)$'' ];
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
    };

    defaultPackage = packages.rust-analyzer;
  }
```

You can test that this package builds like so:

```
# with flakes
nix build

# legacy style nix
nix-build -A default
```

You will now see a clean binary output at `result-bin/bin/rust-analyzer`
