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

### As a build system

First, generate your version pins and boilerplates by invoking `cargo2nix gen`
in your `cargo` workspace.
A `cargo2nix gen` invocation generates a version pin under a default name
`deps.nix` and a boilerplate expression `crate.nix`.
Use `default.nix` in this repository as an example, select the package you want
to build and set up required build-time/run-time dependencies.

As an example, `cargo2nix` can be built from `package.unknown.cargo2nix."0.1.0"`
in the generated package set `rustPackages`.

### Optional declarative development shell

You can optionally use any of these crate derivation as your `nix-shell`
development shell.
The advantage of this shell is that in this environment users can develop their
crates and be sure that their crates builds in the same way that `cargo2nix`
overlay will build them.

To do this, run `nix-shell -A 'package.<package-id-attrset-path>'`.
For instance, the following command being invoked in this repository root drops
you into such a development shell.
```bash
nix-shell -A 'package.unknown.cargo2nix."0.1.0"'
```
You will need to bootstrap some environment in this declarative development shell
first.
```bash
runHook configureCargo  # this overrides your .cargo folder for setting cross-compilers, for example
runHook setBuildEnv     # this sets up linker flags for the `rustc` invocations
```
You will need to override your `Cargo.toml` and `Cargo.lock` in this shell,
so make sure that you have them backed up beforehand.
```bash
runHook overrideCargoManifest
```
Now you can use your favorite editor in this environment.
To run build command used by `cargo2nix`, use
```bash
runHook runCargo
```

### Airplane mode

Going flying next morning and planning to code Rust to kill your boredom for the
next 12 hours?
Airplane mode allows you to work offline as long as you have checked in the
`crates-io` dependencies into Nix store.
The `shell` derivation in `default.nix` is a sample derivation that enables
airplane mode for your `cargo`.

To enter airplane mode, run the following command.
```bash
nix-shell -A shell --fallback --option substitute false
```
Then execute `vendor_source` command in the shell to install source replacement
for the `crates-io` public crates.

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
