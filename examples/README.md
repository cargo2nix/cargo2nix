# Example projects

This directory contains some example Cargo workspaces which demonstrate how to
build and test your projects with `cargo2nix`. These also serve as a suite of
integration tests to catch regressions in `cargo2nix` itself.

## [Hello World](./1-hello-world)

No dependencies, just hello world

## [Bigger Project](./2-bigger-project)

Just a program with a few dependencies.  The flake expressions don't change that
much.  The generated nix expressions are more interesting if you want to
understand the contents of a Cargo.nix.

## [Cross Compiling](./3-cross-compiling)

This project can build on Linux for a variety of targets, including ARM and
wasm.  You can use qemu to run the results.

## [Independent Packaging](./4-independent-packaging) (Rust Analyzer)

This shows how to consume someone else's Rust crate and ship a binary without
the need to interact with their repository.

## [Cross Compiling for mingw-w64](./5-cross-compiling)

This project can build on Linux for Nix triple `x86_64-w64-mingw32-gnu` (`pkgsCross.mingwW64`),
or LLVM target `x86_64-pc-windows-gnu`. You can use wine to run the result.
