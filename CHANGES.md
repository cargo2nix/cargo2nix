# Changelog

All notable changes to this project should be documented in this file in the same PR with the change.

Add a ~1 line entry at the bottom of the appropriate section under the [Unreleased] heading. Add the section sub-heading
if necessary. Include PR number with a link at the end of the line. For example,

    - thing my change does ([#123](https://github.com/cargo2nix/cargo2nix/pull/123))

Including a PR link can be very helpful for anyone who needs more context to find it.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.12.0] - 2025-06-19

### Added

- support Rust edition 2024, Cargo.lock format version 4 ([#384](https://github.com/cargo2nix/cargo2nix/pull/384))
- support for `rustcLinkFlags` & `rustcBuildFlags` ([f0440b](https://github.com/cargo2nix/cargo2nix/commit/f0440bb8c26da073862f752baa72f1697bdf8b5f))
- support normal Nix hooks for pre/post build ([cbffde](https://github.com/cargo2nix/cargo2nix/commit/cbffded74f64a40e2e95d986f13b4c8d41068826))
- support normal Nix hooks for pre/post install ([8eb107](https://github.com/cargo2nix/cargo2nix/commit/8eb107589e613ad82893fbc72bc1e25bc424d3bc))
- improved support for sgx linker ([6e297e](https://github.com/cargo2nix/cargo2nix/commit/6e297e7e26ca1dc9dcec4f9c2ecd5fb2c0193ce9), [ffe6ab](https://github.com/cargo2nix/cargo2nix/commit/ffe6ab1c234889f928fcc84f03a875cc96ca5860))
- detection in case `Cargo.nix` is out of date with `Cargo.lock` ([f1b654](https://github.com/cargo2nix/cargo2nix/commit/f1b654e3ec1c26585e3549cbde5a54bfdb69d727))
- support passing unstable cargo flags ([63d83e](https://github.com/cargo2nix/cargo2nix/commit/63d83ec3c73371a20ad6b9e5266c426d1e9bd5f6))
- support for riscv ([806569](https://github.com/cargo2nix/cargo2nix/commit/806569c333b3e17d4f8f355cc1f9897016d3c6cd))
- support for specifying the workspace directory ([6b0c45](https://github.com/cargo2nix/cargo2nix/commit/6b0c4520301d499c612f4a0ab779cf5579eca5ec))
- support for passing a target specification file ([32f6e4](https://github.com/cargo2nix/cargo2nix/commit/32f6e40d53b4536f8849c9d71f5b05856cdcd1c5))
- use the target spec file information to resolve `target_has_atomic` ([f207ad](https://github.com/cargo2nix/cargo2nix/commit/f207adf6cb8b499b320fff373db327dc5dc4df68))
- generate target info data for all known targets ([005d0c](https://github.com/cargo2nix/cargo2nix/commit/005d0ca2e6f739b97ab307912d668047b21d124e))
- support workspace metadata ([#387](https://github.com/cargo2nix/cargo2nix/pull/387), [#333](https://github.com/cargo2nix/cargo2nix/pull/333))
- respect config.toml ([#389](https://github.com/cargo2nix/cargo2nix/pull/389))
- support for the new build script crate metadata syntax ([#393](https://github.com/cargo2nix/cargo2nix/pull/393))
- support for workspaces with root package ([#395](https://github.com/cargo2nix/cargo2nix/pull/395))

### Changed

- automatically update the lockfile, and support `--locked` ([e3916c](https://github.com/cargo2nix/cargo2nix/commit/e3916c95461046ba21b4c6e108657ff47a5fc63a))

### Fixed

- remove `extraRustComponents` from `extraArgs` to fix issue where `makePackageSetInternal` is called with an unexpected
argument when `extraRustComponents` is set ([de7dce](https://github.com/cargo2nix/cargo2nix/commit/de7dced0457aeb4e7f58e2d17ae5da78cafa3feb))
- cargo2nix is now better able to ensure that it has the necessary rustc runtime dependency ([31a801](https://github.com/cargo2nix/cargo2nix/commit/31a8019560992703871639bfbcd09bd5525b2ce3))
- disable incremental Cargo caching when building in Nix sandbox because it is redundant ([7c1eea](https://github.com/cargo2nix/cargo2nix/commit/7c1eea5ee8a00c4e89106fbe157857f1fcc24353))
- improvements to flake overlay ([04abe1](https://github.com/cargo2nix/cargo2nix/commit/04abe1dddf4ed0882bd1a9942f7ec2456dea4096))
- use a more robust method to find crates in multi-crate workspaces ([47a437](https://github.com/cargo2nix/cargo2nix/commit/47a4371028e504dbb9fc1d655dcf31418eaefc02))
- use appropriate Darwin packages in overrides of dependencies for the `sqlx-macros` crate ([31729c](https://github.com/cargo2nix/cargo2nix/commit/31729cd7f836c4a5c6273aa4779bf18d688776f5))
- reverse "bin" and "out" order in `mkcrate` so that linking information is available in default expression output ([94cd43](https://github.com/cargo2nix/cargo2nix/commit/94cd43f97d8be75ae825d0fd89d87573da54c9e4))
- include WASM outputs in store path ([738bb1](https://github.com/cargo2nix/cargo2nix/commit/738bb1d46101bb2f98ee598ae0b415e55f427d5f))
- include .dll outputs in store path ([181b3f](https://github.com/cargo2nix/cargo2nix/commit/181b3f8ea3a40c792171b8ae0e2533a8e0a29199))
- openssl-sys expects a Rust triple ([5cd006](https://github.com/cargo2nix/cargo2nix/commit/5cd00638dc4316fa74146f3632d6619181c983f6))
- always fetch Git submodules ([ca3040](https://github.com/cargo2nix/cargo2nix/commit/ca304085ab7fc9e5e67174da5a1626fd94c45674))
- filter `.package.workspace` from manifest to avoid breakage in independent crate building ([3d4f57](https://github.com/cargo2nix/cargo2nix/commit/3d4f5714760cb9835f5455836d369da197bb5bb7))
- handle dependency keys with spaces ([8e8cce](https://github.com/cargo2nix/cargo2nix/commit/8e8cce14b78dcaa3ebf9216ca52971c310e6194a))
- add wrapper for clippy-driver ([686cda](https://github.com/cargo2nix/cargo2nix/commit/686cda2fe13131d05a66bd54ea1e3eab55f5baea))
- fix feature detection ([b2a89c](https://github.com/cargo2nix/cargo2nix/commit/b2a89cbfb4542531feedfed9bfe549db18242626))
- replace use of Nix' `replaceChars` function with `replaceStrings` to fix deprecation warning ([f9926c](https://github.com/cargo2nix/cargo2nix/commit/f9926cf925dca378f9494138edc8c7e1564a8e53))
- rehydrate `depKeys` even if they contain spaces ([fe1087](https://github.com/cargo2nix/cargo2nix/commit/fe108719feba1c26f62a7b65acdaeb7b3f633173))
- quote `$manifest_path` so it doesn't break comparison if empty ([f7b11e](https://github.com/cargo2nix/cargo2nix/commit/f7b11edb4097f8911ea8e0775e427c8570559b1a))
- configure cargo to avoid any network access ([f7f515](https://github.com/cargo2nix/cargo2nix/commit/f7f5156b2cf020e37e83b8363442ddfe9812cc40))
- fix endianness check ([0a99ab](https://github.com/cargo2nix/cargo2nix/commit/0a99abf882b3159b3d4c3528c920de9895e2bfc9))

## [0.11.0] - 2022-05-14
