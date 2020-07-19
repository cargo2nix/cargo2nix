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
├── default.nix
├── Cargo.lock
├── Cargo.nix
├── Cargo.toml
├── README.md
└── result -> /nix/store/qjz1m7pmm23r7fhgbigb2x5pnwqp925j-crate-foo-project-0.1.0
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

This example project will demonstrate how to use the `localPatterns` argument to
customize which files should be included in the `cargo2nix` build. For the sake
of demonstration, this project will use the [`ructe`] template engine to
generate text according to a statically-embedded template file.

[`ructe`]: https://github.com/kaj/ructe

Let's begin by creating a new Cargo crate called `project-with-resources`.

## Generating the project

As with the previous examples, we will generate a new binary project with Cargo
using `cargo new <name>`. This requires us to have some version of the Rust
toolchain installed on our system. If Cargo isn't present on your machine, you
can use `nix-shell` to drop into a temporary shell with Cargo present, like so:

```bash
nix-shell -p cargo
```

Now that we're inside this shell, let's create the `project-with-resources`
Cargo project:

```bash
cargo new project-with-resources
```

Since [Cargo 0.26.0](https://github.com/rust-lang/cargo/pull/5029), the default
project type should be `--bin` if unspecified. You should see the following
output in your terminal:

```text
     Created binary (application) `project-with-resources` package
```

This should create a new directory called `project-with-resources` containing a
mostly empty `Cargo.toml` and `src/main.rs` file. Change into that directory
with `cd` and create a new subdirectory called `templates`, like so:

```bash
mkdir templates
```

This directory will hold our `ructe` template files. Let's create a template
file in this location named `test.rs.html`:

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
the `src/main.rs` file eand write some code that will do just that:

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

## Wrapping with cargo2nix

The process for wrapping up our crate with `cargo2nix` should be very similar to
the previous examples, with one notable difference.

### Generating a Cargo.nix

First, we generate a `Cargo.lock` and `Cargo.nix` for our crate by running the
two commands below:

```bash
cargo generate-lockfile
cargo2nix -f
```

### Creating a default.nix

Let's create a new file called [`default.nix`] and declare a function with the
following arguments:

[`default.nix`]: ./default.nix

```nix
{
  system ? builtins.currentSystem,
  nixpkgsMozilla ? builtins.fetchGit {
    url = https://github.com/mozilla/nixpkgs-mozilla;
    rev = "50bae918794d3c283aeb335b209efd71e75e3954";
  },
  cargo2nix ? builtins.fetchGit {
    url = https://github.com/tenx-tech/cargo2nix;
    ref = "v0.9.0";
  },
}:
```

This should be identical to what we did in the previous two examples. The
function body is slightly different, however:

```nix
let
  rustOverlay = import "${nixpkgsMozilla}/rust-overlay.nix";
  cargo2nixOverlay = import "${cargo2nix}/overlay";

  pkgs = import <nixpkgs> {
    inherit system;
    overlays = [ cargo2nixOverlay rustOverlay ];
  };

  rustPkgs = pkgs.rustBuilder.makePackageSet' {
    rustChannel = "stable";
    packageFun = import ./Cargo.nix;
    localPatterns = [
      ''^(src|tests|templates)(/.*)?''
      ''[^/]*\.(rs|toml)$''
    ];
  };
in
  rustPkgs.workspace.project-with-resources {}
```

Again, we import Nixpkgs using our `nixpkgsMozilla` and `cargo2nix` overlays
and build the `Cargo.nix` for the project with the `rustBuilder.makePackageSet'`
function. The biggest difference is the addition of a new `localPatterns`
argument. This allows you to override the default file and directory filtering
and specify your own.

As mentioned in the introduction, if `localPatterns` is not specified by the
user, it defaults to:

```nix
[
  ''^(src|tests)(/.*)?''
  ''[^/]*\.(rs|toml)$''
]
```

The first regex pattern allows all files inside the `(src|tests)` directories,
and the second regex allows all `*.(rs|toml)` files present in the crate root
directory. In our project's case, we copied this pattern into our `default.nix`
verbatim and expanded it to allow the `templates` directory as well.

Save the `default.nix` file and quit. Let's verify this works as expected by
building it!

## Building

As always, to compile the `project-with-resources` binary with Nix, run:

```bash
nix-build
```

This will create a `result` symlink in the current directory with the following
structure:

```text
/nix/store/h8ys3ip98psal68kj747r7vccjkihfnl-crate-project-with-resources-0.1.0
├── bin
│   └── project-with-resources
└── lib
```

Running the `project-with-resources` binary will print the templated string to
the screen:

```text
$ ./result/bin/project-with-resources
Hello world

```
