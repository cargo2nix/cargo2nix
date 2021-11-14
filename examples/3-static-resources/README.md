# Project with external resources

This is a `bin` project which requires compile-time access to certain files
outside the `src` or `tests` directories.

## Introduction

To keep derivations pure and reproducible by default, `cargo2nix` permits access
to only a few specific files and directories at build time. Specifically:

1. The full contents of the `src` and `tests` directories
2. Any `*.rs` and `*.toml` files on the same level as the crate's `Cargo.toml`

So, in a project directory structured like this:

```text
foo-project
├── src
│   ├── lib.rs
│   └── main.rs
├── tests
│   └── my_tests.rs
├── build.rs
├── flake.nix
├── Cargo.lock
├── Cargo.nix
├── Cargo.toml
└── README.md
```

The derivation would only see `src`, `tests`, `build.rs`, and `Cargo.toml`. Note
that the `Cargo.lock` isn't necessary to include here because the `Cargo.nix`
expression is driving the build.

While this is generally sufficient for building most Rust crates, others may
require access to other external files in non-standard locations in order to
build. For example, they might need access to JSON files, Handlebars templates,
Protobuf schemas, etc. This is an especially common occurrence in crates which
rely on [`include_str!()`] or [`include_bytes!()`] to statically embed resources
into executables.

[`include_str!()`]: https://doc.rust-lang.org/std/macro.include_str.html
[`include_bytes!()`]: https://doc.rust-lang.org/std/macro.include_bytes.html

This example uses some templates that must be included in the source. For the
sake of demonstration, this project will use the [`ructe`] template engine to
generate text according to a statically-embedded template file.

[`ructe`]: https://github.com/kaj/ructe

Let's begin by creating a new Cargo crate called `static-resources`.

## Generating the project

As described in the hello-world example, fire up a Rust bin crate project with
`cargo new static-resources`

This should create a new directory called `static-resources` containing a mostly
empty `Cargo.toml` and `src/main.rs` file. Make a subdirectory for called `templates`

```bash
cd static-resources
mkdir templates
```

The `templates` directory will hold our `ructe` template files. Let's create a
template file in this location named `test.rs.html`:

```text
@(test: &str)

Hello @test
```

This template file enables us to generate the text `Hello <something>` at
runtime. To compile this template file at build time, we need to add the
following line to the `[build-dependencies]` table of the `Cargo.toml`:

```toml
ructe = "0.9.2"
```

Next, we create a [Cargo build script] named `build.rs` at the crate root:

[Cargo build script]: https://doc.rust-lang.org/cargo/reference/build-scripts.html

```rust
use ructe::Ructe;

fn main() {
    Ructe::from_env()
        .expect("ructe")
        .compile_templates("templates")
        .unwrap();
}
```

This build script will generate a Rust source file named `$OUT_DIR/templates.rs`
which we can statically embed into our program with `include_str!()`. Let's open
the `src/main.rs` file and write some code that will do just that:

```rust
//! A program which generates some text using an embedded template.

include!(concat!(env!("OUT_DIR"), "/templates.rs"));

fn main() {
    let mut buf = Vec::new();
    templates::test(&mut buf, "world").unwrap();
    println!("{}", String::from_utf8_lossy(&buf));
}
```

Our `templates/test.rs.html` file has been converted into a callable Rust
function named `templates::tests`. In the above code, we use this function to
generate the UTF-8 byte string `Hello world` and print it to the screen.

Unfortunately, this project will not build under `cargo2nix` by default because
the build script will not be able to locate the `templates` directory. Let's fix
that when we wrap our project with `cargo2nix`, shall we?


## Generating a Cargo.nix

Like the previous example, we generate a `Cargo.lock` and `Cargo.nix` for our
crate by running the two commands below:

```bash
cargo generate-lockfile
cargo2nix -f
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
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
    rust-overlay.inputs.flake-utils.follows = "flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs?ref=release-21.05";
  };

  outputs = { self, nixpkgs, cargo2nix, flake-utils, rust-overlay, ... }:

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
          overlays = [(import "${cargo2nix}/overlay")
                      rust-overlay.overlay];
        };

        # create the workspace & dependencies package set
        rustPkgs = pkgs.rustBuilder.makePackageSet' {
          rustChannel = "1.56.1";
          packageFun = import ./Cargo.nix;
        };

      in rec {
        # this is the output (recursive) set (expressed for each system)

        # the packages in `nix build .#packages.<system>.<name>`
        packages = {
          # nix build .#static-resources
          # nix build .#packages.x86_64-linux.static-resources
          static-resources = (rustPkgs.workspace.static-resources {}).bin;
        };

        # nix build
        defaultPackage = packages.static-resources;
      }
    );
}
```

Save the `flake.nix` file and quit. Let's verify this works as expected by
building it!

### :warning: Remember to Add Flake to Version Control

 Remember to add the flake to version control (and `Cargo.nix` and `flake.lock`
while you're at it)

```bash
git init
git add flake.nix
flake check
# generate the flake.lock
git add flake.lock
git add Cargo.nix
```

## Building

As always, to compile the `static-resources` binary with Nix, run:

```bash
nix build
```

This will create a `result` symlink in the current directory with the following
structure:

```text
ls -al result-bin
result-bin -> /nix/store/xfhfa9pshhix98qlxmjmhf9200k4r7id-crate-static-resources-0.1.0-bin

tree result-bin
result-bin
└── bin
    └── static-resources
```

Running the `static-resources` binary will print the templated string to the
screen:

```text
$ ./result/bin/static-resources
Hello world

```
