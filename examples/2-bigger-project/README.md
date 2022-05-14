# A bigger project

This is a larger `bin` project which requires some dependencies from Crates.io.

## Introduction

This example assumes that you have already read through the [Hello World]
project and have your machine set up with Nix and `cargo2nix`. If this is not
the case, it is strongly recommended that you follow that guide first.

[Hello World]: ../1-hello-world/README.md

Let's begin by creating another Cargo crate called `bigger-project` which
depends on some crates from Crates.io, which in turn require some non-Rust
system dependencies.

## Generating the Cargo project

As described in the previous example, fire up a Rust bin crate project with
`cargo new bigger-project`

Edit your `src/main.rs` with the following Rust code:

```rust
//! A simple HTTP client using `reqwest`.

#[tokio::main]
async fn main() -> Result<(), reqwest::Error> {
    let res = reqwest::get("https://hyper.rs").await?;

    println!("Status: {}", res.status());

    let body = res.text().await?;

    println!("Body:\n\n{}", body);

    Ok(())
}
```

Then, add the following lines to the `[dependencies]` table of the `Cargo.toml`:

```toml
reqwest = "0.10"
tokio = { version = "0.2", features = ["macros"] }
```

## Generating a Cargo.nix

Like the previous example, we generate a `Cargo.lock` and `Cargo.nix` for our
crate by running the two commands below:

```bash
cargo generate-lockfile
cargo2nix
```

## Writing the Flake.nix

Let's create a new file called [`flake.nix`] and declare a function with the
following arguments:

[`flake.nix`]: ./flake.nix

```nix
{
  inputs = {
    cargo2nix.url = "path:../../";
    # Use the github URL for real packages
    # cargo2nix.url = "github:cargo2nix/cargo2nix/master";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs?ref=release-21.11";
  };

  outputs = { self, nixpkgs, cargo2nix, flake-utils, ... }:

    # Build the output set for each default system and map system sets into
    # attributes, resulting in paths such as:
    # nix build .#packages.x86_64-linux.<name>
    flake-utils.lib.eachDefaultSystem (system:

      # let-in expressions, very similar to Rust's let bindings.  These names
      # are used to express the output but not themselves paths in the output.
      let

        # create nixpkgs that contains rustBuilder from cargo2nix overlay
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ cargo2nix.overlay ];
        };

        # create the workspace & dependencies package set
        rustPkgs = pkgs.rustBuilder.makePackageSet {
          rustVersion = "1.60.0";
          packageFun = import ./Cargo.nix;
          # packageOverrides = pkgs: pkgs.rustBuilder.overrides.all; # Implied, if not specified
        };

      in rec {
        # this is the output (recursive) set (expressed for each system)

        # the packages in `nix build .#packages.<system>.<name>`
        packages = {
          # nix build .#bigger-project
          # nix build .#packages.x86_64-linux.bigger-project
          bigger-project = (rustPkgs.workspace.bigger-project {}).bin;
        };

        # nix build
        defaultPackage = packages.bigger-project;
      }
    );
}
```

:warning: Remember to add the flake to version control (and `Cargo.nix` and
`flake.lock` while you're at it)

```bash
git init
git add flake.nix
flake check
# generate the flake.lock
git add flake.lock
git add Cargo.nix
```

### About Overrides

Our `bigger-project` crate depends on both [`reqwest`] and [`tokio`], providing
a simple asynchronous HTTP client. By default, `reqwest` relies on the
[`native-tls`] crate for SSL support, which requires certain system dependencies
depending on the host platform.  Specifically:

* On Linux and NixOS, we depend on OpenSSL (via the [`openssl`] crate).
* On macOS, we depend on Secure Transport (via the [`security-framework`]
  crate).

[`reqwest`]: https://github.com/seanmonstar/reqwest
[`tokio`]: https://github.com/tokio-rs/tokio
[`native-tls`]: https://github.com/sfackler/rust-native-tls
[`openssl`]: https://github.com/sfackler/rust-openssl
[`security-framework`]: https://github.com/kornelski/rust-security-framework

The required system dependencies will be magically injected into the build by
`cargo2nix` using the `packageOverrides` argument for `makePackageSet` without
needing any extra work, but we will get into what that means later on.

You might have noticed that we did not specify any external dependencies to be
used in our build, such as `openssl` or `darwin.apple_sdk.frameworks.Security`.
This is because the `cargo2nix` overlay provides a collection of _crate
overrides_ for many popular Crates.io dependencies by default, tucked away in
`rustBuilder.overrides.all`. If you're curious, you can view our existing
library of provided crate overrides in [overlay/overrides.nix].

[overlay/overrides.nix]: ../../overlay/overrides.nix

`rustBuilder.overrides.all` is a list, so you can always add your own custom
overrides by appending `++ [ myOverride1 myOverride2 ]` to the end. We won't
delve into how custom overrides work in this example, but you should at least be
aware that the option exists.

> Side note: if you'd like to submit more crate overrides for default inclusion
> in the next version of `cargo2nix`, [feel free to open a pull request]!

[feel free to open a pull request]: ./../../CONTRIBUTING.md

Save the `flake.nix` file and quit. Your `cargo2nix` project is ready for
building!

## Building

To compile the `bigger-project` binary with Nix, simply run:

```bash
nix build
```

This will create a `result` symlink in the current directory with the following
structure:

```text
ls -al result-bin
result-bin -> /nix/store/kkx76zvrm02hsh09kw694r5ma5f4wrjf-crate-bigger-project-0.1.0-bin

tree result-bin
result-bin
└── bin
    └── bigger-project

```

Running the `bigger-project` binary will print the following output to the
screen:

```text
$ ./result/bin/hello-world
Status: 200 OK
Body:

<!doctype html>
<html>
  <head>
# lots more HTML here...
```

Now that we're getting the hang of building crates with `cargo2nix`, let's
create a project which relies on external resources located outside of the `src`
directory.
