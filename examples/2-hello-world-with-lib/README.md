# Hello world (with lib target)

This is a simple crate which includes both a `main.rs` and `lib.rs`. It is built
using the latest stable Rust, as provided by
[nixpkgs-mozilla](https://github.com/mozilla/nixpkgs-mozilla).

## How it was created

1. Install the `cargo2nix` tool according to the [official instructions], if you
   haven't already.
2. Create a new `bin` project with `cargo new hello-world-library`. If the Rust
   toolchain is not installed on your system, you could use `nix-shell` like so:
   ```bash
   nix-shell -p cargo --run 'cargo new hello-world-library'
   ```
3. Create a `src/lib.rs` file.
4. Run `cargo generate-lockfile` to create a `Cargo.lock`, if one is not
   already present.
5. Run `cargo2nix -f` at the project root to generate a `Cargo.nix`.
6. Write the `default.nix`, and optionally a `shell.nix`.

[official instructions]: ../../README.md#install

## Building

To compile the `hello-world-with-lib` crate with Nix, run:

```bash
nix-build -A package
```

This will create a `result` symlink in the current directory with the following
structure:

```text
/nix/store/g6szmb7xl1903xdrqxd438i400z0xad6-crate-hello-world-with-lib-0.1.0
├── .cargo-info
├── bin
│   └── hello-world-with-lib
└── lib
    ├── .dep-files
    ├── .dep-keys
    ├── .link-flags
    ├── deps
    └── libhello_world_with_lib.rlib
```

Notice how this example produces a `libhello_world_with_lib.rlib` output in the
`lib` subdirectory, along with some additional helper files. This static library
can be linked against by other Cargo crates down the line.

## Running tests

To build and run the test binaries for this project, run:

```bash
nix-build -A ci
```

This should yield output similar to the following:

```text
these derivations will be built:
  /nix/store/wbj76yhd6131inppskzagvkjr2hafkm8-crate-hello-world-with-lib-0.1.0-test.drv
  /nix/store/dzsxfa50zb0kwi6ly7yiwjd8mwkjz3na-test-hello-world-with-lib.drv
building '/nix/store/wbj76yhd6131inppskzagvkjr2hafkm8-crate-hello-world-with-lib-0.1.0-test.drv'...
unpacking sources
unpacking source archive /nix/store/qfqiii7wn92hdz3j9j3v1dcq0xv94wsn-2-hello-world-with-lib
source root is 2-hello-world-with-lib
patching sources
configuring
building
   Compiling hello-world-with-lib v0.1.0 (/private/tmp/nix-build-crate-hello-world-with-lib-0.1.0-test.drv-0/2-hello-world-with-lib)
    Finished release [optimized] target(s) in 0.69s
installing
/private/tmp/nix-build-crate-hello-world-with-lib-0.1.0-test.drv-0/2-hello-world-with-lib/target/x86_64-apple-darwin/release /private/tmp/nix-build-crate-hello-world-with-lib-0.1.0-test.drv-0/2-hello-world-with-lib
/private/tmp/nix-build-crate-hello-world-with-lib-0.1.0-test.drv-0/2-hello-world-with-lib
post-installation fixup
strip is /nix/store/69in1slwg74lqz3lzz15jbrck2rik21v-cctools-binutils-darwin/bin/strip
stripping (with command strip and flags -S) in /nix/store/1cn438bfkmydz0gzy5ns2brkb25fh418-crate-hello-world-with-lib-0.1.0-test/bin
patching script interpreter paths in /nix/store/1cn438bfkmydz0gzy5ns2brkb25fh418-crate-hello-world-with-lib-0.1.0-test
building '/nix/store/dzsxfa50zb0kwi6ly7yiwjd8mwkjz3na-test-hello-world-with-lib.drv'...
unpacking sources
unpacking source archive /nix/store/qfqiii7wn92hdz3j9j3v1dcq0xv94wsn-2-hello-world-with-lib
source root is 2-hello-world-with-lib
building
Binary file /nix/store/1cn438bfkmydz0gzy5ns2brkb25fh418-crate-hello-world-with-lib-0.1.0-test/bin/hello_world_with_lib-61f5d47a5e81fac5 matches

running 1 test
test tests::it_works ... ok

test result: ok. 1 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out

Binary file /nix/store/1cn438bfkmydz0gzy5ns2brkb25fh418-crate-hello-world-with-lib-0.1.0-test/bin/hello_world_with_lib-6a845d1d177a5090 matches

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out

/nix/store/sdvwpcybgldrziwsywnkwa5lhfndmpd5-test-hello-world-with-lib
```

> Note that the `nix-build` output shown above was from an `x86_64-darwin`
> system. The precise output may differ slightly from platform to platform.

In the example above, there are two test binaries produced: one from the `bin`
target and one from the `lib` target.
