## Issues

When opening an issue, you can help us and help yourself.

### How to Debug on Your Own

Check the [common issues] section.  Likely fixes:

- A build override, perhaps modifying a value for `buildPhase` or `unpackPhase`
- An override of dependencies such as in [overrides]
- A modification of the build steps in [mkcrate.nix] or [utils.sh]

You can [replicate the exact build environment] for a failing derivation and try
to build it yourself.  This will allow you to make changes and develop phase
overrides or source patches.

[common issues]: /cargo2nix/cargo2nix#common-issues
[overrides]: /cargo2nix/cargo2nix/blob/master/overlay/overrides.nix
[mkcrate.nix]: /cargo2nix/cargo2nix/blob/master/overlay/mkcrate.nix
[utils.sh]: /cargo2nix/cargo2nix/blob/master/overlay/utils.sh
[replicate the exact build environment]: /cargo2nix/cargo2nix#declarative-debug--development-shell

### Examples Builds We Maintain

Check inside of [examples].  Can you build these examples?  Can you replicate your
issue in a branch on one of our examples?

[examples]: /cargo2nix/cargo2nix/tree/master/examples

### Files We Can Use to Debug

- Cargo.toml
- Cargo.lock
- .cargo/config.toml
- Cargo.nix
- flake.nix
- flake.lock
- build.rs

Please attach whichever files are present / relevant.  The build output from
`nix log` as it instructs you to look at when a drv fails is also helpful.

### Reporting a crate from Crates.io that does not build

`cargo2nix` should be capable of building any unmodified crate available on
[Crates.io]. If you run into a public crate which fails to build with
`cargo2nix`, please report it to us and it will be treated as a bug.

[Crates.io]: https://crates.io/

There are two different scenarios in which a crate might fail to build, and each
will be handled slightly differently when reported to our issue tracker:

#### 1. Failure to build due to a missing system dependency

In this scenario, a crate fails to build due to a non-Rust system dependency
being unavailable during the build process, e.g. the [`openssl-sys`] crate
failing due to OpenSSL not being declared as a build input in Nix, or the
[`ring`] crate failing to build due to an implicit dependency on the [Apple
Security Framework] on macOS.

[`openssl-sys`]: https://crates.io/crates/openssl-sys
[`ring`]: https://crates.io/crates/ring
[Apple Security Framework]: https://developer.apple.com/documentation/security

If a build failure like this arises, a new package override for the offending
Rust crate should be added to the [overlay/overrides.nix] file. The fix will
constitute at least a patch version bump to `cargo2nix`, since it is a fix of
existing functionality.

[overlay/overrides.nix]: https://github.com/cargo2nix/cargo2nix/blob/master/overlay/overrides.nix

#### 2. Failure to build due to a defect in cargo2nix

In this scenario, there is a bug in either the Nix overlay which builds the
crates, the `cargo2nix` CLI tool which generates the `Cargo.nix` expression, or
both.

If a build failure like this arises, there may be an issue with the underlying
logic used to resolve crate feature flags or the code generation of the
`Cargo.nix` expression for the workspace. These sorts of bugs will be
investigated thoroughly and may result in either a patch or minor version bump
to `cargo2nix`, depending on whether the fix results in a breaking change to the
`Cargo.nix` file format or the `mkRustCrate` logic.
