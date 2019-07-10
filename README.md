# cargo2nix

[Nixify](https://nixos.org/nix) your Rust projects today with `cargo2nix`,
bringing you reproducible builds and better caching.

This repository hosts two components:

- a [Nixpkgs](https://github.com/NixOS/nixpkgs) overlay, located at `overlay`
  directory, providing utilities to build your Cargo workspace and set up
  airplane mode.
  
- a utility written in Rust to generate version pins of dependency crates
  and boilerplates


## Build instructions

1. Install [nix](https://nixos.org/nix) on your *NIX machine
1. `nix-build -A package`

## How to use this for your Rust projects

Use `default.nix` in this repository as an example, select the package you
want to build and set up required build-time/run-time dependencies.
For instance, `cargo2nix` can be built from `package.unknown.cargo2nix."0.1.0"`
in the generated package set `rustPackages`.

## Common issues

1. Many `crates.io` public crates may not build using the current Rust compiler,
   unless a lint cap is put on these crates.
   For instance, `cargo2nix` caps all warnings in the `failure` crate to just
   `warn`.
   
## Design

This Nixpkgs overlay builds your Rust crates and binaries by first pulling the
dependencies apart, building them individually as separate Nix derivations and
linking them together.
This is achieved by basically passing linker flags to the `cargo` invocations
and the underlying `rustc`/`rustdoc` invocations.

The overlay is built on top of the work by James Kay.
In addition, this overlay also takes cross-compilation into account and build
the crates onto the correct host platform configurations with the correct
platform-dependent feature flags specified in the Cargo manifests
and build-time dependencies.

## Credits

This Nix overlay is inspired by the excellent work done by James Kay, which
is described
[here](https://www.hadean.com/blog/managing-rust-dependencies-with-nix-part-i)
and
[here](https://www.hadean.com/blog/managing-rust-dependencies-with-nix-part-ii).
His source is available [here](https://github.com/Twey/mkRustCrate).
This work is impossible without these fantastic write-ups.
Special thanks to James Kay!
