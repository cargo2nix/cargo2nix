# Example projects

This directory contains some example Cargo workspaces which demonstrate how to
build and test your projects with `cargo2nix`. These also serve as a suite of
integration tests to catch regressions in `cargo2nix` itself.

## Building

The workflow for each project should be essentially the same. Let's take the
`1-hello-world` project, for example.

To compile the `hello-world` binary with Nix, run:

```bash
nix-build -A package
```

Note that the `nix-build -A package` above is a convenient equivalent to:

```bash
nix-build -A rustPkgs.workspace.hello-world
```

Even more verbosely, the build command above is an equivalent to:

```bash
nix-build -A rustPkgs."unknown"."0.1.0".hello-world
#                     ^^^^^^^^^ ^^^^^^^ ^^^^^^^^^^^
#                         |        |         |
# Source -----------------+        |         |
#  - Crates.io URL                 |         |
#  - Git repository URL            |         |
#  - Alterative registry URL       |         |
#  - `unknown` for path deps       |         |
#                                  |         |
#             Version -------------+         |
#                             Name-----------+
```

Any crate derivation in the dependency tree can be referred to with the scheme
shown above.

### Cross-compiling

`cargo2nix` provides native support for cross-compilation, and all crates can
be cross-compiled to other platforms, although some system dependencies from
upstream Nixpkgs may be broken on certain host/build platform combinations.

To cross-compile a crate, you can add the `--arg crossSystem` switch to the
`nix-build` invocation from the [Building](#Building) section above, like so:

```bash
# Cross-compile this crate to `x86_64-unknown-linux-musl`
nix-build -A package --arg crossSystem '(import nixpkgs {}).lib.systems.examples.musl64'
```

Alternatively, if you would like a particular project to always default to a
specific platform, you may override the `crossSystem` argument in the
`default.nix` to a value of your choice.

## Running tests

To build and run the test binaries for a project, run:

```bash
nix-build -A ci
```

Alternatively, you may also compile the test binaries and run them yourself,
like so:

## Local development shell

It is often useful to enter a development shell for local development and
iteration when working on a project, and the given `shell.nix` facilitates this.

To enter this shell, simply run:

```text
nix-shell
```

This shell provides the user with the Rust toolchain specified in the
`makePackageSet'` function in the `default.nix` available in the environment,
including `rustc`, `cargo`, `rls`, `cargo-clippy`, and so on.

If the dependency tree for your project includes native build dependencies, e.g.
`openssl` or `postgresql`, these dependencies will be made available to the
environment as well, such that you should be able to confidently `cargo build`,
`cargo test`, and `cargo run` to your heart's content without polluting your
global Nix profile with project-specific build tools.
