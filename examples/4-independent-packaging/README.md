# Independent Packaging

This is how to use cargo2nix to package Rust software indpenendently of its
hosting repository.

## Introduction

It's not always desireable or best to nixify projects by embedding nix files
into their repositories. This is in fact avoided in nixpkgs. Instead, you can
ship a pre-made Cargo.nix and a default.nix that locates and provides the
external source to produce a build.  Rust Analyzer is packaged here as a
demonstration.

First clone the target repository at the commit you wish to generate a build
for:

```shell
git clone --depth 1 --branch 2020-11-30 git@github.com:rust-analyzer/rust-analyzer.git 
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
    inherit rustChannel;
    packageFun = import ./Cargo.nix;
    
    workspaceSrc = pkgs.fetchFromGitHub {
      owner = "rust-analyzer";
      repo = "rust-analyzer";
      rev = "ac30710ada112984c9cf79c4af39ad666d000171";
      sha256 = "1ycnl9y7vhv7yd8w21904cyfik2y7jjzpb17xkdpiazw5riyyzh3";
    };
    
    # You can also use local paths for local development with a checked out copy
    # workspaceSrc = ~/vendor/rust-analyzer;
  };

```

In Rust Analyzer's case, we also need to pass a custom optional `localPatterns`
argument because several of its crates are not in locations picked up by the
default.

```nix
  rustPkgs = pkgs.rustBuilder.makePackageSet' {
    # ... the other arguments
  
    localPatterns = [ ''^(src|tests|crates|xtask|assets|templates)(/.*)?'' ''[^/]*\.(rs|toml)$'' ];
  };
```

Nix will by default build packages that contain some extra outputs (which
cargo2nix utilizes to coordinate between dependencies) that might be necessary
when being used as a `buildDependency` but will collide when attempting to
install finished software into a profile. We can expose just the `bin` output by
selecting it explicitly in the final expression of our `default.nix`:

```nix
#... previously expressed rustPkgs
in {
  rust-analyzer = (rustPkgs.workspace.rust-analyzer {}).bin;
}
```

You can test that this package builds like so:

```
nix-build -A rust-analyzer
```

You will now see a clean binary output at `result-bin/bin/rust-analyzer`
