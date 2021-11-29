# The stdenv.buildPlatform and stdenv.hostPlatform configurations need
# translation to triples that Rust understands.  These are consumed when writing
# the synthetic Cargo.toml and when invoking cargo, as CXX_flags, and when
# installing crates.  Most of this takes place in mkcrate.nix.

# Please update this file if you find a missing pair.
# Examples of the kinds of values in Nix platform.system:
# nix repl '<nixpkgs>'
# nix-repl> lib.systems.doubles.wasi
# [ "wasm64-wasi" "wasm32-wasi" ]
# nix-repl> lib.systems.examples.wasi32
# { config = "wasm32-unknown-wasi"; useLLVM = true; }

# The list of triples (which are not all triples) that Rust may recognize
# https://rust-lang.github.io/rustup-components-history/

platform:
let
  cpu = if platform.parsed.cpu.name == "armv6" then "arm" else platform.parsed.cpu.name;
  vendor = platform.parsed.vendor.name;
  kernel = platform.parsed.kernel.name;
  abi = platform.parsed.abi.name;
in {
  # Nix platform.system       # Supported Rust targets
  "i686-linux"              = "i686-unknown-linux-${abi}";
  "x86_64-linux"            = "x86_64-unknown-linux-${abi}";
  "armv5tel-linux"          = "arm-unknown-linux-${abi}";
  "armv6l-linux"            = "arm-unknown-linux-${abi}";
  "armv7a-android"          = "armv7-linux-androideabi";
  "armv7l-linux"            = "armv7-unknown-linux-${abi}";
  "aarch64-darwin"          = "aarch64-apple-darwin";
  "aarch64-linux"           = "aarch64-unknown-linux-${abi}";
  "mips64el-linux"          = "mips64el-unknown-linux-${abi}";
  "x86_64-darwin"           = "x86_64-apple-darwin";
  "i686-cygwin"             = "i686-pc-windows-${abi}";
  "x86_64-cygwin"           = "x86_64-pc-windows-${abi}";
  "x86_64-freebsd"          = "x86_64-unknown-freebsd";
  "wasm64-wasi"             = "wasm64-wasi"; # unsupported
  "wasm32-emscripten"       = "wasm32-unknown-emscripten";
  "wasm32-unknown"          = "wasm32-unknown-unknown";
  "wasm32-wasi"             = "wasm32-wasi";
  "wasm32-unknown-wasi"     = "wasm32-wasi";
}.${platform.system} or platform.config
