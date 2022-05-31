# Contributing

This is a project that only succeeds through use.  Every build brings us closer
to being a general tool for packaging and distributing Rust software with nix.

## Issues

When opening an issue, you can help us and help yourself.

### How to Debug on Your Own

Check the [common issues][common issues] section.  Likely fixes:

- A build override, perhaps modifying a value for `buildPhase` or `unpackPhase`
- An override of dependencies such as in [overrides][overrides]
- A modification of the build steps in [mkcrate.nix][mkcrate] or
  [mkcrate-utils.sh][mkcrate-utils]

You can [replicate the exact build environment][replicate] for a failing derivation and try
to build it yourself.  This will allow you to make changes and develop phase
overrides or source patches.

[common issues]: https://github.com/cargo2nix/cargo2nix#common-issues
[overrides]: https://github.com/cargo2nix/cargo2nix/blob/master/overlay/overrides.nix
[mkcrate]: https://github.com/cargo2nix/cargo2nix/blob/master/overlay/mkcrate.nix
[mkcrate-utils]: https://github.com/cargo2nix/cargo2nix/blob/master/overlay/mkcrate-utils.sh
[replicate]: https://github.com/cargo2nix/cargo2nix#declarative-debug--development-shell

### Examples Builds We Maintain

Check inside of [examples][examples].  Can you build these examples?  Can you
replicate your issue in a branch on one of our examples?

[examples]: https://github.com/cargo2nix/cargo2nix/tree/master/examples

### Files We Sometimes Use in Debugging

- Cargo.toml
- flake.nix
- build.rs
- .cargo/config.toml
- Cargo.nix
- flake.lock
- Cargo.lock

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

## Usage Help

Using cargo2nix is about 5% running the cargo2nix tool and 95% figuring out how
to construct the right nix expressions.  The cargo feature you need may or may
not be supported yet by our overlay or cargo2nix's ability to comprehend your
`Cargo.toml`

### Cargo2nix overlay API

Some of the features our overlay supports may be difficult to find.  There's
some documentation in the [nix flake][nix flake].  The [examples][examples]
contain some more hints.  Ultimately, arguments to `rustBuilder.makePackageSet`
are consumed in [make-package-set/user-facing.nix][user-facing], which calls
into `make-package-set/internal.nix`

[nix flake]: https://github.com/cargo2nix/cargo2nix/blob/master/flake.nix
[examples]: https://github.com/cargo2nix/cargo2nix/blob/master/examples
[user-facing]: https://github.com/cargo2nix/cargo2nix/blob/master/overlay/make-package-set/simplified.nix

Each output in `rustPkgs.workspace.<name>` supports arguments.  Many are
demonstrated in the [nix flake] comments, but check [mkcrate.nix] for how they
are used.

[mkcrate.nix]: https://github.com/cargo2nix/cargo2nix/blob/master/overlay/mkcrate.nix
[nix flake]: https://github.com/cargo2nix/cargo2nix/blob/master/flake.nix

## Pull Requests

Many files are generated.  When you draft your changes, please separate out
commits that affect:

- Cargo.lock
- Cargo.nix
- flake.lock

Keeping these changes isolated in specific commits makes it much easier to pull
in your changes in parallel with other features.  Maintainers may harvest your
changes.  We only guarantee to preserve authorship in the git log (when we
remember to do so).

### Creating pull requests

1. Fork this repository into the personal GitHub account
2. Select the appropriate branch, release-<version> for stable changes, unstable
   for breaking changes
3. Make changes on the personal fork
4. Make a Pull Request against this repository
5. **Allow maintainers to make changes to your pull request** (there's a checkbox)
6. Once the pull request has been approved, you will be thanked and observe your
   changes applied with authorship preserved (if we remember)
