# Project with cross compiling

Nix's stdenv tooling can be used to create binaries that target many platforms,
linked in many ways.  You can use this to create static binaries or to target
entirely different architectures.

Cargo2nix has to properly handle build-host offsets in `build.rs` scripts and
when linking binaries. For the sake of demonstration, this project will use the
[`ructe`] template engine to generate a statically-embedded template file.

[`ructe`]: https://github.com/kaj/ructe

## Configuring Nixpkgs for Cross

When configuring `nixpkgs`, two arguments are very critical:

- `system` configures what kind of builder will be used.  For example, if your
  machine is a darwin (mac) machine and you specify `x86_64-linux` as the
  system, your nix program will look for a linux builder such as [`nix-docker`]
  and delegate the build out to it.
  
- `crossSystem` configures the host.  If the host platform does not match the
  build system `system`, then you are cross compiling and the package offsets,
  All the programs that run during the build will be native to `system` still,
  but they will produce output for the `crossSystem` host.
  
When you only set `system`, you get a native build for that platform, producing
output for the same platform.  If you set `crossSystem`, you can configure
linking and target options the differ from the build platform.  This is how a
Linux machine can build for aarch64 etc.

In general, throughout cargo2nix, you can assume that `system` is the
`buildPlatform` and `crossSystem` is the `hostPlatform`
configuration.
  
[`nix-docker`]: https://github.com/LnL7/nix-docker

### CrossSystem Values

A variety of configuration options can be viewed in `lib.systems.examples`:

```shell
nix repl '<nixpkgs>'
nix-repl> lib.systems.examples.wasi32 
{ config = "wasm32-unknown-wasi"; useLLVM = true; }
```

Most crossSystem values are simple like this.  Others make more specific
changes.  Many only set the `config` attribute to a host triple + abi like
`x86_64-unknown-linux-musl`.

### Macros - Build or Host?

Consider the following:

- [`include_str!()`]
- [`include_bytes!()`]

[`include_str!()`]: https://doc.rust-lang.org/std/macro.include_str.html
[`include_bytes!()`]: https://doc.rust-lang.org/std/macro.include_bytes.html

They are supposed to expand into something that is used in the final binary, but
the expansion will happen while still on the build platform.  Rust doesn't
really care what the target is when evaluating `build.rs` scripts.

### Rust & Nix Targets

The Nix and Rust concept of systems don't line up perfectly.  In some cases
cargo2nix does translation of the Nix target to a Rust target.  See
[`rust-triple.nix`].  If you need to use one target for nixpkgs and a specific
target for Rust when targeting the `hostPlatform`, then 

[`rust-triple.nix`]: ../../overlay/lib/rust-triple.nix

## Generating the project

As in the previous project, set up a bin crate.

Make a template directory called `templates` and write a template called `test.rs.html`:

```text
@(test: &str)

Hello @test
```

Add the following line to the `[build-dependencies]` table of the `Cargo.toml`:

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

## Generating a Cargo.nix

Like the previous example, we generate a `Cargo.lock` and `Cargo.nix` for our
crate by running the two commands below:

```bash
cargo generate-lockfile
cargo2nix
```

## Writing the Flake.nix

Here's where things get a lot more interesting than the previous examples.

## Providing Flakes With pkgsCross

While we are still using flake utils to streamline how the flake defines outputs
for typical systems, the use of `crossSystem` sets the output.

Create a new file called [`flake.nix`]:

[`flake.nix`]: ./flake.nix

```nix
{
  inputs = {
    cargo2nix.url = "path:../../";
    # Use a github flake URL for real packages
    # cargo2nix.url = "github:cargo2nix/cargo2nix/release-0.11.0";
    flake-utils.follows = "cargo2nix/flake-utils";
    nixpkgs.follows = "cargo2nix/nixpkgs";
  };

  outputs = inputs: with inputs;

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

          # crossSystem = {
          #   config = "aarch64-unknown-linux-gnu";
          # };


          # crossSystem = {
          #   config = "x86_64-unknown-linux-musl";
          # };

          crossSystem = {
            config = "wasm32-unknown-wasi";
            # Nixpkgs currently only supports LLVM lld linker for wasm32-wasi.
            useLLVM = true;
          };

          overlays = [ cargo2nix.overlays.default ];
        };

        # create the workspace & dependencies package set
        rustPkgs = pkgs.rustBuilder.makePackageSet {
          rustVersion = "1.64.0";
          packageFun = import ./Cargo.nix;

          # If your specific build target requires a difference between Rust and
          # nixpkgs, set this target
          # target = "aarch64-unknown-linux-gnu";
          # target = "x86_64-unknown-linux-musl";
          # target = "wasm32-wasi";
        };

      in rec {
        # this is the output (recursive) set (expressed for each system)

        # the packages in `nix build .#packages.<system>.<name>`
        packages = {
          # nix build .#cross-compiling
          # nix build .#packages.x86_64-linux.cross-compiling
          cross-compiling = (rustPkgs.workspace.cross-compiling {});
          # nix build
          default = packages.cross-compiling;
        };
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
# generate the flake.lock
flake check
# add generated to version control
git add flake.lock
git add Cargo.nix
```

## Building

Build the binary output

```bash
nix build
```

This will create a `result` symlink in the current directory with the following
structure:

```text
ls -al result-bin
result-bin -> /nix/store/xfhfa9pshhix98qlxmjmhf9200k4r7id-crate-cross-compiling-0.1.0-bin

tree result-bin
result-bin
└── bin
    └── cross-compiling.wasm
```

### Inspecting and Running Outputs

Running the `cross-compiling` binary for your `buildPlatform` will fail.

```text
./result-bin/bin/cross-compiling.wasm 
# bash: ./result-bin/bin/cross-compiling.wasm: cannot execute binary file: Exec format error
```

You need a runtime or emulator.  For the `wasm32-wasi` example, you can use
`wasmtime` available from nixpkgs:

```bash
nix shell nixpkgs#wasmtime
wasmtime result-bin/bin/cross-compiling.wasm 
# Hello world
```

For the `aarch64-unknown-linux-gnu` example, you will need qemu:

```bash
nix shell nixpkgs#qemu
qemu-aarch64 result-bin/bin/static-resources
# Hello world
```

Musl binaries will just run on the native platform, so
`lib.systems.examples.musl64` runs on Linux and so on.

To inspect the file format and linking, use `file` and `ldd`:

```bash
file result-bin/bin/cross-compiling.wasm 
# result-bin/bin/cross-compiling.wasm: WebAssembly (wasm) binary module version 0x1 (MVP)

ldd result-bin/bin/cross-compiling.wasm 
#         not a dynamic executable
```

### Using a Remote Builder

Many cross compiling toolchains only work on Darwin or Linux.  Linux is usually
the stronger platform in this regard, except when targeting other Mac platforms.
To enable Macs to build binaries for a Linux runtime (such as when making Docker
containers) etc, you can run a local "remote" builder on Docker itself.

LnL7 wrote an excellent set of tools for this in [Nix Darwin] and [Nix Docker].  If
you have these tools installed, you can select the builder by just switching up
the nix command just a bit:

```bash
nix build .#packages.x86_64-linux.cross-compiling
```

[Nix Docker]: https://github.com/LnL7/nix-docker
[Nix Darwing]: https://github.com/LnL7/nix-darwin
[Docker Desktop]: https://www.docker.com/products/docker-desktop
