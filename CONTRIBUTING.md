# Contributing Guidelines

`cargo2nix` is an open-source project that values community contribution. We
could always use a helping hand!

This documents describes rules and regulations for contributions to the project.
The contribution process is a process of proposing and applying changes to this
repository exclusively and does not automatically affect forks of this
repository.

## Creating pull requests

This is a general contribution process for internal and external pull requests
to this repository.

1. Fork this repository into the personal GitHub account.
2. Make changes on the personal fork.
3. Make a Pull Request against this repository.
4. Maintainers of this repository propose changes to the pull request and have
   the ultimate right to approve the pull request.
5. Once the pull request has been approved, maintainers of this repository have
   the ultimate right to decide the time and process of merging or incorporating
   the changes. In case of incorporating changes without using merges,
   maintainers must, in the commit messages, include the authors of the pull
   request as co-authors. In case of incorporating changes using merges,
   maintainers of this repository should use squashing merges.

## Submitting issues

For raising issues, the GitHub issue tracker is used. Issues will be labeled
accordingly using the `bug`, `enhancement`, and `question` tags as appropriate.
The maintainers of this repository have the ultimate right to manage the state
of these issues, including the assigned labels, comment moderation, (re)opening,
and closing.

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

[overlay/overrides.nix]: https://github.com/tenx-tech/cargo2nix/blob/master/overlay/overrides.nix

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
