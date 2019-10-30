let
  profiles = {
  };
in
args@{
  release ? true,
  rootFeatures ? { 
    "cargo2nix/default" = { };
  },
  rustPackages,
  buildRustPackages,
  mkRustCrate,
  hostPlatform,
  rustLib,
  lib,
}:
let
  inherit (rustLib) fetchCratesIo fetchCrateLocal fetchCrateGit expandFeatures;
  rootFeatures = expandFeatures args.rootFeatures;
in
{
  "registry+https://github.com/rust-lang/crates.io-index".adler32."1.0.4" = mkRustCrate {
    inherit release profiles;
    name = "adler32";
    version = "1.0.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "adler32";
      version = "1.0.4";
      sha256 = "5d2e7343e7fc9de883d1b0341e0b13970f764c14101234857d2ddafa1cb1cac2";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Remi Rampin <remirampin@gmail.com>\"]\ndescription = \"Minimal Adler32 implementation for Rust.\"\ndocumentation = \"https://remram44.github.io/adler32-rs/index.html\"\nkeywords = [\"adler32\", \"hash\", \"rolling\"]\nlicense = \"Zlib\"\nname = \"adler32\"\nreadme = \"README.md\"\nrepository = \"https://github.com/remram44/adler32-rs\"\nversion = \"1.0.4\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".aho-corasick."0.7.6" = mkRustCrate {
    inherit release profiles;
    name = "aho-corasick";
    version = "0.7.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "aho-corasick";
      version = "0.7.6";
      sha256 = "58fb5e95d83b38284460a5fda7d6470aa0b8844d283a0b614b8535e880800d2d";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
    dependencies = {
      memchr = rustPackages."registry+https://github.com/rust-lang/crates.io-index".memchr."2.2.1" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nname = \"aho_corasick\"\n\n[package]\nauthors = [\"Andrew Gallant <jamslam@gmail.com>\"]\nautotests = false\ncategories = [\"text-processing\"]\ndescription = \"Fast multiple substring searching.\"\nexclude = [\"/aho-corasick-debug\", \"/ci/*\", \"/.travis.yml\", \"/appveyor.yml\"]\nhomepage = \"https://github.com/BurntSushi/aho-corasick\"\nkeywords = [\"string\", \"search\", \"text\", \"aho\", \"multi\"]\nlicense = \"Unlicense/MIT\"\nname = \"aho-corasick\"\nreadme = \"README.md\"\nrepository = \"https://github.com/BurntSushi/aho-corasick\"\nversion = \"0.7.6\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".ansi_term."0.11.0" = mkRustCrate {
    inherit release profiles;
    name = "ansi_term";
    version = "0.11.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "ansi_term";
      version = "0.11.0";
      sha256 = "ee49baf6cb617b853aa8d93bf420db2383fab46d314482ca2803b40d5fde979b";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.parsed.kernel.name == "windows" then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nname = \"ansi_term\"\n\n[package]\nauthors = [\"ogham@bsago.me\", \"Ryan Scheel (Havvy) <ryan.havvy@gmail.com>\", \"Josh Triplett <josh@joshtriplett.org>\"]\ndescription = \"Library for ANSI terminal colours and styles (bold, underline)\"\ndocumentation = \"https://docs.rs/ansi_term\"\nhomepage = \"https://github.com/ogham/rust-ansi-term\"\nlicense = \"MIT\"\nname = \"ansi_term\"\nreadme = \"README.md\"\nversion = \"0.11.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".atty."0.2.13" = mkRustCrate {
    inherit release profiles;
    name = "atty";
    version = "0.2.13";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "atty";
      version = "0.2.13";
      sha256 = "1803c647a3ec87095e7ae7acfca019e98de5ec9a7d01343f611cf3152ed71a90";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isUnix then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"softprops <d.tangren@gmail.com>\"]\ndescription = \"A simple interface for querying atty\"\ndocumentation = \"http://softprops.github.io/atty\"\nexclude = [\"/.travis.yml\", \"/appveyor.yml\"]\nhomepage = \"https://github.com/softprops/atty\"\nkeywords = [\"terminal\", \"tty\", \"isatty\"]\nlicense = \"MIT\"\nname = \"atty\"\nreadme = \"README.md\"\nrepository = \"https://github.com/softprops/atty\"\nversion = \"0.2.13\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".autocfg."0.1.7" = mkRustCrate {
    inherit release profiles;
    name = "autocfg";
    version = "0.1.7";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "autocfg";
      version = "0.1.7";
      sha256 = "1d49d90015b3c36167a20fe2810c5cd875ad504b39cff3d4eae7977e6b7c1cb2";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Josh Stone <cuviper@gmail.com>\"]\ncategories = [\"development-tools::build-utils\"]\ndescription = \"Automatic cfg for Rust compiler features\"\nkeywords = [\"rustc\", \"build\", \"autoconf\"]\nlicense = \"Apache-2.0/MIT\"\nname = \"autocfg\"\nreadme = \"README.md\"\nrepository = \"https://github.com/cuviper/autocfg\"\nversion = \"0.1.7\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".backtrace."0.3.40" = mkRustCrate {
    inherit release profiles;
    name = "backtrace";
    version = "0.3.40";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "backtrace";
      version = "0.3.40";
      sha256 = "924c76597f0d9ca25d762c25a4d369d51267536465dc5064bdf0eb073ed477ea";
    };
    features = builtins.concatLists [
      [ "backtrace-sys" ]
      [ "dbghelp" ]
      [ "default" ]
      [ "dladdr" ]
      [ "libbacktrace" ]
      [ "libunwind" ]
      [ "std" ]
    ];
    dependencies = {
      backtrace_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".backtrace-sys."0.1.32" { };
      cfg_if = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { };
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
      rustc_demangle = rustPackages."registry+https://github.com/rust-lang/crates.io-index".rustc-demangle."0.1.16" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[[example]]\nname = \"backtrace\"\nrequired-features = [\"std\"]\n\n[[example]]\nname = \"raw\"\nrequired-features = [\"std\"]\n\n[[test]]\nname = \"skip_inner_frames\"\nrequired-features = [\"std\"]\n\n[[test]]\nname = \"long_fn_name\"\nrequired-features = [\"std\"]\n\n[[test]]\nedition = \"2018\"\nname = \"smoke\"\nrequired-features = [\"std\"]\n\n[[test]]\nedition = \"2018\"\nname = \"accuracy\"\nrequired-features = [\"std\", \"dbghelp\", \"libbacktrace\", \"libunwind\"]\n\n[[test]]\nharness = false\nname = \"concurrent-panics\"\nrequired-features = [\"std\"]\n\n[package]\nauthors = [\"The Rust Project Developers\"]\nautoexamples = true\nautotests = true\ndescription = \"A library to acquire a stack trace (backtrace) at runtime in a Rust program.\\n\"\ndocumentation = \"https://docs.rs/backtrace\"\nedition = \"2018\"\nhomepage = \"https://github.com/rust-lang/backtrace-rs\"\nlicense = \"MIT/Apache-2.0\"\nname = \"backtrace\"\nreadme = \"README.md\"\nrepository = \"https://github.com/rust-lang/backtrace-rs\"\nversion = \"0.3.40\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".backtrace-sys."0.1.32" = mkRustCrate {
    inherit release profiles;
    name = "backtrace-sys";
    version = "0.1.32";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "backtrace-sys";
      version = "0.1.32";
      sha256 = "5d6575f128516de27e3ce99689419835fce9643a9b215a14d2b5b685be018491";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
    };
    devDependencies = {
    };
    buildDependencies = {
      cc = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".cc."1.0.46" { };
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\nbuild = \"build.rs\"\ndescription = \"Bindings to the libbacktrace gcc library\\n\"\ndocumentation = \"http://alexcrichton.com/backtrace-rs\"\nhomepage = \"https://github.com/alexcrichton/backtrace-rs\"\nlicense = \"MIT/Apache-2.0\"\nname = \"backtrace-sys\"\nrepository = \"https://github.com/alexcrichton/backtrace-rs\"\nversion = \"0.1.32\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".bitflags."1.2.1" = mkRustCrate {
    inherit release profiles;
    name = "bitflags";
    version = "1.2.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "bitflags";
      version = "1.2.1";
      sha256 = "cf1de2fe8c75bc145a2f577add951f8134889b4795d47466a54a5c846d691693";
    };
    features = builtins.concatLists [
      [ "default" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"The Rust Project Developers\"]\nbuild = \"build.rs\"\ncategories = [\"no-std\"]\ndescription = \"A macro to generate structures which behave like bitflags.\\n\"\ndocumentation = \"https://docs.rs/bitflags\"\nexclude = [\".travis.yml\", \"appveyor.yml\", \"bors.toml\"]\nhomepage = \"https://github.com/bitflags/bitflags\"\nkeywords = [\"bit\", \"bitmask\", \"bitflags\", \"flags\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"bitflags\"\nreadme = \"README.md\"\nrepository = \"https://github.com/bitflags/bitflags\"\nversion = \"1.2.1\"\n[package.metadata.docs.rs]\nfeatures = [\"example_generated\"]\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".bstr."0.2.8" = mkRustCrate {
    inherit release profiles;
    name = "bstr";
    version = "0.2.8";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "bstr";
      version = "0.2.8";
      sha256 = "8d6c2c5b58ab920a4f5aeaaca34b4488074e8cc7596af94e6f8c6ff247c60245";
    };
    features = builtins.concatLists [
      [ "std" ]
    ];
    dependencies = {
      memchr = rustPackages."registry+https://github.com/rust-lang/crates.io-index".memchr."2.2.1" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nbench = false\n\n[package]\nauthors = [\"Andrew Gallant <jamslam@gmail.com>\"]\ncategories = [\"text-processing\", \"encoding\"]\ndescription = \"A string type that is not required to be valid UTF-8.\"\ndocumentation = \"https://docs.rs/bstr\"\nexclude = [\"/ci/*\", \"/.travis.yml\", \"/appveyor.yml\"]\nhomepage = \"https://github.com/BurntSushi/bstr\"\nkeywords = [\"string\", \"str\", \"byte\", \"bytes\", \"text\"]\nlicense = \"MIT OR Apache-2.0\"\nname = \"bstr\"\nreadme = \"README.md\"\nrepository = \"https://github.com/BurntSushi/bstr\"\nversion = \"0.2.8\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".byteorder."1.3.2" = mkRustCrate {
    inherit release profiles;
    name = "byteorder";
    version = "1.3.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "byteorder";
      version = "1.3.2";
      sha256 = "a7c3dd8985a7111efc5c80b44e23ecdd8c007de8ade3b96595387e812b957cf5";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nbench = false\nname = \"byteorder\"\n\n[package]\nauthors = [\"Andrew Gallant <jamslam@gmail.com>\"]\nbuild = \"build.rs\"\ncategories = [\"encoding\", \"parsing\"]\ndescription = \"Library for reading/writing numbers in big-endian and little-endian.\"\ndocumentation = \"https://docs.rs/byteorder\"\nexclude = [\"/ci/*\"]\nhomepage = \"https://github.com/BurntSushi/byteorder\"\nkeywords = [\"byte\", \"endian\", \"big-endian\", \"little-endian\", \"binary\"]\nlicense = \"Unlicense OR MIT\"\nname = \"byteorder\"\nreadme = \"README.md\"\nrepository = \"https://github.com/BurntSushi/byteorder\"\nversion = \"1.3.2\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".bytes."0.4.12" = mkRustCrate {
    inherit release profiles;
    name = "bytes";
    version = "0.4.12";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "bytes";
      version = "0.4.12";
      sha256 = "206fdffcfa2df7cbe15601ef46c813fce0965eb3286db6b56c583b814b51c81c";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      byteorder = rustPackages."registry+https://github.com/rust-lang/crates.io-index".byteorder."1.3.2" { };
      iovec = rustPackages."registry+https://github.com/rust-lang/crates.io-index".iovec."0.1.4" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Carl Lerche <me@carllerche.com>\"]\ncategories = [\"network-programming\", \"data-structures\"]\ndescription = \"Types and traits for working with bytes\"\ndocumentation = \"https://docs.rs/bytes/0.4.12/bytes\"\nexclude = [\".gitignore\", \".travis.yml\", \"deploy.sh\", \"bench/**/*\", \"test/**/*\"]\nhomepage = \"https://github.com/carllerche/bytes\"\nkeywords = [\"buffers\", \"zero-copy\", \"io\"]\nlicense = \"MIT\"\nname = \"bytes\"\nreadme = \"README.md\"\nrepository = \"https://github.com/carllerche/bytes\"\nversion = \"0.4.12\"\n[package.metadata.docs.rs]\nfeatures = [\"i128\"]\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".bytesize."1.0.0" = mkRustCrate {
    inherit release profiles;
    name = "bytesize";
    version = "1.0.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "bytesize";
      version = "1.0.0";
      sha256 = "716960a18f978640f25101b5cbf1c6f6b0d3192fab36a2d98ca96f0ecbe41010";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Hyunsik Choi <hyunsik.choi@gmail.com>\"]\ndescription = \"an utility for human-readable bytes representations\"\ndocumentation = \"https://docs.rs/bytesize/\"\nhomepage = \"https://github.com/hyunsik/bytesize/\"\nkeywords = [\"byte\", \"byte-size\", \"utility\", \"human-readable\", \"format\"]\nlicense = \"Apache-2.0\"\nname = \"bytesize\"\nreadme = \"README.md\"\nrepository = \"https://github.com/hyunsik/bytesize/\"\nversion = \"1.0.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".c2-chacha."0.2.3" = mkRustCrate {
    inherit release profiles;
    name = "c2-chacha";
    version = "0.2.3";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "c2-chacha";
      version = "0.2.3";
      sha256 = "214238caa1bf3a496ec3392968969cab8549f96ff30652c9e56885329315f6bb";
    };
    features = builtins.concatLists [
      [ "simd" ]
      [ "std" ]
    ];
    dependencies = {
      ppv_lite86 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".ppv-lite86."0.2.6" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"The CryptoCorrosion Contributors\"]\ncategories = [\"cryptography\", \"no-std\"]\ndescription = \"The ChaCha family of stream ciphers\"\ndocumentation = \"https://docs.rs/c2-chacha\"\nedition = \"2018\"\nkeywords = [\"chacha\", \"chacha20\", \"xchacha20\", \"cipher\", \"crypto\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"c2-chacha\"\nreadme = \"README.md\"\nrepository = \"https://github.com/cryptocorrosion/cryptocorrosion\"\nversion = \"0.2.3\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".cargo."0.39.0" = mkRustCrate {
    inherit release profiles;
    name = "cargo";
    version = "0.39.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "cargo";
      version = "0.39.0";
      sha256 = "92848afb3f52015ba227aa1480c2861f800f92edd41d6536eaaa44ddc8b97837";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      atty = rustPackages."registry+https://github.com/rust-lang/crates.io-index".atty."0.2.13" { };
      byteorder = rustPackages."registry+https://github.com/rust-lang/crates.io-index".byteorder."1.3.2" { };
      bytesize = rustPackages."registry+https://github.com/rust-lang/crates.io-index".bytesize."1.0.0" { };
      clap = rustPackages."registry+https://github.com/rust-lang/crates.io-index".clap."2.33.0" { };
      ${ if hostPlatform.parsed.kernel.name == "darwin" then "core_foundation" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".core-foundation."0.6.4" { };
      crates_io = rustPackages."registry+https://github.com/rust-lang/crates.io-index".crates-io."0.27.0" { };
      crossbeam_utils = rustPackages."registry+https://github.com/rust-lang/crates.io-index".crossbeam-utils."0.6.6" { };
      crypto_hash = rustPackages."registry+https://github.com/rust-lang/crates.io-index".crypto-hash."0.3.4" { };
      curl = rustPackages."registry+https://github.com/rust-lang/crates.io-index".curl."0.4.25" { };
      curl_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".curl-sys."0.4.23" { };
      env_logger = rustPackages."registry+https://github.com/rust-lang/crates.io-index".env_logger."0.6.2" { };
      failure = rustPackages."registry+https://github.com/rust-lang/crates.io-index".failure."0.1.6" { };
      filetime = rustPackages."registry+https://github.com/rust-lang/crates.io-index".filetime."0.2.7" { };
      flate2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".flate2."1.0.12" { };
      fs2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".fs2."0.4.3" { };
      ${ if hostPlatform.isWindows then "fwdansi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".fwdansi."1.0.1" { };
      git2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".git2."0.9.2" { };
      git2_curl = rustPackages."registry+https://github.com/rust-lang/crates.io-index".git2-curl."0.10.1" { };
      glob = rustPackages."registry+https://github.com/rust-lang/crates.io-index".glob."0.3.0" { };
      hex = rustPackages."registry+https://github.com/rust-lang/crates.io-index".hex."0.3.2" { };
      home = rustPackages."registry+https://github.com/rust-lang/crates.io-index".home."0.3.4" { };
      ignore = rustPackages."registry+https://github.com/rust-lang/crates.io-index".ignore."0.4.10" { };
      im_rc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".im-rc."13.0.0" { };
      jobserver = rustPackages."registry+https://github.com/rust-lang/crates.io-index".jobserver."0.1.17" { };
      lazy_static = rustPackages."registry+https://github.com/rust-lang/crates.io-index".lazy_static."1.4.0" { };
      lazycell = rustPackages."registry+https://github.com/rust-lang/crates.io-index".lazycell."1.2.1" { };
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
      libgit2_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libgit2-sys."0.8.2" { };
      log = rustPackages."registry+https://github.com/rust-lang/crates.io-index".log."0.4.8" { };
      memchr = rustPackages."registry+https://github.com/rust-lang/crates.io-index".memchr."2.2.1" { };
      ${ if hostPlatform.isWindows then "miow" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".miow."0.3.3" { };
      num_cpus = rustPackages."registry+https://github.com/rust-lang/crates.io-index".num_cpus."1.10.1" { };
      opener = rustPackages."registry+https://github.com/rust-lang/crates.io-index".opener."0.4.1" { };
      rustc_workspace_hack = rustPackages."registry+https://github.com/rust-lang/crates.io-index".rustc-workspace-hack."1.0.0" { };
      rustfix = rustPackages."registry+https://github.com/rust-lang/crates.io-index".rustfix."0.4.6" { };
      same_file = rustPackages."registry+https://github.com/rust-lang/crates.io-index".same-file."1.0.5" { };
      semver = rustPackages."registry+https://github.com/rust-lang/crates.io-index".semver."0.9.0" { };
      serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" { };
      serde_ignored = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde_ignored."0.0.4" { };
      serde_json = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde_json."1.0.41" { };
      shell_escape = rustPackages."registry+https://github.com/rust-lang/crates.io-index".shell-escape."0.1.4" { };
      strip_ansi_escapes = rustPackages."registry+https://github.com/rust-lang/crates.io-index".strip-ansi-escapes."0.1.0" { };
      tar = rustPackages."registry+https://github.com/rust-lang/crates.io-index".tar."0.4.26" { };
      tempfile = rustPackages."registry+https://github.com/rust-lang/crates.io-index".tempfile."3.1.0" { };
      termcolor = rustPackages."registry+https://github.com/rust-lang/crates.io-index".termcolor."1.0.5" { };
      toml = rustPackages."registry+https://github.com/rust-lang/crates.io-index".toml."0.5.3" { };
      unicode_width = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-width."0.1.6" { };
      url = rustPackages."registry+https://github.com/rust-lang/crates.io-index".url."1.7.2" { };
      url_serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".url_serde."0.2.0" { };
      walkdir = rustPackages."registry+https://github.com/rust-lang/crates.io-index".walkdir."2.2.9" { };
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[[bin]]\ndoc = false\nname = \"cargo\"\ntest = false\n\n[lib]\nname = \"cargo\"\npath = \"src/cargo/lib.rs\"\n\n[package]\nauthors = [\"Yehuda Katz <wycats@gmail.com>\", \"Carl Lerche <me@carllerche.com>\", \"Alex Crichton <alex@alexcrichton.com>\"]\ndescription = \"Cargo, a package manager for Rust.\\n\"\ndocumentation = \"https://docs.rs/cargo\"\nedition = \"2018\"\nhomepage = \"https://crates.io\"\nlicense = \"MIT OR Apache-2.0\"\nname = \"cargo\"\nrepository = \"https://github.com/rust-lang/cargo\"\nversion = \"0.39.0\"\n";
  };
  
  "unknown".cargo2nix."0.4.0" = mkRustCrate {
    inherit release profiles;
    name = "cargo2nix";
    version = "0.4.0";
    registry = "unknown";
    src = fetchCrateLocal ./.;
    features = builtins.concatLists [
    ];
    dependencies = {
      cargo = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cargo."0.39.0" { };
      once_cell = rustPackages."registry+https://github.com/rust-lang/crates.io-index".once_cell."1.2.0" { };
      pathdiff = rustPackages."registry+https://github.com/rust-lang/crates.io-index".pathdiff."0.1.0" { };
      regex = rustPackages."registry+https://github.com/rust-lang/crates.io-index".regex."1.3.1" { };
      serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" { };
      serde_json = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde_json."1.0.41" { };
      toml = rustPackages."registry+https://github.com/rust-lang/crates.io-index".toml."0.5.3" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nedition = \"2018\"\nlicense = \"MIT\"\nname = \"cargo2nix\"\nversion = \"0.4.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".cc."1.0.46" = mkRustCrate {
    inherit release profiles;
    name = "cc";
    version = "1.0.46";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "cc";
      version = "1.0.46";
      sha256 = "0213d356d3c4ea2c18c40b037c3be23cd639825c18f25ee670ac7813beeef99c";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\ncategories = [\"development-tools::build-utils\"]\ndescription = \"A build-time dependency for Cargo build scripts to assist in invoking the native\\nC compiler to compile native C code into a static archive to be linked into Rust\\ncode.\\n\"\ndocumentation = \"https://docs.rs/cc\"\nedition = \"2018\"\nexclude = [\"/.travis.yml\", \"/appveyor.yml\"]\nhomepage = \"https://github.com/alexcrichton/cc-rs\"\nkeywords = [\"build-dependencies\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"cc\"\nreadme = \"README.md\"\nrepository = \"https://github.com/alexcrichton/cc-rs\"\nversion = \"1.0.46\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" = mkRustCrate {
    inherit release profiles;
    name = "cfg-if";
    version = "0.1.10";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "cfg-if";
      version = "0.1.10";
      sha256 = "4785bdd1c96b2a846b2bd7cc02e86b6b3dbf14e7e53446c4f54c92a361040822";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\ndescription = \"A macro to ergonomically define an item depending on a large number of #[cfg]\\nparameters. Structured like an if-else chain, the first matching branch is the\\nitem that gets emitted.\\n\"\ndocumentation = \"https://docs.rs/cfg-if\"\nedition = \"2018\"\nhomepage = \"https://github.com/alexcrichton/cfg-if\"\nlicense = \"MIT/Apache-2.0\"\nname = \"cfg-if\"\nreadme = \"README.md\"\nrepository = \"https://github.com/alexcrichton/cfg-if\"\nversion = \"0.1.10\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".clap."2.33.0" = mkRustCrate {
    inherit release profiles;
    name = "clap";
    version = "2.33.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "clap";
      version = "2.33.0";
      sha256 = "5067f5bb2d80ef5d68b4c87db81601f0b75bca627bc2ef76b141d7b846a3c6d9";
    };
    features = builtins.concatLists [
      [ "ansi_term" ]
      [ "atty" ]
      [ "color" ]
      [ "default" ]
      [ "strsim" ]
      [ "suggestions" ]
      [ "vec_map" ]
    ];
    dependencies = {
      ${ if !hostPlatform.isWindows then "ansi_term" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".ansi_term."0.11.0" { };
      atty = rustPackages."registry+https://github.com/rust-lang/crates.io-index".atty."0.2.13" { };
      bitflags = rustPackages."registry+https://github.com/rust-lang/crates.io-index".bitflags."1.2.1" { };
      strsim = rustPackages."registry+https://github.com/rust-lang/crates.io-index".strsim."0.8.0" { };
      textwrap = rustPackages."registry+https://github.com/rust-lang/crates.io-index".textwrap."0.11.0" { };
      unicode_width = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-width."0.1.6" { };
      vec_map = rustPackages."registry+https://github.com/rust-lang/crates.io-index".vec_map."0.8.1" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Kevin K. <kbknapp@gmail.com>\"]\ncategories = [\"command-line-interface\"]\ndescription = \"A simple to use, efficient, and full-featured Command Line Argument Parser\\n\"\ndocumentation = \"https://docs.rs/clap/\"\nexclude = [\"examples/*\", \"clap-test/*\", \"tests/*\", \"benches/*\", \"*.png\", \"clap-perf/*\", \"*.dot\"]\nhomepage = \"https://clap.rs/\"\nkeywords = [\"argument\", \"cli\", \"arg\", \"parser\", \"parse\"]\nlicense = \"MIT\"\nname = \"clap\"\nreadme = \"README.md\"\nrepository = \"https://github.com/clap-rs/clap\"\nversion = \"2.33.0\"\n[package.metadata.docs.rs]\nfeatures = [\"doc\"]\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".commoncrypto."0.2.0" = mkRustCrate {
    inherit release profiles;
    name = "commoncrypto";
    version = "0.2.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "commoncrypto";
      version = "0.2.0";
      sha256 = "d056a8586ba25a1e4d61cb090900e495952c7886786fc55f909ab2f819b69007";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      commoncrypto_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".commoncrypto-sys."0.2.0" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Mark Lee\"]\ndescription = \"Idiomatic Rust wrappers for Mac OS X\'s CommonCrypto library\"\ndocumentation = \"https://docs.rs/commoncrypto\"\nkeywords = [\"crypto\", \"hash\", \"digest\", \"osx\", \"commoncrypto\"]\nlicense = \"MIT\"\nname = \"commoncrypto\"\nrepository = \"https://github.com/malept/rust-commoncrypto\"\nversion = \"0.2.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".commoncrypto-sys."0.2.0" = mkRustCrate {
    inherit release profiles;
    name = "commoncrypto-sys";
    version = "0.2.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "commoncrypto-sys";
      version = "0.2.0";
      sha256 = "1fed34f46747aa73dfaa578069fd8279d2818ade2b55f38f22a9401c7f4083e2";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Mark Lee\"]\ndescription = \"FFI bindings to Mac OS X\'s CommonCrypto library\"\ndocumentation = \"https://docs.rs/commoncrypto-sys\"\nkeywords = [\"crypto\", \"hash\", \"digest\", \"osx\", \"commoncrypto\"]\nlicense = \"MIT\"\nname = \"commoncrypto-sys\"\nrepository = \"https://github.com/malept/rust-commoncrypto\"\nversion = \"0.2.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".core-foundation."0.6.4" = mkRustCrate {
    inherit release profiles;
    name = "core-foundation";
    version = "0.6.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "core-foundation";
      version = "0.6.4";
      sha256 = "25b9e03f145fd4f2bf705e07b900cd41fc636598fe5dc452fd0db1441c3f496d";
    };
    features = builtins.concatLists [
      [ "mac_os_10_7_support" ]
    ];
    dependencies = {
      core_foundation_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".core-foundation-sys."0.6.2" { };
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"The Servo Project Developers\"]\ncategories = [\"os::macos-apis\"]\ndescription = \"Bindings to Core Foundation for macOS\"\nhomepage = \"https://github.com/servo/core-foundation-rs\"\nkeywords = [\"macos\", \"framework\", \"objc\"]\nlicense = \"MIT / Apache-2.0\"\nname = \"core-foundation\"\nrepository = \"https://github.com/servo/core-foundation-rs\"\nversion = \"0.6.4\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".core-foundation-sys."0.6.2" = mkRustCrate {
    inherit release profiles;
    name = "core-foundation-sys";
    version = "0.6.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "core-foundation-sys";
      version = "0.6.2";
      sha256 = "e7ca8a5221364ef15ce201e8ed2f609fc312682a8f4e0e3d4aa5879764e0fa3b";
    };
    features = builtins.concatLists [
      [ "mac_os_10_7_support" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"The Servo Project Developers\"]\nbuild = \"build.rs\"\ndescription = \"Bindings to Core Foundation for OS X\"\nhomepage = \"https://github.com/servo/core-foundation-rs\"\nlicense = \"MIT / Apache-2.0\"\nname = \"core-foundation-sys\"\nrepository = \"https://github.com/servo/core-foundation-rs\"\nversion = \"0.6.2\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".crates-io."0.27.0" = mkRustCrate {
    inherit release profiles;
    name = "crates-io";
    version = "0.27.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "crates-io";
      version = "0.27.0";
      sha256 = "3605c99a8cbb106e6cc954a4cf9e46124f38b541d1243245e480f85cb909d64b";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      curl = rustPackages."registry+https://github.com/rust-lang/crates.io-index".curl."0.4.25" { };
      failure = rustPackages."registry+https://github.com/rust-lang/crates.io-index".failure."0.1.6" { };
      http = rustPackages."registry+https://github.com/rust-lang/crates.io-index".http."0.1.19" { };
      serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" { };
      serde_derive = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".serde_derive."1.0.101" { };
      serde_json = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde_json."1.0.41" { };
      url = rustPackages."registry+https://github.com/rust-lang/crates.io-index".url."1.7.2" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nname = \"crates_io\"\npath = \"lib.rs\"\n\n[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\ndescription = \"Helpers for interacting with crates.io\\n\"\nedition = \"2018\"\nlicense = \"MIT OR Apache-2.0\"\nname = \"crates-io\"\nrepository = \"https://github.com/rust-lang/cargo\"\nversion = \"0.27.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".crc32fast."1.2.0" = mkRustCrate {
    inherit release profiles;
    name = "crc32fast";
    version = "1.2.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "crc32fast";
      version = "1.2.0";
      sha256 = "ba125de2af0df55319f41944744ad91c71113bf74a4646efff39afe1f6842db1";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
    dependencies = {
      cfg_if = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[[bench]]\nharness = false\nname = \"bench\"\n\n[package]\nauthors = [\"Sam Rijs <srijs@airpost.net>\", \"Alex Crichton <alex@alexcrichton.com>\"]\ndescription = \"Fast, SIMD-accelerated CRC32 (IEEE) checksum computation\"\nkeywords = [\"checksum\", \"crc\", \"crc32\", \"simd\", \"fast\"]\nlicense = \"MIT OR Apache-2.0\"\nname = \"crc32fast\"\nreadme = \"README.md\"\nrepository = \"https://github.com/srijs/rust-crc32fast\"\nversion = \"1.2.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".crossbeam-channel."0.3.9" = mkRustCrate {
    inherit release profiles;
    name = "crossbeam-channel";
    version = "0.3.9";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "crossbeam-channel";
      version = "0.3.9";
      sha256 = "c8ec7fcd21571dc78f96cc96243cab8d8f035247c3efd16c687be154c3fa9efa";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      crossbeam_utils = rustPackages."registry+https://github.com/rust-lang/crates.io-index".crossbeam-utils."0.6.6" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"The Crossbeam Project Developers\"]\ncategories = [\"algorithms\", \"concurrency\", \"data-structures\"]\ndescription = \"Multi-producer multi-consumer channels for message passing\"\ndocumentation = \"https://docs.rs/crossbeam-channel\"\nhomepage = \"https://github.com/crossbeam-rs/crossbeam/tree/master/crossbeam-channel\"\nkeywords = [\"channel\", \"mpmc\", \"select\", \"golang\", \"message\"]\nlicense = \"MIT/Apache-2.0 AND BSD-2-Clause\"\nname = \"crossbeam-channel\"\nreadme = \"README.md\"\nrepository = \"https://github.com/crossbeam-rs/crossbeam\"\nversion = \"0.3.9\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".crossbeam-utils."0.6.6" = mkRustCrate {
    inherit release profiles;
    name = "crossbeam-utils";
    version = "0.6.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "crossbeam-utils";
      version = "0.6.6";
      sha256 = "04973fa96e96579258a5091af6003abde64af786b860f18622b82e026cca60e6";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "lazy_static" ]
      [ "std" ]
    ];
    dependencies = {
      cfg_if = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { };
      lazy_static = rustPackages."registry+https://github.com/rust-lang/crates.io-index".lazy_static."1.4.0" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"The Crossbeam Project Developers\"]\ncategories = [\"algorithms\", \"concurrency\", \"data-structures\", \"no-std\"]\ndescription = \"Utilities for concurrent programming\"\ndocumentation = \"https://docs.rs/crossbeam-utils\"\nhomepage = \"https://github.com/crossbeam-rs/crossbeam/tree/master/crossbeam-utils\"\nkeywords = [\"scoped\", \"thread\", \"atomic\", \"cache\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"crossbeam-utils\"\nreadme = \"README.md\"\nrepository = \"https://github.com/crossbeam-rs/crossbeam\"\nversion = \"0.6.6\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".crypto-hash."0.3.4" = mkRustCrate {
    inherit release profiles;
    name = "crypto-hash";
    version = "0.3.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "crypto-hash";
      version = "0.3.4";
      sha256 = "8a77162240fd97248d19a564a565eb563a3f592b386e4136fb300909e67dddca";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.parsed.kernel.name == "darwin" || hostPlatform.parsed.kernel.name == "ios" then "commoncrypto" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".commoncrypto."0.2.0" { };
      hex = rustPackages."registry+https://github.com/rust-lang/crates.io-index".hex."0.3.2" { };
      ${ if !(hostPlatform.parsed.kernel.name == "windows" || hostPlatform.parsed.kernel.name == "darwin" || hostPlatform.parsed.kernel.name == "ios") then "openssl" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".openssl."0.10.25" { };
      ${ if hostPlatform.parsed.kernel.name == "windows" then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Mark Lee\"]\ndescription = \"A wrapper for OS-level cryptographic hash functions\"\ndocumentation = \"https://docs.rs/crypto-hash\"\nexclude = [\".*.yml\", \"ci/*\"]\nkeywords = [\"crypto\", \"hash\", \"digest\"]\nlicense = \"MIT\"\nname = \"crypto-hash\"\nreadme = \"README.md\"\nrepository = \"https://github.com/malept/crypto-hash\"\nversion = \"0.3.4\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".curl."0.4.25" = mkRustCrate {
    inherit release profiles;
    name = "curl";
    version = "0.4.25";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "curl";
      version = "0.4.25";
      sha256 = "06aa71e9208a54def20792d877bc663d6aae0732b9852e612c4a933177c31283";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "http2" ]
      [ "openssl-probe" ]
      [ "openssl-sys" ]
      [ "ssl" ]
    ];
    dependencies = {
      curl_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".curl-sys."0.4.23" { };
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
      ${ if hostPlatform.isUnix && !(hostPlatform.parsed.kernel.name == "darwin") then "openssl_probe" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".openssl-probe."0.1.2" { };
      ${ if hostPlatform.isUnix && !(hostPlatform.parsed.kernel.name == "darwin") then "openssl_sys" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".openssl-sys."0.9.52" { };
      ${ if hostPlatform.parsed.abi.name == "msvc" then "schannel" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".schannel."0.1.16" { };
      socket2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".socket2."0.3.11" { };
      ${ if hostPlatform.parsed.abi.name == "msvc" then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[[test]]\nharness = false\nname = \"atexit\"\n\n[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\nautotests = true\ncategories = [\"api-bindings\", \"web-programming::http-client\"]\ndescription = \"Rust bindings to libcurl for making HTTP requests\"\ndocumentation = \"https://docs.rs/curl\"\nhomepage = \"https://github.com/alexcrichton/curl-rust\"\nlicense = \"MIT\"\nname = \"curl\"\nrepository = \"https://github.com/alexcrichton/curl-rust\"\nversion = \"0.4.25\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".curl-sys."0.4.23" = mkRustCrate {
    inherit release profiles;
    name = "curl-sys";
    version = "0.4.23";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "curl-sys";
      version = "0.4.23";
      sha256 = "f71cd2dbddb49c744c1c9e0b96106f50a634e8759ec51bcd5399a578700a3ab3";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "http2" ]
      [ "libnghttp2-sys" ]
      [ "openssl-sys" ]
      [ "ssl" ]
    ];
    dependencies = {
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
      libnghttp2_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libnghttp2-sys."0.1.2" { };
      libz_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libz-sys."1.0.25" { };
      ${ if hostPlatform.isUnix && !(hostPlatform.parsed.kernel.name == "darwin") then "openssl_sys" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".openssl-sys."0.9.52" { };
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
      cc = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".cc."1.0.46" { };
      pkg_config = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".pkg-config."0.3.16" { };
      ${ if hostPlatform.parsed.abi.name == "msvc" then "vcpkg" else null } = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".vcpkg."0.2.7" { };
    };
    manifest = builtins.fromTOML "[lib]\nname = \"curl_sys\"\npath = \"lib.rs\"\n\n[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\nbuild = \"build.rs\"\ncategories = [\"external-ffi-bindings\"]\ndescription = \"Native bindings to the libcurl library\"\ndocumentation = \"https://docs.rs/curl-sys\"\nlicense = \"MIT\"\nlinks = \"curl\"\nname = \"curl-sys\"\nrepository = \"https://github.com/alexcrichton/curl-rust\"\nversion = \"0.4.23\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".env_logger."0.6.2" = mkRustCrate {
    inherit release profiles;
    name = "env_logger";
    version = "0.6.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "env_logger";
      version = "0.6.2";
      sha256 = "aafcde04e90a5226a6443b7aabdb016ba2f8307c847d524724bd9b346dd1a2d3";
    };
    features = builtins.concatLists [
      [ "atty" ]
      [ "default" ]
      [ "humantime" ]
      [ "regex" ]
      [ "termcolor" ]
    ];
    dependencies = {
      atty = rustPackages."registry+https://github.com/rust-lang/crates.io-index".atty."0.2.13" { };
      humantime = rustPackages."registry+https://github.com/rust-lang/crates.io-index".humantime."1.3.0" { };
      log = rustPackages."registry+https://github.com/rust-lang/crates.io-index".log."0.4.8" { };
      regex = rustPackages."registry+https://github.com/rust-lang/crates.io-index".regex."1.3.1" { };
      termcolor = rustPackages."registry+https://github.com/rust-lang/crates.io-index".termcolor."1.0.5" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[[test]]\nharness = false\nname = \"regexp_filter\"\n\n[[test]]\nharness = false\nname = \"log-in-log\"\n\n[[test]]\nharness = false\nname = \"init-twice-retains-filter\"\n\n[package]\nauthors = [\"The Rust Project Developers\"]\ncategories = [\"development-tools::debugging\"]\ndescription = \"A logging implementation for `log` which is configured via an environment\\nvariable.\\n\"\ndocumentation = \"https://docs.rs/env_logger\"\nkeywords = [\"logging\", \"log\", \"logger\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"env_logger\"\nreadme = \"README.md\"\nrepository = \"https://github.com/sebasmagri/env_logger/\"\nversion = \"0.6.2\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".failure."0.1.6" = mkRustCrate {
    inherit release profiles;
    name = "failure";
    version = "0.1.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "failure";
      version = "0.1.6";
      sha256 = "f8273f13c977665c5db7eb2b99ae520952fe5ac831ae4cd09d80c4c7042b5ed9";
    };
    features = builtins.concatLists [
      [ "backtrace" ]
      [ "default" ]
      [ "derive" ]
      [ "failure_derive" ]
      [ "std" ]
    ];
    dependencies = {
      backtrace = rustPackages."registry+https://github.com/rust-lang/crates.io-index".backtrace."0.3.40" { };
      failure_derive = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".failure_derive."0.1.6" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Without Boats <boats@mozilla.com>\"]\ndescription = \"Experimental error handling abstraction.\"\ndocumentation = \"https://docs.rs/failure\"\nhomepage = \"https://rust-lang-nursery.github.io/failure/\"\nlicense = \"MIT OR Apache-2.0\"\nname = \"failure\"\nrepository = \"https://github.com/rust-lang-nursery/failure\"\nversion = \"0.1.6\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".failure_derive."0.1.6" = mkRustCrate {
    inherit release profiles;
    name = "failure_derive";
    version = "0.1.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "failure_derive";
      version = "0.1.6";
      sha256 = "0bc225b78e0391e4b8683440bf2e63c2deeeb2ce5189eab46e2b68c6d3725d08";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      proc_macro2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".proc-macro2."1.0.5" { };
      quote = rustPackages."registry+https://github.com/rust-lang/crates.io-index".quote."1.0.2" { };
      syn = rustPackages."registry+https://github.com/rust-lang/crates.io-index".syn."1.0.5" { };
      synstructure = rustPackages."registry+https://github.com/rust-lang/crates.io-index".synstructure."0.12.1" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nproc-macro = true\n\n[package]\nauthors = [\"Without Boats <woboats@gmail.com>\"]\nbuild = \"build.rs\"\ndescription = \"derives for the failure crate\"\ndocumentation = \"https://docs.rs/failure\"\nhomepage = \"https://rust-lang-nursery.github.io/failure/\"\nlicense = \"MIT OR Apache-2.0\"\nname = \"failure_derive\"\nrepository = \"https://github.com/withoutboats/failure_derive\"\nversion = \"0.1.6\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".filetime."0.2.7" = mkRustCrate {
    inherit release profiles;
    name = "filetime";
    version = "0.2.7";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "filetime";
      version = "0.2.7";
      sha256 = "6bd7380b54ced79dda72ecc35cc4fbbd1da6bba54afaa37e96fd1c2a308cd469";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      cfg_if = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { };
      ${ if hostPlatform.isUnix then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
      ${ if hostPlatform.parsed.kernel.name == "redox" then "syscall" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".redox_syscall."0.1.56" { };
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\ndescription = \"Platform-agnostic accessors of timestamps in File metadata\\n\"\ndocumentation = \"https://docs.rs/filetime\"\nedition = \"2018\"\nhomepage = \"https://github.com/alexcrichton/filetime\"\nkeywords = [\"timestamp\", \"mtime\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"filetime\"\nreadme = \"README.md\"\nrepository = \"https://github.com/alexcrichton/filetime\"\nversion = \"0.2.7\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".flate2."1.0.12" = mkRustCrate {
    inherit release profiles;
    name = "flate2";
    version = "1.0.12";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "flate2";
      version = "1.0.12";
      sha256 = "ad3c5233c9a940c8719031b423d7e6c16af66e031cb0420b0896f5245bf181d3";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "libz-sys" ]
      [ "miniz_oxide" ]
      [ "rust_backend" ]
      [ "zlib" ]
    ];
    dependencies = {
      cfg_if = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { };
      crc32fast = rustPackages."registry+https://github.com/rust-lang/crates.io-index".crc32fast."1.2.0" { };
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
      libz_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libz-sys."1.0.25" { };
      miniz_oxide = rustPackages."registry+https://github.com/rust-lang/crates.io-index".miniz_oxide."0.3.3" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\ncategories = [\"compression\", \"api-bindings\"]\ndescription = \"Bindings to miniz.c for DEFLATE compression and decompression exposed as\\nReader/Writer streams. Contains bindings for zlib, deflate, and gzip-based\\nstreams.\\n\"\ndocumentation = \"https://docs.rs/flate2\"\nedition = \"2018\"\nhomepage = \"https://github.com/alexcrichton/flate2-rs\"\nkeywords = [\"gzip\", \"flate\", \"zlib\", \"encoding\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"flate2\"\nreadme = \"README.md\"\nrepository = \"https://github.com/alexcrichton/flate2-rs\"\nversion = \"1.0.12\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".fnv."1.0.6" = mkRustCrate {
    inherit release profiles;
    name = "fnv";
    version = "1.0.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "fnv";
      version = "1.0.6";
      sha256 = "2fad85553e09a6f881f739c29f0b00b0f01357c743266d478b68951ce23285f3";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nname = \"fnv\"\npath = \"lib.rs\"\n\n[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\ndescription = \"Fowler–Noll–Vo hash function\"\ndocumentation = \"https://doc.servo.org/fnv/\"\nlicense = \"Apache-2.0 / MIT\"\nname = \"fnv\"\nreadme = \"README.md\"\nrepository = \"https://github.com/servo/rust-fnv\"\nversion = \"1.0.6\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".foreign-types."0.3.2" = mkRustCrate {
    inherit release profiles;
    name = "foreign-types";
    version = "0.3.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "foreign-types";
      version = "0.3.2";
      sha256 = "f6f339eb8adc052cd2ca78910fda869aefa38d22d5cb648e6485e4d3fc06f3b1";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      foreign_types_shared = rustPackages."registry+https://github.com/rust-lang/crates.io-index".foreign-types-shared."0.1.1" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Steven Fackler <sfackler@gmail.com>\"]\ndescription = \"A framework for Rust wrappers over C APIs\"\nlicense = \"MIT/Apache-2.0\"\nname = \"foreign-types\"\nreadme = \"README.md\"\nrepository = \"https://github.com/sfackler/foreign-types\"\nversion = \"0.3.2\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".foreign-types-shared."0.1.1" = mkRustCrate {
    inherit release profiles;
    name = "foreign-types-shared";
    version = "0.1.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "foreign-types-shared";
      version = "0.1.1";
      sha256 = "00b0228411908ca8685dba7fc2cdd70ec9990a6e753e89b6ac91a84c40fbaf4b";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Steven Fackler <sfackler@gmail.com>\"]\ndescription = \"An internal crate used by foreign-types\"\nlicense = \"MIT/Apache-2.0\"\nname = \"foreign-types-shared\"\nrepository = \"https://github.com/sfackler/foreign-types\"\nversion = \"0.1.1\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".fs2."0.4.3" = mkRustCrate {
    inherit release profiles;
    name = "fs2";
    version = "0.4.3";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "fs2";
      version = "0.4.3";
      sha256 = "9564fc758e15025b46aa6643b1b77d047d1a56a1aea6e01002ac0c7026876213";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isUnix then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Dan Burkert <dan@danburkert.com>\"]\ndescription = \"Cross-platform file locks and file duplication.\"\ndocumentation = \"https://docs.rs/fs2\"\nkeywords = [\"file\", \"file-system\", \"lock\", \"duplicate\", \"flock\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"fs2\"\nrepository = \"https://github.com/danburkert/fs2-rs\"\nversion = \"0.4.3\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".fwdansi."1.0.1" = mkRustCrate {
    inherit release profiles;
    name = "fwdansi";
    version = "1.0.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "fwdansi";
      version = "1.0.1";
      sha256 = "34dd4c507af68d37ffef962063dfa1944ce0dd4d5b82043dbab1dabe088610c3";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      memchr = rustPackages."registry+https://github.com/rust-lang/crates.io-index".memchr."2.2.1" { };
      termcolor = rustPackages."registry+https://github.com/rust-lang/crates.io-index".termcolor."1.0.5" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"kennytm <kennytm@gmail.com>\"]\ncategories = [\"command-line-interface\"]\ndescription = \"Forwards a byte string with ANSI escape code to a termcolor terminal\"\nkeywords = [\"ansi\", \"windows\", \"console\", \"terminal\", \"color\"]\nlicense = \"MIT\"\nname = \"fwdansi\"\nrepository = \"https://github.com/kennytm/fwdansi\"\nversion = \"1.0.1\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".getrandom."0.1.12" = mkRustCrate {
    inherit release profiles;
    name = "getrandom";
    version = "0.1.12";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "getrandom";
      version = "0.1.12";
      sha256 = "473a1265acc8ff1e808cd0a1af8cee3c2ee5200916058a2ca113c29f2d903571";
    };
    features = builtins.concatLists [
      [ "std" ]
    ];
    dependencies = {
      cfg_if = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { };
      ${ if hostPlatform.isUnix || hostPlatform.parsed.kernel.name == "redox" then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
      ${ if hostPlatform.parsed.kernel.name == "wasi" then "wasi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".wasi."0.7.0" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"The Rand Project Developers\"]\ncategories = [\"os\", \"no-std\"]\ndescription = \"A small cross-platform library for retrieving random data from system source\"\ndocumentation = \"https://docs.rs/getrandom\"\nedition = \"2018\"\nexclude = [\"utils/*\", \".*\", \"appveyor.yml\"]\nlicense = \"MIT OR Apache-2.0\"\nname = \"getrandom\"\nrepository = \"https://github.com/rust-random/getrandom\"\nversion = \"0.1.12\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".git2."0.9.2" = mkRustCrate {
    inherit release profiles;
    name = "git2";
    version = "0.9.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "git2";
      version = "0.9.2";
      sha256 = "8cb400360e8a4d61b10e648285bbfa919bbf9519d0d5d5720354456f44349226";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "https" ]
      [ "openssl-probe" ]
      [ "openssl-sys" ]
      [ "ssh" ]
      [ "ssh_key_from_memory" ]
    ];
    dependencies = {
      bitflags = rustPackages."registry+https://github.com/rust-lang/crates.io-index".bitflags."1.2.1" { };
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
      libgit2_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libgit2-sys."0.8.2" { };
      log = rustPackages."registry+https://github.com/rust-lang/crates.io-index".log."0.4.8" { };
      ${ if hostPlatform.isUnix && !(hostPlatform.parsed.kernel.name == "darwin") then "openssl_probe" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".openssl-probe."0.1.2" { };
      ${ if hostPlatform.isUnix && !(hostPlatform.parsed.kernel.name == "darwin") then "openssl_sys" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".openssl-sys."0.9.52" { };
      url = rustPackages."registry+https://github.com/rust-lang/crates.io-index".url."2.1.0" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Josh Triplett <josh@joshtriplett.org>\", \"Alex Crichton <alex@alexcrichton.com>\"]\ncategories = [\"api-bindings\"]\ndescription = \"Bindings to libgit2 for interoperating with git repositories. This library is\\nboth threadsafe and memory safe and allows both reading and writing git\\nrepositories.\\n\"\ndocumentation = \"https://docs.rs/git2\"\nedition = \"2018\"\nkeywords = [\"git\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"git2\"\nreadme = \"README.md\"\nrepository = \"https://github.com/rust-lang/git2-rs\"\nversion = \"0.9.2\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".git2-curl."0.10.1" = mkRustCrate {
    inherit release profiles;
    name = "git2-curl";
    version = "0.10.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "git2-curl";
      version = "0.10.1";
      sha256 = "2293de73491c3dc4174c5949ef53d2cc037b27613f88d72032e3f5237247a7dd";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      curl = rustPackages."registry+https://github.com/rust-lang/crates.io-index".curl."0.4.25" { };
      git2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".git2."0.9.2" { };
      log = rustPackages."registry+https://github.com/rust-lang/crates.io-index".log."0.4.8" { };
      url = rustPackages."registry+https://github.com/rust-lang/crates.io-index".url."2.1.0" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[[test]]\nharness = false\nname = \"all\"\n\n[package]\nauthors = [\"Josh Triplett <josh@joshtriplett.org>\", \"Alex Crichton <alex@alexcrichton.com>\"]\ndescription = \"Backend for an HTTP transport in libgit2 powered by libcurl.\\n\\nIntended to be used with the git2 crate.\\n\"\ndocumentation = \"https://docs.rs/git2-curl\"\nedition = \"2018\"\nlicense = \"MIT/Apache-2.0\"\nname = \"git2-curl\"\nrepository = \"https://github.com/rust-lang/git2-rs\"\nversion = \"0.10.1\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".glob."0.3.0" = mkRustCrate {
    inherit release profiles;
    name = "glob";
    version = "0.3.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "glob";
      version = "0.3.0";
      sha256 = "9b919933a397b79c37e33b77bb2aa3dc8eb6e165ad809e58ff75bc7db2e34574";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"The Rust Project Developers\"]\ncategories = [\"filesystem\"]\ndescription = \"Support for matching file paths against Unix shell style patterns.\\n\"\ndocumentation = \"https://docs.rs/glob/0.3.0\"\nhomepage = \"https://github.com/rust-lang/glob\"\nlicense = \"MIT/Apache-2.0\"\nname = \"glob\"\nrepository = \"https://github.com/rust-lang/glob\"\nversion = \"0.3.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".globset."0.4.4" = mkRustCrate {
    inherit release profiles;
    name = "globset";
    version = "0.4.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "globset";
      version = "0.4.4";
      sha256 = "925aa2cac82d8834e2b2a4415b6f6879757fb5c0928fc445ae76461a12eed8f2";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      aho_corasick = rustPackages."registry+https://github.com/rust-lang/crates.io-index".aho-corasick."0.7.6" { };
      bstr = rustPackages."registry+https://github.com/rust-lang/crates.io-index".bstr."0.2.8" { };
      fnv = rustPackages."registry+https://github.com/rust-lang/crates.io-index".fnv."1.0.6" { };
      log = rustPackages."registry+https://github.com/rust-lang/crates.io-index".log."0.4.8" { };
      regex = rustPackages."registry+https://github.com/rust-lang/crates.io-index".regex."1.3.1" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nbench = false\nname = \"globset\"\n\n[package]\nauthors = [\"Andrew Gallant <jamslam@gmail.com>\"]\ndescription = \"Cross platform single glob and glob set matching. Glob set matching is the\\nprocess of matching one or more glob patterns against a single candidate path\\nsimultaneously, and returning all of the globs that matched.\\n\"\ndocumentation = \"https://docs.rs/globset\"\nhomepage = \"https://github.com/BurntSushi/ripgrep/tree/master/globset\"\nkeywords = [\"regex\", \"glob\", \"multiple\", \"set\", \"pattern\"]\nlicense = \"Unlicense/MIT\"\nname = \"globset\"\nreadme = \"README.md\"\nrepository = \"https://github.com/BurntSushi/ripgrep/tree/master/globset\"\nversion = \"0.4.4\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".hex."0.3.2" = mkRustCrate {
    inherit release profiles;
    name = "hex";
    version = "0.3.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "hex";
      version = "0.3.2";
      sha256 = "805026a5d0141ffc30abb3be3173848ad46a1b1664fe632428479619a3644d77";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"KokaKiwi <kokakiwi@kokakiwi.net>\"]\ndescription = \"Encoding and decoding data into/from hexadecimal representation.\"\ndocumentation = \"https://docs.rs/hex/\"\nlicense = \"MIT OR Apache-2.0\"\nname = \"hex\"\nrepository = \"https://github.com/KokaKiwi/rust-hex\"\nversion = \"0.3.2\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".home."0.3.4" = mkRustCrate {
    inherit release profiles;
    name = "home";
    version = "0.3.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "home";
      version = "0.3.4";
      sha256 = "29302b90cfa76231a757a887d1e3153331a63c7f80b6c75f86366334cbe70708";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isWindows then "scopeguard" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".scopeguard."0.3.3" { };
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Brian Anderson <andersrb@gmail.com>\"]\ndescription = \"Shared definitions of home directories\"\ndocumentation = \"https://docs.rs/home\"\nlicense = \"MIT/Apache-2.0\"\nname = \"home\"\nrepository = \"https://github.com/brson/home\"\nversion = \"0.3.4\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".http."0.1.19" = mkRustCrate {
    inherit release profiles;
    name = "http";
    version = "0.1.19";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "http";
      version = "0.1.19";
      sha256 = "d7e06e336150b178206af098a055e3621e8336027e2b4d126bda0bc64824baaf";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      bytes = rustPackages."registry+https://github.com/rust-lang/crates.io-index".bytes."0.4.12" { };
      fnv = rustPackages."registry+https://github.com/rust-lang/crates.io-index".fnv."1.0.6" { };
      itoa = rustPackages."registry+https://github.com/rust-lang/crates.io-index".itoa."0.4.4" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[[bench]]\nname = \"header_map\"\npath = \"benches/header_map/mod.rs\"\n\n[[bench]]\nname = \"header_name\"\npath = \"benches/header_name.rs\"\n\n[[bench]]\nname = \"header_value\"\npath = \"benches/header_value.rs\"\n\n[[bench]]\nname = \"uri\"\npath = \"benches/uri.rs\"\n\n[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\", \"Carl Lerche <me@carllerche.com>\", \"Sean McArthur <sean@seanmonstar.com>\"]\ncategories = [\"web-programming\"]\ndescription = \"A set of types for representing HTTP requests and responses.\\n\"\ndocumentation = \"https://docs.rs/http\"\nkeywords = [\"http\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"http\"\nreadme = \"README.md\"\nrepository = \"https://github.com/hyperium/http\"\nversion = \"0.1.19\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".humantime."1.3.0" = mkRustCrate {
    inherit release profiles;
    name = "humantime";
    version = "1.3.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "humantime";
      version = "1.3.0";
      sha256 = "df004cfca50ef23c36850aaaa59ad52cc70d0e90243c3c7737a4dd32dc7a3c4f";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      quick_error = rustPackages."registry+https://github.com/rust-lang/crates.io-index".quick-error."1.2.2" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nname = \"humantime\"\npath = \"src/lib.rs\"\n\n[package]\nauthors = [\"Paul Colomiets <paul@colomiets.name>\"]\ncategories = [\"date-and-time\"]\ndescription = \"    A parser and formatter for std::time::{Duration, SystemTime}\\n\"\ndocumentation = \"https://docs.rs/humantime\"\nhomepage = \"https://github.com/tailhook/humantime\"\nkeywords = [\"time\", \"human\", \"human-friendly\", \"parser\", \"duration\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"humantime\"\nreadme = \"README.md\"\nversion = \"1.3.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".idna."0.1.5" = mkRustCrate {
    inherit release profiles;
    name = "idna";
    version = "0.1.5";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "idna";
      version = "0.1.5";
      sha256 = "38f09e0f0b1fb55fdee1f17470ad800da77af5186a1a76c026b679358b7e844e";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      matches = rustPackages."registry+https://github.com/rust-lang/crates.io-index".matches."0.1.8" { };
      unicode_bidi = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-bidi."0.3.4" { };
      unicode_normalization = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-normalization."0.1.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[[test]]\nharness = false\nname = \"tests\"\n\n[[test]]\nname = \"unit\"\n\n[lib]\ndoctest = false\ntest = false\n\n[package]\nauthors = [\"The rust-url developers\"]\ndescription = \"IDNA (Internationalizing Domain Names in Applications) and Punycode.\"\nlicense = \"MIT/Apache-2.0\"\nname = \"idna\"\nrepository = \"https://github.com/servo/rust-url/\"\nversion = \"0.1.5\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".idna."0.2.0" = mkRustCrate {
    inherit release profiles;
    name = "idna";
    version = "0.2.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "idna";
      version = "0.2.0";
      sha256 = "02e2673c30ee86b5b96a9cb52ad15718aa1f966f5ab9ad54a8b95d5ca33120a9";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      matches = rustPackages."registry+https://github.com/rust-lang/crates.io-index".matches."0.1.8" { };
      unicode_bidi = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-bidi."0.3.4" { };
      unicode_normalization = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-normalization."0.1.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[[test]]\nharness = false\nname = \"tests\"\n\n[[test]]\nname = \"unit\"\n\n[lib]\ndoctest = false\ntest = false\n\n[package]\nauthors = [\"The rust-url developers\"]\nautotests = false\ndescription = \"IDNA (Internationalizing Domain Names in Applications) and Punycode.\"\nlicense = \"MIT/Apache-2.0\"\nname = \"idna\"\nrepository = \"https://github.com/servo/rust-url/\"\nversion = \"0.2.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".ignore."0.4.10" = mkRustCrate {
    inherit release profiles;
    name = "ignore";
    version = "0.4.10";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "ignore";
      version = "0.4.10";
      sha256 = "0ec16832258409d571aaef8273f3c3cc5b060d784e159d1a0f3b0017308f84a7";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      crossbeam_channel = rustPackages."registry+https://github.com/rust-lang/crates.io-index".crossbeam-channel."0.3.9" { };
      globset = rustPackages."registry+https://github.com/rust-lang/crates.io-index".globset."0.4.4" { };
      lazy_static = rustPackages."registry+https://github.com/rust-lang/crates.io-index".lazy_static."1.4.0" { };
      log = rustPackages."registry+https://github.com/rust-lang/crates.io-index".log."0.4.8" { };
      memchr = rustPackages."registry+https://github.com/rust-lang/crates.io-index".memchr."2.2.1" { };
      regex = rustPackages."registry+https://github.com/rust-lang/crates.io-index".regex."1.3.1" { };
      same_file = rustPackages."registry+https://github.com/rust-lang/crates.io-index".same-file."1.0.5" { };
      thread_local = rustPackages."registry+https://github.com/rust-lang/crates.io-index".thread_local."0.3.6" { };
      walkdir = rustPackages."registry+https://github.com/rust-lang/crates.io-index".walkdir."2.2.9" { };
      ${ if hostPlatform.isWindows then "winapi_util" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi-util."0.1.2" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nbench = false\nname = \"ignore\"\n\n[package]\nauthors = [\"Andrew Gallant <jamslam@gmail.com>\"]\ndescription = \"A fast library for efficiently matching ignore files such as `.gitignore`\\nagainst file paths.\\n\"\ndocumentation = \"https://docs.rs/ignore\"\nhomepage = \"https://github.com/BurntSushi/ripgrep/tree/master/ignore\"\nkeywords = [\"glob\", \"ignore\", \"gitignore\", \"pattern\", \"file\"]\nlicense = \"Unlicense/MIT\"\nname = \"ignore\"\nreadme = \"README.md\"\nrepository = \"https://github.com/BurntSushi/ripgrep/tree/master/ignore\"\nversion = \"0.4.10\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".im-rc."13.0.0" = mkRustCrate {
    inherit release profiles;
    name = "im-rc";
    version = "13.0.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "im-rc";
      version = "13.0.0";
      sha256 = "0a0197597d095c0d11107975d3175173f810ee572c2501ff4de64f4f3f119806";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      sized_chunks = rustPackages."registry+https://github.com/rust-lang/crates.io-index".sized-chunks."0.3.1" { };
      typenum = rustPackages."registry+https://github.com/rust-lang/crates.io-index".typenum."1.11.2" { };
    };
    devDependencies = {
    };
    buildDependencies = {
      rustc_version = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".rustc_version."0.2.3" { };
    };
    manifest = builtins.fromTOML "[lib]\npath = \"./src/lib.rs\"\n\n[package]\nauthors = [\"Bodil Stokke <bodil@bodil.org>\"]\nbuild = \"./build.rs\"\ncategories = [\"data-structures\"]\ndescription = \"Immutable collection datatypes (the fast but not thread safe version)\"\ndocumentation = \"http://immutable.rs/\"\nedition = \"2018\"\nhomepage = \"http://immutable.rs/\"\nkeywords = [\"immutable\", \"persistent\", \"hamt\", \"b-tree\", \"rrb-tree\"]\nlicense = \"MPL-2.0+\"\nname = \"im-rc\"\nreadme = \"../../README.md\"\nrepository = \"https://github.com/bodil/im-rs\"\nversion = \"13.0.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".iovec."0.1.4" = mkRustCrate {
    inherit release profiles;
    name = "iovec";
    version = "0.1.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "iovec";
      version = "0.1.4";
      sha256 = "b2b3ea6ff95e175473f8ffe6a7eb7c00d054240321b84c57051175fe3c1e075e";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isUnix then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Carl Lerche <me@carllerche.com>\"]\ncategories = [\"network-programming\", \"api-bindings\"]\ndescription = \"Portable buffer type for scatter/gather I/O operations\\n\"\ndocumentation = \"https://docs.rs/iovec\"\nhomepage = \"https://github.com/carllerche/iovec\"\nkeywords = [\"scatter\", \"gather\", \"vectored\", \"io\", \"networking\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"iovec\"\nreadme = \"README.md\"\nrepository = \"https://github.com/carllerche/iovec\"\nversion = \"0.1.4\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".itoa."0.4.4" = mkRustCrate {
    inherit release profiles;
    name = "itoa";
    version = "0.4.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "itoa";
      version = "0.4.4";
      sha256 = "501266b7edd0174f8530248f87f99c88fbe60ca4ef3dd486835b8d8d53136f7f";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"David Tolnay <dtolnay@gmail.com>\"]\ncategories = [\"value-formatting\"]\ndescription = \"Fast functions for printing integer primitives to an io::Write\"\ndocumentation = \"https://github.com/dtolnay/itoa\"\nexclude = [\"performance.png\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"itoa\"\nreadme = \"README.md\"\nrepository = \"https://github.com/dtolnay/itoa\"\nversion = \"0.4.4\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".jobserver."0.1.17" = mkRustCrate {
    inherit release profiles;
    name = "jobserver";
    version = "0.1.17";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "jobserver";
      version = "0.1.17";
      sha256 = "f2b1d42ef453b30b7387e113da1c83ab1605d90c5b4e0eb8e96d016ed3b8c160";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isWindows then "getrandom" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".getrandom."0.1.12" { };
      ${ if hostPlatform.isUnix then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
      log = rustPackages."registry+https://github.com/rust-lang/crates.io-index".log."0.4.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[[test]]\nharness = false\nname = \"client\"\npath = \"tests/client.rs\"\n\n[[test]]\nname = \"server\"\npath = \"tests/server.rs\"\n\n[[test]]\nharness = false\nname = \"client-of-myself\"\npath = \"tests/client-of-myself.rs\"\n\n[[test]]\nharness = false\nname = \"make-as-a-client\"\npath = \"tests/make-as-a-client.rs\"\n\n[[test]]\nname = \"helper\"\npath = \"tests/helper.rs\"\n\n[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\ndescription = \"An implementation of the GNU make jobserver for Rust\\n\"\ndocumentation = \"https://docs.rs/jobserver\"\nhomepage = \"https://github.com/alexcrichton/jobserver-rs\"\nlicense = \"MIT/Apache-2.0\"\nname = \"jobserver\"\nrepository = \"https://github.com/alexcrichton/jobserver-rs\"\nversion = \"0.1.17\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".lazy_static."1.4.0" = mkRustCrate {
    inherit release profiles;
    name = "lazy_static";
    version = "1.4.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "lazy_static";
      version = "1.4.0";
      sha256 = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Marvin Löbel <loebel.marvin@gmail.com>\"]\ncategories = [\"no-std\", \"rust-patterns\", \"memory-management\"]\ndescription = \"A macro for declaring lazily evaluated statics in Rust.\"\ndocumentation = \"https://docs.rs/lazy_static\"\nexclude = [\"/.travis.yml\", \"/appveyor.yml\"]\nkeywords = [\"macro\", \"lazy\", \"static\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"lazy_static\"\nreadme = \"README.md\"\nrepository = \"https://github.com/rust-lang-nursery/lazy-static.rs\"\nversion = \"1.4.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".lazycell."1.2.1" = mkRustCrate {
    inherit release profiles;
    name = "lazycell";
    version = "1.2.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "lazycell";
      version = "1.2.1";
      sha256 = "b294d6fa9ee409a054354afc4352b0b9ef7ca222c69b8812cbea9e7d2bf3783f";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\", \"Nikita Pekin <contact@nikitapek.in>\"]\ndescription = \"A library providing a lazily filled Cell struct\"\ndocumentation = \"http://indiv0.github.io/lazycell/lazycell/\"\ninclude = [\"CHANGELOG.md\", \"Cargo.toml\", \"LICENSE-MIT\", \"LICENSE-APACHE\", \"README.md\", \"src/**/*.rs\"]\nkeywords = [\"lazycell\", \"lazy\", \"cell\", \"library\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"lazycell\"\nreadme = \"README.md\"\nrepository = \"https://github.com/indiv0/lazycell\"\nversion = \"1.2.1\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" = mkRustCrate {
    inherit release profiles;
    name = "libc";
    version = "0.2.65";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "libc";
      version = "0.2.65";
      sha256 = "1a31a0627fdf1f6a39ec0dd577e101440b7db22672c0901fe00a9a6fbb5c24e8";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"The Rust Project Developers\"]\nbuild = \"build.rs\"\ncategories = [\"external-ffi-bindings\", \"no-std\", \"os\"]\ndescription = \"Raw FFI bindings to platform libraries like libc.\\n\"\ndocumentation = \"http://doc.rust-lang.org/libc\"\nexclude = [\"/ci/*\", \"/azure-pipelines.yml\"]\nhomepage = \"https://github.com/rust-lang/libc\"\nkeywords = [\"libc\", \"ffi\", \"bindings\", \"operating\", \"system\"]\nlicense = \"MIT OR Apache-2.0\"\nname = \"libc\"\nreadme = \"README.md\"\nrepository = \"https://github.com/rust-lang/libc\"\nversion = \"0.2.65\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".libgit2-sys."0.8.2" = mkRustCrate {
    inherit release profiles;
    name = "libgit2-sys";
    version = "0.8.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "libgit2-sys";
      version = "0.8.2";
      sha256 = "4c179ed6d19cd3a051e68c177fbbc214e79ac4724fac3a850ec9f3d3eb8a5578";
    };
    features = builtins.concatLists [
      [ "https" ]
      [ "libssh2-sys" ]
      [ "openssl-sys" ]
      [ "ssh" ]
      [ "ssh_key_from_memory" ]
    ];
    dependencies = {
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
      libssh2_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libssh2-sys."0.2.13" { };
      libz_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libz-sys."1.0.25" { };
      ${ if hostPlatform.isUnix then "openssl_sys" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".openssl-sys."0.9.52" { };
    };
    devDependencies = {
    };
    buildDependencies = {
      cc = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".cc."1.0.46" { };
      pkg_config = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".pkg-config."0.3.16" { };
    };
    manifest = builtins.fromTOML "[lib]\nname = \"libgit2_sys\"\npath = \"lib.rs\"\n\n[package]\nauthors = [\"Josh Triplett <josh@joshtriplett.org>\", \"Alex Crichton <alex@alexcrichton.com>\"]\nbuild = \"build.rs\"\ndescription = \"Native bindings to the libgit2 library\"\nedition = \"2018\"\nexclude = [\"libgit2/tests/*\"]\nlicense = \"MIT/Apache-2.0\"\nlinks = \"git2\"\nname = \"libgit2-sys\"\nrepository = \"https://github.com/rust-lang/git2-rs\"\nversion = \"0.8.2\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".libnghttp2-sys."0.1.2" = mkRustCrate {
    inherit release profiles;
    name = "libnghttp2-sys";
    version = "0.1.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "libnghttp2-sys";
      version = "0.1.2";
      sha256 = "02254d44f4435dd79e695f2c2b83cd06a47919adea30216ceaf0c57ca0a72463";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
    };
    devDependencies = {
    };
    buildDependencies = {
      cc = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".cc."1.0.46" { };
    };
    manifest = builtins.fromTOML "[lib]\ndoctest = false\n\n[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\ndescription = \"FFI bindings for libnghttp2 (nghttp2)\\n\"\nhomepage = \"https://github.com/alexcrichton/nghttp2-rs\"\nlicense = \"MIT/Apache-2.0\"\nlinks = \"nghttp2\"\nname = \"libnghttp2-sys\"\nreadme = \"README.md\"\nrepository = \"https://github.com/alexcrichton/nghttp2-rs\"\nversion = \"0.1.2\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".libssh2-sys."0.2.13" = mkRustCrate {
    inherit release profiles;
    name = "libssh2-sys";
    version = "0.2.13";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "libssh2-sys";
      version = "0.2.13";
      sha256 = "5fcd5a428a31cbbfe059812d74f4b6cd3b9b7426c2bdaec56993c5365da1c328";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
      libz_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libz-sys."1.0.25" { };
      ${ if hostPlatform.isUnix then "openssl_sys" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".openssl-sys."0.9.52" { };
    };
    devDependencies = {
    };
    buildDependencies = {
      cc = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".cc."1.0.46" { };
      pkg_config = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".pkg-config."0.3.16" { };
      ${ if hostPlatform.parsed.abi.name == "msvc" then "vcpkg" else null } = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".vcpkg."0.2.7" { };
    };
    manifest = builtins.fromTOML "[lib]\nname = \"libssh2_sys\"\npath = \"lib.rs\"\n\n[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\", \"Wez Furlong <wez@wezfurlong.org>\"]\nbuild = \"build.rs\"\ndescription = \"Native bindings to the libssh2 library\"\nlicense = \"MIT/Apache-2.0\"\nlinks = \"ssh2\"\nname = \"libssh2-sys\"\nrepository = \"https://github.com/alexcrichton/ssh2-rs\"\nversion = \"0.2.13\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".libz-sys."1.0.25" = mkRustCrate {
    inherit release profiles;
    name = "libz-sys";
    version = "1.0.25";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "libz-sys";
      version = "1.0.25";
      sha256 = "2eb5e43362e38e2bca2fd5f5134c4d4564a23a5c28e9b95411652021a8675ebe";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
    };
    devDependencies = {
    };
    buildDependencies = {
      cc = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".cc."1.0.46" { };
      pkg_config = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".pkg-config."0.3.16" { };
      ${ if hostPlatform.parsed.abi.name == "msvc" then "vcpkg" else null } = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".vcpkg."0.2.7" { };
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\nbuild = \"build.rs\"\ncategories = [\"external-ffi-bindings\"]\ndescription = \"Bindings to the system libz library (also known as zlib).\\n\"\ndocumentation = \"https://docs.rs/libz-sys\"\nlicense = \"MIT/Apache-2.0\"\nlinks = \"z\"\nname = \"libz-sys\"\nrepository = \"https://github.com/alexcrichton/libz-sys\"\nversion = \"1.0.25\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".log."0.4.8" = mkRustCrate {
    inherit release profiles;
    name = "log";
    version = "0.4.8";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "log";
      version = "0.4.8";
      sha256 = "14b6052be84e6b71ab17edffc2eeabf5c2c3ae1fdb464aae35ac50c67a44e1f7";
    };
    features = builtins.concatLists [
      [ "std" ]
    ];
    dependencies = {
      cfg_if = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[[test]]\nharness = false\nname = \"filters\"\n\n[package]\nauthors = [\"The Rust Project Developers\"]\nbuild = \"build.rs\"\ncategories = [\"development-tools::debugging\"]\ndescription = \"A lightweight logging facade for Rust\\n\"\ndocumentation = \"https://docs.rs/log\"\nexclude = [\"rfcs/**/*\", \"/.travis.yml\", \"/appveyor.yml\"]\nkeywords = [\"logging\"]\nlicense = \"MIT OR Apache-2.0\"\nname = \"log\"\nreadme = \"README.md\"\nrepository = \"https://github.com/rust-lang/log\"\nversion = \"0.4.8\"\n[package.metadata.docs.rs]\nfeatures = [\"std\", \"serde\", \"kv_unstable_sval\"]\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".matches."0.1.8" = mkRustCrate {
    inherit release profiles;
    name = "matches";
    version = "0.1.8";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "matches";
      version = "0.1.8";
      sha256 = "7ffc5c5338469d4d3ea17d269fa8ea3512ad247247c30bd2df69e68309ed0a08";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nname = \"matches\"\npath = \"lib.rs\"\n\n[package]\nauthors = [\"Simon Sapin <simon.sapin@exyr.org>\"]\ndescription = \"A macro to evaluate, as a boolean, whether an expression matches a pattern.\"\ndocumentation = \"https://docs.rs/matches/\"\nlicense = \"MIT\"\nname = \"matches\"\nrepository = \"https://github.com/SimonSapin/rust-std-candidates\"\nversion = \"0.1.8\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".memchr."2.2.1" = mkRustCrate {
    inherit release profiles;
    name = "memchr";
    version = "2.2.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "memchr";
      version = "2.2.1";
      sha256 = "88579771288728879b57485cc7d6b07d648c9f0141eb955f8ab7f9d45394468e";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "use_std" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nbench = false\nname = \"memchr\"\n\n[package]\nauthors = [\"Andrew Gallant <jamslam@gmail.com>\", \"bluss\"]\ndescription = \"Safe interface to memchr.\"\ndocumentation = \"https://docs.rs/memchr/\"\nexclude = [\"/ci/*\", \"/.travis.yml\", \"/Makefile\", \"/appveyor.yml\"]\nhomepage = \"https://github.com/BurntSushi/rust-memchr\"\nkeywords = [\"memchr\", \"char\", \"scan\", \"strchr\", \"string\"]\nlicense = \"Unlicense/MIT\"\nname = \"memchr\"\nreadme = \"README.md\"\nrepository = \"https://github.com/BurntSushi/rust-memchr\"\nversion = \"2.2.1\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".miniz_oxide."0.3.3" = mkRustCrate {
    inherit release profiles;
    name = "miniz_oxide";
    version = "0.3.3";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "miniz_oxide";
      version = "0.3.3";
      sha256 = "304f66c19be2afa56530fa7c39796192eef38618da8d19df725ad7c6d6b2aaae";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      adler32 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".adler32."1.0.4" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nname = \"miniz_oxide\"\n\n[package]\nauthors = [\"Frommi <daniil.liferenko@gmail.com>\", \"oyvindln <oyvindln@users.noreply.github.com>\"]\ncategories = [\"compression\"]\ndescription = \"DEFLATE compression and decompression library rewritten in Rust based on miniz\"\ndocumentation = \"https://docs.rs/miniz_oxide\"\nedition = \"2018\"\nhomepage = \"https://github.com/Frommi/miniz_oxide/tree/master/miniz_oxide\"\nkeywords = [\"zlib\", \"miniz\", \"deflate\", \"encoding\"]\nlicense = \"MIT\"\nname = \"miniz_oxide\"\nreadme = \"Readme.md\"\nrepository = \"https://github.com/Frommi/miniz_oxide/tree/master/miniz_oxide\"\nversion = \"0.3.3\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".miow."0.3.3" = mkRustCrate {
    inherit release profiles;
    name = "miow";
    version = "0.3.3";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "miow";
      version = "0.3.3";
      sha256 = "396aa0f2003d7df8395cb93e09871561ccc3e785f0acb369170e8cc74ddf9226";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      socket2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".socket2."0.3.11" { };
      winapi = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\ndescription = \"A zero overhead I/O library for Windows, focusing on IOCP and Async I/O\\nabstractions.\\n\"\ndocumentation = \"https://docs.rs/miow/0.3/x86_64-pc-windows-msvc/miow/\"\nhomepage = \"https://github.com/alexcrichton/miow\"\nkeywords = [\"iocp\", \"windows\", \"io\", \"overlapped\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"miow\"\nreadme = \"README.md\"\nrepository = \"https://github.com/alexcrichton/miow\"\nversion = \"0.3.3\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".num_cpus."1.10.1" = mkRustCrate {
    inherit release profiles;
    name = "num_cpus";
    version = "1.10.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "num_cpus";
      version = "1.10.1";
      sha256 = "bcef43580c035376c0705c42792c294b66974abbfd2789b511784023f71f3273";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Sean McArthur <sean@seanmonstar.com>\"]\ncategories = [\"hardware-support\"]\ndescription = \"Get the number of CPUs on a machine.\"\ndocumentation = \"https://docs.rs/num_cpus\"\nkeywords = [\"cpu\", \"cpus\", \"cores\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"num_cpus\"\nreadme = \"README.md\"\nrepository = \"https://github.com/seanmonstar/num_cpus\"\nversion = \"1.10.1\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".once_cell."1.2.0" = mkRustCrate {
    inherit release profiles;
    name = "once_cell";
    version = "1.2.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "once_cell";
      version = "1.2.0";
      sha256 = "891f486f630e5c5a4916c7e16c4b24a53e78c860b646e9f8e005e4f16847bfed";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[[example]]\nname = \"reentrant_init_deadlocks\"\nrequired-features = [\"std\"]\n\n[[example]]\nname = \"bench\"\nrequired-features = [\"std\"]\n\n[[example]]\nname = \"bench_vs_lazy_static\"\nrequired-features = [\"std\"]\n\n[[example]]\nname = \"lazy_static\"\nrequired-features = [\"std\"]\n\n[[example]]\nname = \"regex\"\nrequired-features = [\"std\"]\n\n[package]\nauthors = [\"Aleksey Kladov <aleksey.kladov@gmail.com>\"]\ncategories = [\"rust-patterns\", \"memory-management\"]\ndescription = \"Single assignment cells and lazy values.\"\ndocumentation = \"https://docs.rs/once_cell\"\nedition = \"2018\"\nexclude = [\"*.png\", \"*.svg\", \"/Cargo.lock.min\", \"/.travis.yml\", \"/run-miri-tests.sh\", \"rustfmt.toml\"]\nkeywords = [\"lazy\", \"static\"]\nlicense = \"MIT OR Apache-2.0\"\nname = \"once_cell\"\nreadme = \"README.md\"\nrepository = \"https://github.com/matklad/once_cell\"\nversion = \"1.2.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".opener."0.4.1" = mkRustCrate {
    inherit release profiles;
    name = "opener";
    version = "0.4.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "opener";
      version = "0.4.1";
      sha256 = "13117407ca9d0caf3a0e74f97b490a7e64c0ae3aa90a8b7085544d0c37b6f3ae";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Brian Bowman <seeker14491@gmail.com>\"]\ndescription = \"Open a file or link using the system default program.\"\nedition = \"2018\"\nkeywords = [\"open\", \"default\", \"launcher\", \"browser\"]\nlicense = \"MIT OR Apache-2.0\"\nname = \"opener\"\nreadme = \"../README.md\"\nrepository = \"https://github.com/Seeker14491/opener\"\nversion = \"0.4.1\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".openssl."0.10.25" = mkRustCrate {
    inherit release profiles;
    name = "openssl";
    version = "0.10.25";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "openssl";
      version = "0.10.25";
      sha256 = "2f372b2b53ce10fb823a337aaa674e3a7d072b957c6264d0f4ff0bd86e657449";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      bitflags = rustPackages."registry+https://github.com/rust-lang/crates.io-index".bitflags."1.2.1" { };
      cfg_if = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { };
      foreign_types = rustPackages."registry+https://github.com/rust-lang/crates.io-index".foreign-types."0.3.2" { };
      lazy_static = rustPackages."registry+https://github.com/rust-lang/crates.io-index".lazy_static."1.4.0" { };
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
      openssl_sys = rustPackages."registry+https://github.com/rust-lang/crates.io-index".openssl-sys."0.9.52" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Steven Fackler <sfackler@gmail.com>\"]\ncategories = [\"cryptography\", \"api-bindings\"]\ndescription = \"OpenSSL bindings\"\nkeywords = [\"crypto\", \"tls\", \"ssl\", \"dtls\"]\nlicense = \"Apache-2.0\"\nname = \"openssl\"\nreadme = \"README.md\"\nrepository = \"https://github.com/sfackler/rust-openssl\"\nversion = \"0.10.25\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".openssl-probe."0.1.2" = mkRustCrate {
    inherit release profiles;
    name = "openssl-probe";
    version = "0.1.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "openssl-probe";
      version = "0.1.2";
      sha256 = "77af24da69f9d9341038eba93a073b1fdaaa1b788221b00a69bce9e762cb32de";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\ndescription = \"Tool for helping to find SSL certificate locations on the system for OpenSSL\\n\"\nhomepage = \"https://github.com/alexcrichton/openssl-probe\"\nlicense = \"MIT/Apache-2.0\"\nname = \"openssl-probe\"\nreadme = \"README.md\"\nrepository = \"https://github.com/alexcrichton/openssl-probe\"\nversion = \"0.1.2\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".openssl-sys."0.9.52" = mkRustCrate {
    inherit release profiles;
    name = "openssl-sys";
    version = "0.9.52";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "openssl-sys";
      version = "0.9.52";
      sha256 = "c977d08e1312e2f7e4b86f9ebaa0ed3b19d1daff75fae88bbb88108afbd801fc";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      libc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
    };
    devDependencies = {
    };
    buildDependencies = {
      autocfg = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".autocfg."0.1.7" { };
      cc = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".cc."1.0.46" { };
      pkg_config = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".pkg-config."0.3.16" { };
      ${ if hostPlatform.parsed.abi.name == "msvc" then "vcpkg" else null } = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".vcpkg."0.2.7" { };
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\", \"Steven Fackler <sfackler@gmail.com>\"]\nbuild = \"build/main.rs\"\ncategories = [\"cryptography\", \"external-ffi-bindings\"]\ndescription = \"FFI bindings to OpenSSL\"\nlicense = \"MIT\"\nlinks = \"openssl\"\nname = \"openssl-sys\"\nreadme = \"README.md\"\nrepository = \"https://github.com/sfackler/rust-openssl\"\nversion = \"0.9.52\"\n[package.metadata.pkg-config]\nopenssl = \"1.0.1\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".pathdiff."0.1.0" = mkRustCrate {
    inherit release profiles;
    name = "pathdiff";
    version = "0.1.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "pathdiff";
      version = "0.1.0";
      sha256 = "a3bf70094d203e07844da868b634207e71bfab254fe713171fae9a6e751ccf31";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Manish Goregaokar <manishsmail@gmail.com>\"]\ndescription = \"Library for diffing paths to obtain relative paths\"\ndocumentation = \"https://docs.rs/pathdiff/\"\nkeywords = [\"path\", \"relative\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"pathdiff\"\nrepository = \"https://github.com/Manishearth/pathdiff\"\nversion = \"0.1.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".percent-encoding."1.0.1" = mkRustCrate {
    inherit release profiles;
    name = "percent-encoding";
    version = "1.0.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "percent-encoding";
      version = "1.0.1";
      sha256 = "31010dd2e1ac33d5b46a5b413495239882813e0369f8ed8a5e266f173602f831";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\ndoctest = false\npath = \"lib.rs\"\ntest = false\n\n[package]\nauthors = [\"The rust-url developers\"]\ndescription = \"Percent encoding and decoding\"\nlicense = \"MIT/Apache-2.0\"\nname = \"percent-encoding\"\nrepository = \"https://github.com/servo/rust-url/\"\nversion = \"1.0.1\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".percent-encoding."2.1.0" = mkRustCrate {
    inherit release profiles;
    name = "percent-encoding";
    version = "2.1.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "percent-encoding";
      version = "2.1.0";
      sha256 = "d4fd5641d01c8f18a23da7b6fe29298ff4b55afcccdf78973b24cf3175fee32e";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\npath = \"lib.rs\"\ntest = false\n\n[package]\nauthors = [\"The rust-url developers\"]\ndescription = \"Percent encoding and decoding\"\nlicense = \"MIT/Apache-2.0\"\nname = \"percent-encoding\"\nrepository = \"https://github.com/servo/rust-url/\"\nversion = \"2.1.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".pkg-config."0.3.16" = mkRustCrate {
    inherit release profiles;
    name = "pkg-config";
    version = "0.3.16";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "pkg-config";
      version = "0.3.16";
      sha256 = "72d5370d90f49f70bd033c3d75e87fc529fbfff9d6f7cccef07d6170079d91ea";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\ndescription = \"A library to run the pkg-config system tool at build time in order to be used in\\nCargo build scripts.\\n\"\ndocumentation = \"https://docs.rs/pkg-config\"\nkeywords = [\"build-dependencies\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"pkg-config\"\nrepository = \"https://github.com/rust-lang/pkg-config-rs\"\nversion = \"0.3.16\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".ppv-lite86."0.2.6" = mkRustCrate {
    inherit release profiles;
    name = "ppv-lite86";
    version = "0.2.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "ppv-lite86";
      version = "0.2.6";
      sha256 = "74490b50b9fbe561ac330df47c08f3f33073d2d00c150f719147d7c54522fa1b";
    };
    features = builtins.concatLists [
      [ "simd" ]
      [ "std" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"The CryptoCorrosion Contributors\"]\ncategories = [\"cryptography\", \"no-std\"]\ndescription = \"Implementation of the crypto-simd API for x86\"\nedition = \"2018\"\nkeywords = [\"crypto\", \"simd\", \"x86\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"ppv-lite86\"\nrepository = \"https://github.com/cryptocorrosion/cryptocorrosion\"\nversion = \"0.2.6\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".proc-macro2."1.0.5" = mkRustCrate {
    inherit release profiles;
    name = "proc-macro2";
    version = "1.0.5";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "proc-macro2";
      version = "1.0.5";
      sha256 = "90cf5f418035b98e655e9cdb225047638296b862b42411c4e45bb88d700f7fc0";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "proc-macro" ]
    ];
    dependencies = {
      unicode_xid = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-xid."0.2.0" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nname = \"proc_macro2\"\n\n[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\ndescription = \"A stable implementation of the upcoming new `proc_macro` API. Comes with an\\noption, off by default, to also reimplement itself in terms of the upstream\\nunstable API.\\n\"\ndocumentation = \"https://docs.rs/proc-macro2\"\nedition = \"2018\"\nhomepage = \"https://github.com/alexcrichton/proc-macro2\"\nkeywords = [\"macros\"]\nlicense = \"MIT OR Apache-2.0\"\nname = \"proc-macro2\"\nreadme = \"README.md\"\nrepository = \"https://github.com/alexcrichton/proc-macro2\"\nversion = \"1.0.5\"\n[package.metadata.docs.rs]\nrustc-args = [\"--cfg\", \"procmacro2_semver_exempt\"]\nrustdoc-args = [\"--cfg\", \"procmacro2_semver_exempt\"]\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".quick-error."1.2.2" = mkRustCrate {
    inherit release profiles;
    name = "quick-error";
    version = "1.2.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "quick-error";
      version = "1.2.2";
      sha256 = "9274b940887ce9addde99c4eee6b5c44cc494b182b97e73dc8ffdcb3397fd3f0";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Paul Colomiets <paul@colomiets.name>\", \"Colin Kiegel <kiegel@gmx.de>\"]\ncategories = [\"rust-patterns\"]\ndescription = \"    A macro which makes error types pleasant to write.\\n\"\ndocumentation = \"http://docs.rs/quick-error\"\nhomepage = \"http://github.com/tailhook/quick-error\"\nkeywords = [\"macro\", \"error\", \"type\", \"enum\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"quick-error\"\nrepository = \"http://github.com/tailhook/quick-error\"\nversion = \"1.2.2\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".quote."1.0.2" = mkRustCrate {
    inherit release profiles;
    name = "quote";
    version = "1.0.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "quote";
      version = "1.0.2";
      sha256 = "053a8c8bcc71fcce321828dc897a98ab9760bef03a4fc36693c231e5b3216cfe";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "proc-macro" ]
    ];
    dependencies = {
      proc_macro2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".proc-macro2."1.0.5" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nname = \"quote\"\n\n[package]\nauthors = [\"David Tolnay <dtolnay@gmail.com>\"]\ncategories = [\"development-tools::procedural-macro-helpers\"]\ndescription = \"Quasi-quoting macro quote!(...)\"\ndocumentation = \"https://docs.rs/quote/\"\nedition = \"2018\"\ninclude = [\"Cargo.toml\", \"src/**/*.rs\", \"tests/**/*.rs\", \"README.md\", \"LICENSE-APACHE\", \"LICENSE-MIT\"]\nkeywords = [\"syn\"]\nlicense = \"MIT OR Apache-2.0\"\nname = \"quote\"\nreadme = \"README.md\"\nrepository = \"https://github.com/dtolnay/quote\"\nversion = \"1.0.2\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".rand."0.7.2" = mkRustCrate {
    inherit release profiles;
    name = "rand";
    version = "0.7.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "rand";
      version = "0.7.2";
      sha256 = "3ae1b169243eaf61759b8475a998f0a385e42042370f3a7dbaf35246eacc8412";
    };
    features = builtins.concatLists [
      [ "alloc" ]
      [ "default" ]
      [ "getrandom" ]
      [ "getrandom_package" ]
      [ "std" ]
    ];
    dependencies = {
      getrandom_package = rustPackages."registry+https://github.com/rust-lang/crates.io-index".getrandom."0.1.12" { };
      ${ if hostPlatform.isUnix then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
      ${ if !(hostPlatform.parsed.kernel.name == "emscripten") then "rand_chacha" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".rand_chacha."0.2.1" { };
      rand_core = rustPackages."registry+https://github.com/rust-lang/crates.io-index".rand_core."0.5.1" { };
    };
    devDependencies = {
      rand_hc = rustPackages."registry+https://github.com/rust-lang/crates.io-index".rand_hc."0.2.0" { };
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"The Rand Project Developers\", \"The Rust Project Developers\"]\nautobenches = true\ncategories = [\"algorithms\", \"no-std\"]\ndescription = \"Random number generators and other randomness functionality.\\n\"\ndocumentation = \"https://rust-random.github.io/rand/\"\nedition = \"2018\"\nexclude = [\"/utils/*\", \"/.travis.yml\", \"/appveyor.yml\", \".gitignore\"]\nhomepage = \"https://crates.io/crates/rand\"\nkeywords = [\"random\", \"rng\"]\nlicense = \"MIT OR Apache-2.0\"\nname = \"rand\"\nreadme = \"README.md\"\nrepository = \"https://github.com/rust-random/rand\"\nversion = \"0.7.2\"\n[package.metadata.docs.rs]\nall-features = true\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".rand_chacha."0.2.1" = mkRustCrate {
    inherit release profiles;
    name = "rand_chacha";
    version = "0.2.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "rand_chacha";
      version = "0.2.1";
      sha256 = "03a2a90da8c7523f554344f921aa97283eadf6ac484a6d2a7d0212fa7f8d6853";
    };
    features = builtins.concatLists [
      [ "std" ]
    ];
    dependencies = {
      c2_chacha = rustPackages."registry+https://github.com/rust-lang/crates.io-index".c2-chacha."0.2.3" { };
      rand_core = rustPackages."registry+https://github.com/rust-lang/crates.io-index".rand_core."0.5.1" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"The Rand Project Developers\", \"The Rust Project Developers\", \"The CryptoCorrosion Contributors\"]\ncategories = [\"algorithms\", \"no-std\"]\ndescription = \"ChaCha random number generator\\n\"\ndocumentation = \"https://rust-random.github.io/rand/rand_chacha/\"\nedition = \"2018\"\nhomepage = \"https://crates.io/crates/rand_chacha\"\nkeywords = [\"random\", \"rng\", \"chacha\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"rand_chacha\"\nreadme = \"README.md\"\nrepository = \"https://github.com/rust-random/rand\"\nversion = \"0.2.1\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".rand_core."0.5.1" = mkRustCrate {
    inherit release profiles;
    name = "rand_core";
    version = "0.5.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "rand_core";
      version = "0.5.1";
      sha256 = "90bde5296fc891b0cef12a6d03ddccc162ce7b2aff54160af9338f8d40df6d19";
    };
    features = builtins.concatLists [
      [ "alloc" ]
      [ "getrandom" ]
      [ "std" ]
    ];
    dependencies = {
      getrandom = rustPackages."registry+https://github.com/rust-lang/crates.io-index".getrandom."0.1.12" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"The Rand Project Developers\", \"The Rust Project Developers\"]\ncategories = [\"algorithms\", \"no-std\"]\ndescription = \"Core random number generator traits and tools for implementation.\\n\"\ndocumentation = \"https://rust-random.github.io/rand/rand_core/\"\nedition = \"2018\"\nhomepage = \"https://crates.io/crates/rand_core\"\nkeywords = [\"random\", \"rng\"]\nlicense = \"MIT OR Apache-2.0\"\nname = \"rand_core\"\nreadme = \"README.md\"\nrepository = \"https://github.com/rust-random/rand\"\nversion = \"0.5.1\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".rand_hc."0.2.0" = mkRustCrate {
    inherit release profiles;
    name = "rand_hc";
    version = "0.2.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "rand_hc";
      version = "0.2.0";
      sha256 = "ca3129af7b92a17112d59ad498c6f81eaf463253766b90396d39ea7a39d6613c";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      rand_core = rustPackages."registry+https://github.com/rust-lang/crates.io-index".rand_core."0.5.1" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"The Rand Project Developers\"]\ncategories = [\"algorithms\", \"no-std\"]\ndescription = \"HC128 random number generator\\n\"\ndocumentation = \"https://rust-random.github.io/rand/rand_hc/\"\nedition = \"2018\"\nhomepage = \"https://crates.io/crates/rand_hc\"\nkeywords = [\"random\", \"rng\", \"hc128\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"rand_hc\"\nreadme = \"README.md\"\nrepository = \"https://github.com/rust-random/rand\"\nversion = \"0.2.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".redox_syscall."0.1.56" = mkRustCrate {
    inherit release profiles;
    name = "redox_syscall";
    version = "0.1.56";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "redox_syscall";
      version = "0.1.56";
      sha256 = "2439c63f3f6139d1b57529d16bc3b8bb855230c8efcc5d3a896c8bea7c3b1e84";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nname = \"syscall\"\n\n[package]\nauthors = [\"Jeremy Soller <jackpot51@gmail.com>\"]\ndescription = \"A Rust library to access raw Redox system calls\"\ndocumentation = \"https://docs.rs/redox_syscall\"\nlicense = \"MIT\"\nname = \"redox_syscall\"\nrepository = \"https://gitlab.redox-os.org/redox-os/syscall\"\nversion = \"0.1.56\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".regex."1.3.1" = mkRustCrate {
    inherit release profiles;
    name = "regex";
    version = "1.3.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "regex";
      version = "1.3.1";
      sha256 = "dc220bd33bdce8f093101afe22a037b8eb0e5af33592e6a9caafff0d4cb81cbd";
    };
    features = builtins.concatLists [
      [ "aho-corasick" ]
      [ "default" ]
      [ "memchr" ]
      [ "perf" ]
      [ "perf-cache" ]
      [ "perf-dfa" ]
      [ "perf-inline" ]
      [ "perf-literal" ]
      [ "std" ]
      [ "thread_local" ]
      [ "unicode" ]
      [ "unicode-age" ]
      [ "unicode-bool" ]
      [ "unicode-case" ]
      [ "unicode-gencat" ]
      [ "unicode-perl" ]
      [ "unicode-script" ]
      [ "unicode-segment" ]
    ];
    dependencies = {
      aho_corasick = rustPackages."registry+https://github.com/rust-lang/crates.io-index".aho-corasick."0.7.6" { };
      memchr = rustPackages."registry+https://github.com/rust-lang/crates.io-index".memchr."2.2.1" { };
      regex_syntax = rustPackages."registry+https://github.com/rust-lang/crates.io-index".regex-syntax."0.6.12" { };
      thread_local = rustPackages."registry+https://github.com/rust-lang/crates.io-index".thread_local."0.3.6" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[[test]]\nname = \"default\"\npath = \"tests/test_default.rs\"\n\n[[test]]\nname = \"default-bytes\"\npath = \"tests/test_default_bytes.rs\"\n\n[[test]]\nname = \"nfa\"\npath = \"tests/test_nfa.rs\"\n\n[[test]]\nname = \"nfa-utf8bytes\"\npath = \"tests/test_nfa_utf8bytes.rs\"\n\n[[test]]\nname = \"nfa-bytes\"\npath = \"tests/test_nfa_bytes.rs\"\n\n[[test]]\nname = \"backtrack\"\npath = \"tests/test_backtrack.rs\"\n\n[[test]]\nname = \"backtrack-utf8bytes\"\npath = \"tests/test_backtrack_utf8bytes.rs\"\n\n[[test]]\nname = \"backtrack-bytes\"\npath = \"tests/test_backtrack_bytes.rs\"\n\n[[test]]\nname = \"crates-regex\"\npath = \"tests/test_crates_regex.rs\"\n\n[lib]\nbench = false\ndoctest = false\n\n[package]\nauthors = [\"The Rust Project Developers\"]\nautotests = false\ncategories = [\"text-processing\"]\ndescription = \"An implementation of regular expressions for Rust. This implementation uses\\nfinite automata and guarantees linear time matching on all inputs.\\n\"\ndocumentation = \"https://docs.rs/regex\"\nexclude = [\"/.travis.yml\", \"/appveyor.yml\", \"/ci/*\", \"/scripts/*\"]\nhomepage = \"https://github.com/rust-lang/regex\"\nlicense = \"MIT/Apache-2.0\"\nname = \"regex\"\nreadme = \"README.md\"\nrepository = \"https://github.com/rust-lang/regex\"\nversion = \"1.3.1\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".regex-syntax."0.6.12" = mkRustCrate {
    inherit release profiles;
    name = "regex-syntax";
    version = "0.6.12";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "regex-syntax";
      version = "0.6.12";
      sha256 = "11a7e20d1cce64ef2fed88b66d347f88bd9babb82845b2b858f3edbf59a4f716";
    };
    features = builtins.concatLists [
      [ "unicode-age" ]
      [ "unicode-bool" ]
      [ "unicode-case" ]
      [ "unicode-gencat" ]
      [ "unicode-perl" ]
      [ "unicode-script" ]
      [ "unicode-segment" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"The Rust Project Developers\"]\ndescription = \"A regular expression parser.\"\ndocumentation = \"https://docs.rs/regex-syntax\"\nhomepage = \"https://github.com/rust-lang/regex\"\nlicense = \"MIT/Apache-2.0\"\nname = \"regex-syntax\"\nrepository = \"https://github.com/rust-lang/regex\"\nversion = \"0.6.12\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".remove_dir_all."0.5.2" = mkRustCrate {
    inherit release profiles;
    name = "remove_dir_all";
    version = "0.5.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "remove_dir_all";
      version = "0.5.2";
      sha256 = "4a83fa3702a688b9359eccba92d153ac33fd2e8462f9e0e3fdf155239ea7792e";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Aaronepower <theaaronepower@gmail.com>\"]\ncategories = [\"filesystem\"]\ndescription = \"A safe, reliable implementation of remove_dir_all for Windows\"\ninclude = [\"Cargo.toml\", \"LICENCE-APACHE\", \"LICENCE-MIT\", \"src/**/*\"]\nkeywords = [\"utility\", \"filesystem\", \"remove_dir\", \"windows\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"remove_dir_all\"\nreadme = \"README.md\"\nrepository = \"https://github.com/XAMPPRocky/remove_dir_all.git\"\nversion = \"0.5.2\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".rustc-demangle."0.1.16" = mkRustCrate {
    inherit release profiles;
    name = "rustc-demangle";
    version = "0.1.16";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "rustc-demangle";
      version = "0.1.16";
      sha256 = "4c691c0e608126e00913e33f0ccf3727d5fc84573623b8d65b2df340b5201783";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\ndescription = \"Rust compiler symbol demangling.\\n\"\ndocumentation = \"https://docs.rs/rustc-demangle\"\nhomepage = \"https://github.com/alexcrichton/rustc-demangle\"\nlicense = \"MIT/Apache-2.0\"\nname = \"rustc-demangle\"\nreadme = \"README.md\"\nrepository = \"https://github.com/alexcrichton/rustc-demangle\"\nversion = \"0.1.16\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".rustc-workspace-hack."1.0.0" = mkRustCrate {
    inherit release profiles;
    name = "rustc-workspace-hack";
    version = "1.0.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "rustc-workspace-hack";
      version = "1.0.0";
      sha256 = "fc71d2faa173b74b232dedc235e3ee1696581bb132fc116fa3626d6151a1a8fb";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\ndescription = \"Hack for the compiler\'s own build system\\n\"\nlicense = \"MIT/Apache-2.0\"\nname = \"rustc-workspace-hack\"\nversion = \"1.0.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".rustc_version."0.2.3" = mkRustCrate {
    inherit release profiles;
    name = "rustc_version";
    version = "0.2.3";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "rustc_version";
      version = "0.2.3";
      sha256 = "138e3e0acb6c9fb258b19b67cb8abd63c00679d2851805ea151465464fe9030a";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      semver = rustPackages."registry+https://github.com/rust-lang/crates.io-index".semver."0.9.0" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Marvin Löbel <loebel.marvin@gmail.com>\"]\ndescription = \"A library for querying the version of a installed rustc compiler\"\ndocumentation = \"https://docs.rs/rustc_version/\"\nkeywords = [\"version\", \"rustc\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"rustc_version\"\nreadme = \"README.md\"\nrepository = \"https://github.com/Kimundi/rustc-version-rs\"\nversion = \"0.2.3\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".rustfix."0.4.6" = mkRustCrate {
    inherit release profiles;
    name = "rustfix";
    version = "0.4.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "rustfix";
      version = "0.4.6";
      sha256 = "7150ac777a2931a53489f5a41eb0937b84e3092a20cd0e73ad436b65b507f607";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      failure = rustPackages."registry+https://github.com/rust-lang/crates.io-index".failure."0.1.6" { };
      log = rustPackages."registry+https://github.com/rust-lang/crates.io-index".log."0.4.8" { };
      serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" { };
      serde_json = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde_json."1.0.41" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Pascal Hertleif <killercup@gmail.com>\", \"Oliver Schneider <oli-obk@users.noreply.github.com>\"]\ndescription = \"Automatically apply the suggestions made by rustc\"\ndocumentation = \"https://docs.rs/rustfix\"\nedition = \"2018\"\nexclude = [\"etc/*\", \"examples/*\", \"tests/*\"]\nlicense = \"Apache-2.0/MIT\"\nname = \"rustfix\"\nreadme = \"Readme.md\"\nrepository = \"https://github.com/rust-lang-nursery/rustfix\"\nversion = \"0.4.6\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".ryu."1.0.2" = mkRustCrate {
    inherit release profiles;
    name = "ryu";
    version = "1.0.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "ryu";
      version = "1.0.2";
      sha256 = "bfa8506c1de11c9c4e4c38863ccbe02a305c8188e85a05a784c9e11e1c3910c8";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"David Tolnay <dtolnay@gmail.com>\"]\nbuild = \"build.rs\"\ndescription = \"Fast floating point to string conversion\"\ndocumentation = \"https://docs.rs/ryu\"\nlicense = \"Apache-2.0 OR BSL-1.0\"\nname = \"ryu\"\nreadme = \"README.md\"\nrepository = \"https://github.com/dtolnay/ryu\"\nversion = \"1.0.2\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".same-file."1.0.5" = mkRustCrate {
    inherit release profiles;
    name = "same-file";
    version = "1.0.5";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "same-file";
      version = "1.0.5";
      sha256 = "585e8ddcedc187886a30fa705c47985c3fa88d06624095856b36ca0b82ff4421";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isWindows then "winapi_util" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi-util."0.1.2" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Andrew Gallant <jamslam@gmail.com>\"]\ndescription = \"A simple crate for determining whether two file paths point to the same file.\\n\"\ndocumentation = \"https://docs.rs/same-file\"\nexclude = [\"/.travis.yml\", \"/appveyor.yml\"]\nhomepage = \"https://github.com/BurntSushi/same-file\"\nkeywords = [\"same\", \"file\", \"equal\", \"inode\"]\nlicense = \"Unlicense/MIT\"\nname = \"same-file\"\nreadme = \"README.md\"\nrepository = \"https://github.com/BurntSushi/same-file\"\nversion = \"1.0.5\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".schannel."0.1.16" = mkRustCrate {
    inherit release profiles;
    name = "schannel";
    version = "0.1.16";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "schannel";
      version = "0.1.16";
      sha256 = "87f550b06b6cba9c8b8be3ee73f391990116bf527450d2556e9b9ce263b9a021";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      lazy_static = rustPackages."registry+https://github.com/rust-lang/crates.io-index".lazy_static."1.4.0" { };
      winapi = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Steven Fackler <sfackler@gmail.com>\", \"Steffen Butzer <steffen.butzer@outlook.com>\"]\ndescription = \"Schannel bindings for rust, allowing SSL/TLS (e.g. https) without openssl\"\ndocumentation = \"https://docs.rs/schannel/0/x86_64-pc-windows-gnu/schannel/\"\nkeywords = [\"windows\", \"schannel\", \"tls\", \"ssl\", \"https\"]\nlicense = \"MIT\"\nname = \"schannel\"\nreadme = \"README.md\"\nrepository = \"https://github.com/steffengy/schannel-rs\"\nversion = \"0.1.16\"\n[package.metadata.docs.rs]\ndefault-target = \"x86_64-pc-windows-msvc\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".scopeguard."0.3.3" = mkRustCrate {
    inherit release profiles;
    name = "scopeguard";
    version = "0.3.3";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "scopeguard";
      version = "0.3.3";
      sha256 = "94258f53601af11e6a49f722422f6e3425c52b06245a5cf9bc09908b174f5e27";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "use_std" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"bluss\"]\ncategories = [\"rust-patterns\"]\ndescription = \"A RAII scope guard that will run a given closure when it goes out of scope,\\neven if the code between panics (assuming unwinding panic).\\n\\nDefines the macros `defer!` and `defer_on_unwind!`; the latter only runs\\nif the scope is extited through unwinding on panic.\\n\"\ndocumentation = \"https://docs.rs/scopeguard/\"\nkeywords = [\"scope-guard\", \"defer\", \"panic\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"scopeguard\"\nrepository = \"https://github.com/bluss/scopeguard\"\nversion = \"0.3.3\"\n[package.metadata.release]\nno-dev-version = true\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".semver."0.9.0" = mkRustCrate {
    inherit release profiles;
    name = "semver";
    version = "0.9.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "semver";
      version = "0.9.0";
      sha256 = "1d7eb9ef2c18661902cc47e535f9bc51b78acd254da71d375c2f6720d9a40403";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "serde" ]
    ];
    dependencies = {
      semver_parser = rustPackages."registry+https://github.com/rust-lang/crates.io-index".semver-parser."0.7.0" { };
      serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Steve Klabnik <steve@steveklabnik.com>\", \"The Rust Project Developers\"]\ndescription = \"Semantic version parsing and comparison.\\n\"\ndocumentation = \"https://docs.rs/crate/semver/\"\nhomepage = \"https://docs.rs/crate/semver/\"\nlicense = \"MIT/Apache-2.0\"\nname = \"semver\"\nreadme = \"README.md\"\nrepository = \"https://github.com/steveklabnik/semver\"\nversion = \"0.9.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".semver-parser."0.7.0" = mkRustCrate {
    inherit release profiles;
    name = "semver-parser";
    version = "0.7.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "semver-parser";
      version = "0.7.0";
      sha256 = "388a1df253eca08550bef6c72392cfe7c30914bf41df5269b68cbd6ff8f570a3";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Steve Klabnik <steve@steveklabnik.com>\"]\ndescription = \"Parsing of the semver spec.\\n\"\ndocumentation = \"https://docs.rs/semver-parser\"\nhomepage = \"https://github.com/steveklabnik/semver-parser\"\nlicense = \"MIT/Apache-2.0\"\nname = \"semver-parser\"\nrepository = \"https://github.com/steveklabnik/semver-parser\"\nversion = \"0.7.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" = mkRustCrate {
    inherit release profiles;
    name = "serde";
    version = "1.0.101";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "serde";
      version = "1.0.101";
      sha256 = "9796c9b7ba2ffe7a9ce53c2287dfc48080f4b2b362fcc245a259b3a7201119dd";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "derive" ]
      [ "serde_derive" ]
      [ "std" ]
    ];
    dependencies = {
      serde_derive = buildRustPackages."registry+https://github.com/rust-lang/crates.io-index".serde_derive."1.0.101" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Erick Tryzelaar <erick.tryzelaar@gmail.com>\", \"David Tolnay <dtolnay@gmail.com>\"]\nbuild = \"build.rs\"\ncategories = [\"encoding\"]\ndescription = \"A generic serialization/deserialization framework\"\ndocumentation = \"https://docs.serde.rs/serde/\"\nhomepage = \"https://serde.rs\"\ninclude = [\"Cargo.toml\", \"build.rs\", \"src/**/*.rs\", \"crates-io.md\", \"README.md\", \"LICENSE-APACHE\", \"LICENSE-MIT\"]\nkeywords = [\"serde\", \"serialization\", \"no_std\"]\nlicense = \"MIT OR Apache-2.0\"\nname = \"serde\"\nreadme = \"crates-io.md\"\nrepository = \"https://github.com/serde-rs/serde\"\nversion = \"1.0.101\"\n[package.metadata.playground]\nfeatures = [\"derive\", \"rc\"]\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".serde_derive."1.0.101" = mkRustCrate {
    inherit release profiles;
    name = "serde_derive";
    version = "1.0.101";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "serde_derive";
      version = "1.0.101";
      sha256 = "4b133a43a1ecd55d4086bd5b4dc6c1751c68b1bfbeba7a5040442022c7e7c02e";
    };
    features = builtins.concatLists [
      [ "default" ]
    ];
    dependencies = {
      proc_macro2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".proc-macro2."1.0.5" { };
      quote = rustPackages."registry+https://github.com/rust-lang/crates.io-index".quote."1.0.2" { };
      syn = rustPackages."registry+https://github.com/rust-lang/crates.io-index".syn."1.0.5" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nname = \"serde_derive\"\nproc-macro = true\n\n[package]\nauthors = [\"Erick Tryzelaar <erick.tryzelaar@gmail.com>\", \"David Tolnay <dtolnay@gmail.com>\"]\ndescription = \"Macros 1.1 implementation of #[derive(Serialize, Deserialize)]\"\ndocumentation = \"https://serde.rs/derive.html\"\nhomepage = \"https://serde.rs\"\ninclude = [\"Cargo.toml\", \"src/**/*.rs\", \"crates-io.md\", \"README.md\", \"LICENSE-APACHE\", \"LICENSE-MIT\"]\nkeywords = [\"serde\", \"serialization\", \"no_std\"]\nlicense = \"MIT OR Apache-2.0\"\nname = \"serde_derive\"\nreadme = \"crates-io.md\"\nrepository = \"https://github.com/serde-rs/serde\"\nversion = \"1.0.101\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".serde_ignored."0.0.4" = mkRustCrate {
    inherit release profiles;
    name = "serde_ignored";
    version = "0.0.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "serde_ignored";
      version = "0.0.4";
      sha256 = "190e9765dcedb56be63b6e0993a006c7e3b071a016a304736e4a315dc01fb142";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"David Tolnay <dtolnay@gmail.com>\"]\ncategories = [\"encoding\"]\ndescription = \"Find out about keys that are ignored when deserializing data\"\nkeywords = [\"serde\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"serde_ignored\"\nrepository = \"https://github.com/dtolnay/serde-ignored\"\nversion = \"0.0.4\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".serde_json."1.0.41" = mkRustCrate {
    inherit release profiles;
    name = "serde_json";
    version = "1.0.41";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "serde_json";
      version = "1.0.41";
      sha256 = "2f72eb2a68a7dc3f9a691bfda9305a1c017a6215e5a4545c258500d2099a37c2";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "raw_value" ]
    ];
    dependencies = {
      itoa = rustPackages."registry+https://github.com/rust-lang/crates.io-index".itoa."0.4.4" { };
      ryu = rustPackages."registry+https://github.com/rust-lang/crates.io-index".ryu."1.0.2" { };
      serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Erick Tryzelaar <erick.tryzelaar@gmail.com>\", \"David Tolnay <dtolnay@gmail.com>\"]\ncategories = [\"encoding\"]\ndescription = \"A JSON serialization file format\"\ndocumentation = \"http://docs.serde.rs/serde_json/\"\ninclude = [\"Cargo.toml\", \"src/**/*.rs\", \"README.md\", \"LICENSE-APACHE\", \"LICENSE-MIT\"]\nkeywords = [\"json\", \"serde\", \"serialization\"]\nlicense = \"MIT OR Apache-2.0\"\nname = \"serde_json\"\nreadme = \"README.md\"\nrepository = \"https://github.com/serde-rs/json\"\nversion = \"1.0.41\"\n[package.metadata.docs.rs]\nfeatures = [\"raw_value\", \"unbounded_depth\"]\n\n[package.metadata.playground]\nfeatures = [\"raw_value\"]\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".shell-escape."0.1.4" = mkRustCrate {
    inherit release profiles;
    name = "shell-escape";
    version = "0.1.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "shell-escape";
      version = "0.1.4";
      sha256 = "170a13e64f2a51b77a45702ba77287f5c6829375b04a69cf2222acd17d0cfab9";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Steven Fackler <sfackler@gmail.com>\"]\ndescription = \"Escape characters that may have a special meaning in a shell\"\nlicense = \"MIT/Apache-2.0\"\nname = \"shell-escape\"\nrepository = \"https://github.com/sfackler/shell-escape\"\nversion = \"0.1.4\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".sized-chunks."0.3.1" = mkRustCrate {
    inherit release profiles;
    name = "sized-chunks";
    version = "0.3.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "sized-chunks";
      version = "0.3.1";
      sha256 = "f01db57d7ee89c8e053245deb77040a6cc8508311f381c88749c33d4b9b78785";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      typenum = rustPackages."registry+https://github.com/rust-lang/crates.io-index".typenum."1.11.2" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Bodil Stokke <bodil@bodil.org>\"]\ncategories = [\"data-structures\"]\ndescription = \"Efficient sized chunk datatypes\"\ndocumentation = \"http://docs.rs/sized-chunks\"\nedition = \"2018\"\nexclude = [\"release.toml\", \"proptest-regressions/**\"]\nkeywords = [\"sparse-array\"]\nlicense = \"MPL-2.0+\"\nname = \"sized-chunks\"\nreadme = \"./README.md\"\nrepository = \"https://github.com/bodil/sized-chunks\"\nversion = \"0.3.1\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".smallvec."0.6.10" = mkRustCrate {
    inherit release profiles;
    name = "smallvec";
    version = "0.6.10";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "smallvec";
      version = "0.6.10";
      sha256 = "ab606a9c5e214920bb66c458cd7be8ef094f813f20fe77a54cc7dbfff220d4b7";
    };
    features = builtins.concatLists [
      [ "default" ]
      [ "std" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nname = \"smallvec\"\npath = \"lib.rs\"\n\n[package]\nauthors = [\"Simon Sapin <simon.sapin@exyr.org>\"]\ncategories = [\"data-structures\"]\ndescription = \"\'Small vector\' optimization: store up to a small number of items on the stack\"\ndocumentation = \"https://doc.servo.org/smallvec/\"\nkeywords = [\"small\", \"vec\", \"vector\", \"stack\", \"no_std\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"smallvec\"\nreadme = \"README.md\"\nrepository = \"https://github.com/servo/rust-smallvec\"\nversion = \"0.6.10\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".socket2."0.3.11" = mkRustCrate {
    inherit release profiles;
    name = "socket2";
    version = "0.3.11";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "socket2";
      version = "0.3.11";
      sha256 = "e8b74de517221a2cb01a53349cf54182acdc31a074727d3079068448c0676d85";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isUnix || hostPlatform.parsed.kernel.name == "redox" then "cfg_if" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { };
      ${ if hostPlatform.isUnix || hostPlatform.parsed.kernel.name == "redox" then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
      ${ if hostPlatform.parsed.kernel.name == "redox" then "syscall" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".redox_syscall."0.1.56" { };
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\ndescription = \"Utilities for handling networking sockets with a maximal amount of configuration\\npossible intended.\\n\"\nedition = \"2018\"\nhomepage = \"https://github.com/alexcrichton/socket2-rs\"\nlicense = \"MIT/Apache-2.0\"\nname = \"socket2\"\nreadme = \"README.md\"\nrepository = \"https://github.com/alexcrichton/socket2-rs\"\nversion = \"0.3.11\"\n[package.metadata.docs.rs]\nall-features = true\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".strip-ansi-escapes."0.1.0" = mkRustCrate {
    inherit release profiles;
    name = "strip-ansi-escapes";
    version = "0.1.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "strip-ansi-escapes";
      version = "0.1.0";
      sha256 = "9d63676e2abafa709460982ddc02a3bb586b6d15a49b75c212e06edd3933acee";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      vte = rustPackages."registry+https://github.com/rust-lang/crates.io-index".vte."0.3.3" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Ted Mielczarek <ted@mielczarek.org>\"]\ndescription = \"Strip ANSI escape sequences from byte streams.\"\ndocumentation = \"https://docs.rs/strip-ansi-escapes\"\nhomepage = \"https://github.com/luser/strip-ansi-escapes\"\nkeywords = [\"ansi\", \"escape\", \"terminal\"]\nlicense = \"Apache-2.0/MIT\"\nname = \"strip-ansi-escapes\"\nreadme = \"README.md\"\nrepository = \"https://github.com/luser/strip-ansi-escapes\"\nversion = \"0.1.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".strsim."0.8.0" = mkRustCrate {
    inherit release profiles;
    name = "strsim";
    version = "0.8.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "strsim";
      version = "0.8.0";
      sha256 = "8ea5119cdb4c55b55d432abb513a0429384878c15dde60cc77b1c99de1a95a6a";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Danny Guo <dannyguo91@gmail.com>\"]\ndescription = \"Implementations of string similarity metrics.\\nIncludes Hamming, Levenshtein, OSA, Damerau-Levenshtein, Jaro, and Jaro-Winkler.\\n\"\ndocumentation = \"https://docs.rs/strsim/\"\nhomepage = \"https://github.com/dguo/strsim-rs\"\nkeywords = [\"string\", \"similarity\", \"Hamming\", \"Levenshtein\", \"Jaro\"]\nlicense = \"MIT\"\nname = \"strsim\"\nreadme = \"README.md\"\nrepository = \"https://github.com/dguo/strsim-rs\"\nversion = \"0.8.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".syn."1.0.5" = mkRustCrate {
    inherit release profiles;
    name = "syn";
    version = "1.0.5";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "syn";
      version = "1.0.5";
      sha256 = "66850e97125af79138385e9b88339cbcd037e3f28ceab8c5ad98e64f0f1f80bf";
    };
    features = builtins.concatLists [
      [ "clone-impls" ]
      [ "default" ]
      [ "derive" ]
      [ "extra-traits" ]
      [ "parsing" ]
      [ "printing" ]
      [ "proc-macro" ]
      [ "quote" ]
      [ "visit" ]
    ];
    dependencies = {
      proc_macro2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".proc-macro2."1.0.5" { };
      quote = rustPackages."registry+https://github.com/rust-lang/crates.io-index".quote."1.0.2" { };
      unicode_xid = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-xid."0.2.0" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[[bench]]\nedition = \"2018\"\nharness = false\nname = \"rust\"\nrequired-features = [\"full\", \"parsing\"]\n\n[[bench]]\nedition = \"2018\"\nname = \"file\"\nrequired-features = [\"full\", \"parsing\"]\n\n[lib]\nname = \"syn\"\n\n[package]\nauthors = [\"David Tolnay <dtolnay@gmail.com>\"]\ncategories = [\"development-tools::procedural-macro-helpers\"]\ndescription = \"Parser for Rust source code\"\ndocumentation = \"https://docs.rs/syn\"\nedition = \"2018\"\ninclude = [\"/benches/**\", \"/build.rs\", \"/Cargo.toml\", \"/LICENSE-APACHE\", \"/LICENSE-MIT\", \"/README.md\", \"/src/**\", \"/tests/**\"]\nlicense = \"MIT OR Apache-2.0\"\nname = \"syn\"\nreadme = \"README.md\"\nrepository = \"https://github.com/dtolnay/syn\"\nversion = \"1.0.5\"\n[package.metadata.docs.rs]\nall-features = true\n\n[package.metadata.playground]\nall-features = true\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".synstructure."0.12.1" = mkRustCrate {
    inherit release profiles;
    name = "synstructure";
    version = "0.12.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "synstructure";
      version = "0.12.1";
      sha256 = "3f085a5855930c0441ca1288cf044ea4aecf4f43a91668abdb870b4ba546a203";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      proc_macro2 = rustPackages."registry+https://github.com/rust-lang/crates.io-index".proc-macro2."1.0.5" { };
      quote = rustPackages."registry+https://github.com/rust-lang/crates.io-index".quote."1.0.2" { };
      syn = rustPackages."registry+https://github.com/rust-lang/crates.io-index".syn."1.0.5" { };
      unicode_xid = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-xid."0.2.0" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Nika Layzell <nika@thelayzells.com>\"]\ndescription = \"Helper methods and macros for custom derives\"\ndocumentation = \"https://docs.rs/synstructure\"\nedition = \"2018\"\ninclude = [\"src/**/*\", \"Cargo.toml\", \"README.md\", \"LICENSE\"]\nkeywords = [\"syn\", \"macros\", \"derive\", \"expand_substructure\", \"enum\"]\nlicense = \"MIT\"\nname = \"synstructure\"\nreadme = \"README.md\"\nrepository = \"https://github.com/mystor/synstructure\"\nversion = \"0.12.1\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".tar."0.4.26" = mkRustCrate {
    inherit release profiles;
    name = "tar";
    version = "0.4.26";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "tar";
      version = "0.4.26";
      sha256 = "b3196bfbffbba3e57481b6ea32249fbaf590396a52505a2615adbb79d9d826d3";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      filetime = rustPackages."registry+https://github.com/rust-lang/crates.io-index".filetime."0.2.7" { };
      ${ if hostPlatform.isUnix then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
      ${ if hostPlatform.parsed.kernel.name == "redox" then "syscall" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".redox_syscall."0.1.56" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\ndescription = \"A Rust implementation of a TAR file reader and writer. This library does not\\ncurrently handle compression, but it is abstract over all I/O readers and\\nwriters. Additionally, great lengths are taken to ensure that the entire\\ncontents are never required to be entirely resident in memory all at once.\\n\"\ndocumentation = \"https://docs.rs/tar\"\nedition = \"2018\"\nexclude = [\"tests/archives/*\"]\nhomepage = \"https://github.com/alexcrichton/tar-rs\"\nkeywords = [\"tar\", \"tarfile\", \"encoding\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"tar\"\nreadme = \"README.md\"\nrepository = \"https://github.com/alexcrichton/tar-rs\"\nversion = \"0.4.26\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".tempfile."3.1.0" = mkRustCrate {
    inherit release profiles;
    name = "tempfile";
    version = "3.1.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "tempfile";
      version = "3.1.0";
      sha256 = "7a6e24d9338a0a5be79593e2fa15a648add6138caa803e2d5bc782c371732ca9";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      cfg_if = rustPackages."registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.10" { };
      ${ if hostPlatform.isUnix then "libc" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".libc."0.2.65" { };
      rand = rustPackages."registry+https://github.com/rust-lang/crates.io-index".rand."0.7.2" { };
      ${ if hostPlatform.parsed.kernel.name == "redox" then "syscall" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".redox_syscall."0.1.56" { };
      remove_dir_all = rustPackages."registry+https://github.com/rust-lang/crates.io-index".remove_dir_all."0.5.2" { };
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Steven Allen <steven@stebalien.com>\", \"The Rust Project Developers\", \"Ashley Mannix <ashleymannix@live.com.au>\", \"Jason White <jasonaw0@gmail.com>\"]\ndescription = \"A library for managing temporary files and directories.\"\ndocumentation = \"https://docs.rs/tempfile\"\nedition = \"2018\"\nexclude = [\"/.travis.yml\", \"/appveyor.yml\"]\nhomepage = \"http://stebalien.com/projects/tempfile-rs\"\nkeywords = [\"tempfile\", \"tmpfile\", \"filesystem\"]\nlicense = \"MIT OR Apache-2.0\"\nname = \"tempfile\"\nrepository = \"https://github.com/Stebalien/tempfile\"\nversion = \"3.1.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".termcolor."1.0.5" = mkRustCrate {
    inherit release profiles;
    name = "termcolor";
    version = "1.0.5";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "termcolor";
      version = "1.0.5";
      sha256 = "96d6098003bde162e4277c70665bd87c326f5a0c3f3fbfb285787fa482d54e6e";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isWindows then "wincolor" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".wincolor."1.0.2" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nbench = false\nname = \"termcolor\"\n\n[package]\nauthors = [\"Andrew Gallant <jamslam@gmail.com>\"]\ndescription = \"A simple cross platform library for writing colored text to a terminal.\\n\"\ndocumentation = \"https://docs.rs/termcolor\"\nexclude = [\"/.travis.yml\", \"/appveyor.yml\", \"/ci/**\"]\nhomepage = \"https://github.com/BurntSushi/termcolor\"\nkeywords = [\"windows\", \"win\", \"color\", \"ansi\", \"console\"]\nlicense = \"Unlicense OR MIT\"\nname = \"termcolor\"\nreadme = \"README.md\"\nrepository = \"https://github.com/BurntSushi/termcolor\"\nversion = \"1.0.5\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".textwrap."0.11.0" = mkRustCrate {
    inherit release profiles;
    name = "textwrap";
    version = "0.11.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "textwrap";
      version = "0.11.0";
      sha256 = "d326610f408c7a4eb6f51c37c330e496b08506c9457c9d34287ecc38809fb060";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      unicode_width = rustPackages."registry+https://github.com/rust-lang/crates.io-index".unicode-width."0.1.6" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Martin Geisler <martin@geisler.net>\"]\ncategories = [\"text-processing\", \"command-line-interface\"]\ndescription = \"Textwrap is a small library for word wrapping, indenting, and\\ndedenting strings.\\n\\nYou can use it to format strings (such as help and error messages) for\\ndisplay in commandline applications. It is designed to be efficient\\nand handle Unicode characters correctly.\\n\"\ndocumentation = \"https://docs.rs/textwrap/\"\nexclude = [\".dir-locals.el\"]\nkeywords = [\"text\", \"formatting\", \"wrap\", \"typesetting\", \"hyphenation\"]\nlicense = \"MIT\"\nname = \"textwrap\"\nreadme = \"README.md\"\nrepository = \"https://github.com/mgeisler/textwrap\"\nversion = \"0.11.0\"\n[package.metadata.docs.rs]\nall-features = true\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".thread_local."0.3.6" = mkRustCrate {
    inherit release profiles;
    name = "thread_local";
    version = "0.3.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "thread_local";
      version = "0.3.6";
      sha256 = "c6b53e329000edc2b34dbe8545fd20e55a333362d0a321909685a19bd28c3f1b";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      lazy_static = rustPackages."registry+https://github.com/rust-lang/crates.io-index".lazy_static."1.4.0" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Amanieu d\'Antras <amanieu@gmail.com>\"]\ndescription = \"Per-object thread-local storage\"\ndocumentation = \"https://amanieu.github.io/thread_local-rs/thread_local/index.html\"\nkeywords = [\"thread_local\", \"concurrent\", \"thread\"]\nlicense = \"Apache-2.0/MIT\"\nname = \"thread_local\"\nreadme = \"README.md\"\nrepository = \"https://github.com/Amanieu/thread_local-rs\"\nversion = \"0.3.6\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".toml."0.5.3" = mkRustCrate {
    inherit release profiles;
    name = "toml";
    version = "0.5.3";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "toml";
      version = "0.5.3";
      sha256 = "c7aabe75941d914b72bf3e5d3932ed92ce0664d49d8432305a8b547c37227724";
    };
    features = builtins.concatLists [
      [ "default" ]
    ];
    dependencies = {
      serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\"]\ncategories = [\"config\", \"encoding\", \"parser-implementations\"]\ndescription = \"A native Rust encoder and decoder of TOML-formatted files and streams. Provides\\nimplementations of the standard Serialize/Deserialize traits for TOML data to\\nfacilitate deserializing and serializing Rust structures.\\n\"\ndocumentation = \"https://docs.rs/toml\"\nedition = \"2018\"\nhomepage = \"https://github.com/alexcrichton/toml-rs\"\nkeywords = [\"encoding\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"toml\"\nreadme = \"README.md\"\nrepository = \"https://github.com/alexcrichton/toml-rs\"\nversion = \"0.5.3\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".typenum."1.11.2" = mkRustCrate {
    inherit release profiles;
    name = "typenum";
    version = "1.11.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "typenum";
      version = "1.11.2";
      sha256 = "6d2783fe2d6b8c1101136184eb41be8b1ad379e4657050b8aaff0c79ee7575f9";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nname = \"typenum\"\n\n[package]\nauthors = [\"Paho Lurie-Gregg <paho@paholg.com>\", \"Andre Bogus <bogusandre@gmail.com>\"]\nbuild = \"build/main.rs\"\ncategories = [\"no-std\"]\ndescription = \"Typenum is a Rust library for type-level numbers evaluated at compile time. It currently supports bits, unsigned integers, and signed integers. It also provides a type-level array of type-level numbers, but its implementation is incomplete.\"\ndocumentation = \"https://docs.rs/typenum\"\nlicense = \"MIT/Apache-2.0\"\nname = \"typenum\"\nreadme = \"README.md\"\nrepository = \"https://github.com/paholg/typenum\"\nversion = \"1.11.2\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".unicode-bidi."0.3.4" = mkRustCrate {
    inherit release profiles;
    name = "unicode-bidi";
    version = "0.3.4";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "unicode-bidi";
      version = "0.3.4";
      sha256 = "49f2bd0c6468a8230e1db229cff8029217cf623c767ea5d60bfbd42729ea54d5";
    };
    features = builtins.concatLists [
      [ "default" ]
    ];
    dependencies = {
      matches = rustPackages."registry+https://github.com/rust-lang/crates.io-index".matches."0.1.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nname = \"unicode_bidi\"\n\n[package]\nauthors = [\"The Servo Project Developers\"]\ndescription = \"Implementation of the Unicode Bidirectional Algorithm\"\ndocumentation = \"http://doc.servo.org/unicode_bidi/\"\nexclude = [\"benches/**\", \"data/**\", \"examples/**\", \"tests/**\", \"tools/**\"]\nkeywords = [\"rtl\", \"unicode\", \"text\", \"layout\", \"bidi\"]\nlicense = \"MIT / Apache-2.0\"\nname = \"unicode-bidi\"\nrepository = \"https://github.com/servo/unicode-bidi\"\nversion = \"0.3.4\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".unicode-normalization."0.1.8" = mkRustCrate {
    inherit release profiles;
    name = "unicode-normalization";
    version = "0.1.8";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "unicode-normalization";
      version = "0.1.8";
      sha256 = "141339a08b982d942be2ca06ff8b076563cbe223d1befd5450716790d44e2426";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      smallvec = rustPackages."registry+https://github.com/rust-lang/crates.io-index".smallvec."0.6.10" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"kwantam <kwantam@gmail.com>\"]\ndescription = \"This crate provides functions for normalization of\\nUnicode strings, including Canonical and Compatible\\nDecomposition and Recomposition, as described in\\nUnicode Standard Annex #15.\\n\"\ndocumentation = \"https://docs.rs/unicode-normalization/\"\nexclude = [\"target/*\", \"Cargo.lock\", \"scripts/tmp\", \"*.txt\", \"src/normalization_tests.rs\", \"src/test.rs\"]\nhomepage = \"https://github.com/unicode-rs/unicode-normalization\"\nkeywords = [\"text\", \"unicode\", \"normalization\", \"decomposition\", \"recomposition\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"unicode-normalization\"\nreadme = \"README.md\"\nrepository = \"https://github.com/unicode-rs/unicode-normalization\"\nversion = \"0.1.8\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".unicode-width."0.1.6" = mkRustCrate {
    inherit release profiles;
    name = "unicode-width";
    version = "0.1.6";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "unicode-width";
      version = "0.1.6";
      sha256 = "7007dbd421b92cc6e28410fe7362e2e0a2503394908f417b68ec8d1c364c4e20";
    };
    features = builtins.concatLists [
      [ "default" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"kwantam <kwantam@gmail.com>\"]\ndescription = \"Determine displayed width of `char` and `str` types\\naccording to Unicode Standard Annex #11 rules.\\n\"\ndocumentation = \"https://unicode-rs.github.io/unicode-width\"\nexclude = [\"target/*\", \"Cargo.lock\"]\nhomepage = \"https://github.com/unicode-rs/unicode-width\"\nkeywords = [\"text\", \"width\", \"unicode\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"unicode-width\"\nreadme = \"README.md\"\nrepository = \"https://github.com/unicode-rs/unicode-width\"\nversion = \"0.1.6\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".unicode-xid."0.2.0" = mkRustCrate {
    inherit release profiles;
    name = "unicode-xid";
    version = "0.2.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "unicode-xid";
      version = "0.2.0";
      sha256 = "826e7639553986605ec5979c7dd957c7895e93eabed50ab2ffa7f6128a75097c";
    };
    features = builtins.concatLists [
      [ "default" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"erick.tryzelaar <erick.tryzelaar@gmail.com>\", \"kwantam <kwantam@gmail.com>\"]\ndescription = \"Determine whether characters have the XID_Start\\nor XID_Continue properties according to\\nUnicode Standard Annex #31.\\n\"\ndocumentation = \"https://unicode-rs.github.io/unicode-xid\"\nexclude = [\"/scripts/*\", \"/.travis.yml\"]\nhomepage = \"https://github.com/unicode-rs/unicode-xid\"\nkeywords = [\"text\", \"unicode\", \"xid\"]\nlicense = \"MIT OR Apache-2.0\"\nname = \"unicode-xid\"\nreadme = \"README.md\"\nrepository = \"https://github.com/unicode-rs/unicode-xid\"\nversion = \"0.2.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".url."1.7.2" = mkRustCrate {
    inherit release profiles;
    name = "url";
    version = "1.7.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "url";
      version = "1.7.2";
      sha256 = "dd4e7c0d531266369519a4aa4f399d748bd37043b00bde1e4ff1f60a120b355a";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      idna = rustPackages."registry+https://github.com/rust-lang/crates.io-index".idna."0.1.5" { };
      matches = rustPackages."registry+https://github.com/rust-lang/crates.io-index".matches."0.1.8" { };
      percent_encoding = rustPackages."registry+https://github.com/rust-lang/crates.io-index".percent-encoding."1.0.1" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[[bench]]\nharness = false\nname = \"parse_url\"\n\n[[test]]\nname = \"unit\"\n\n[[test]]\nharness = false\nname = \"data\"\n\n[lib]\ntest = false\n\n[package]\nauthors = [\"The rust-url developers\"]\ncategories = [\"parser-implementations\", \"web-programming\", \"encoding\"]\ndescription = \"URL library for Rust, based on the WHATWG URL Standard\"\ndocumentation = \"https://docs.rs/url\"\nkeywords = [\"url\", \"parser\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"url\"\nreadme = \"README.md\"\nrepository = \"https://github.com/servo/rust-url\"\nversion = \"1.7.2\"\n[package.metadata.docs.rs]\nfeatures = [\"query_encoding\"]\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".url."2.1.0" = mkRustCrate {
    inherit release profiles;
    name = "url";
    version = "2.1.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "url";
      version = "2.1.0";
      sha256 = "75b414f6c464c879d7f9babf951f23bc3743fb7313c081b2e6ca719067ea9d61";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      idna = rustPackages."registry+https://github.com/rust-lang/crates.io-index".idna."0.2.0" { };
      matches = rustPackages."registry+https://github.com/rust-lang/crates.io-index".matches."0.1.8" { };
      percent_encoding = rustPackages."registry+https://github.com/rust-lang/crates.io-index".percent-encoding."2.1.0" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[[bench]]\nharness = false\nname = \"parse_url\"\n\n[[test]]\nname = \"unit\"\n\n[[test]]\nharness = false\nname = \"data\"\n\n[lib]\ntest = false\n\n[package]\nauthors = [\"The rust-url developers\"]\ncategories = [\"parser-implementations\", \"web-programming\", \"encoding\"]\ndescription = \"URL library for Rust, based on the WHATWG URL Standard\"\ndocumentation = \"https://docs.rs/url\"\nkeywords = [\"url\", \"parser\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"url\"\nreadme = \"README.md\"\nrepository = \"https://github.com/servo/rust-url\"\nversion = \"2.1.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".url_serde."0.2.0" = mkRustCrate {
    inherit release profiles;
    name = "url_serde";
    version = "0.2.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "url_serde";
      version = "0.2.0";
      sha256 = "74e7d099f1ee52f823d4bdd60c93c3602043c728f5db3b97bdb548467f7bddea";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      serde = rustPackages."registry+https://github.com/rust-lang/crates.io-index".serde."1.0.101" { };
      url = rustPackages."registry+https://github.com/rust-lang/crates.io-index".url."1.7.2" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\ndoctest = false\n\n[package]\nauthors = [\"The rust-url developers\"]\ndescription = \"Serde support for URL types\"\ndocumentation = \"https://docs.rs/url_serde/\"\nkeywords = [\"url\", \"serde\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"url_serde\"\nreadme = \"README.md\"\nrepository = \"https://github.com/servo/rust-url\"\nversion = \"0.2.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".utf8parse."0.1.1" = mkRustCrate {
    inherit release profiles;
    name = "utf8parse";
    version = "0.1.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "utf8parse";
      version = "0.1.1";
      sha256 = "8772a4ccbb4e89959023bc5b7cb8623a795caa7092d99f3aa9501b9484d4557d";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Joe Wilm <joe@jwilm.com>\"]\ndescription = \"Table-driven UTF-8 parser\"\ndocumentation = \"https://docs.rs/utf8parse/\"\nkeywords = [\"utf8\", \"parse\", \"table\"]\nlicense = \"Apache-2.0 OR MIT\"\nname = \"utf8parse\"\nrepository = \"https://github.com/jwilm/vte\"\nversion = \"0.1.1\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".vcpkg."0.2.7" = mkRustCrate {
    inherit release profiles;
    name = "vcpkg";
    version = "0.2.7";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "vcpkg";
      version = "0.2.7";
      sha256 = "33dd455d0f96e90a75803cfeb7f948768c08d70a6de9a8d2362461935698bf95";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Jim McGrath <jimmc2@gmail.com>\"]\ncategories = [\"os::windows-apis\"]\ndescription = \"A library to find native dependencies in a vcpkg tree at build\\ntime in order to be used in Cargo build scripts.\\n\"\ndocumentation = \"https://docs.rs/vcpkg\"\nkeywords = [\"build-dependencies\", \"windows\", \"ffi\", \"win32\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"vcpkg\"\nreadme = \"../README.md\"\nrepository = \"https://github.com/mcgoo/vcpkg-rs\"\nversion = \"0.2.7\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".vec_map."0.8.1" = mkRustCrate {
    inherit release profiles;
    name = "vec_map";
    version = "0.8.1";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "vec_map";
      version = "0.8.1";
      sha256 = "05c78687fb1a80548ae3250346c3db86a80a7cdd77bda190189f2d0a0987c81a";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Alex Crichton <alex@alexcrichton.com>\", \"Jorge Aparicio <japaricious@gmail.com>\", \"Alexis Beingessner <a.beingessner@gmail.com>\", \"Brian Anderson <>\", \"tbu- <>\", \"Manish Goregaokar <>\", \"Aaron Turon <aturon@mozilla.com>\", \"Adolfo Ochagavía <>\", \"Niko Matsakis <>\", \"Steven Fackler <>\", \"Chase Southwood <csouth3@illinois.edu>\", \"Eduard Burtescu <>\", \"Florian Wilkens <>\", \"Félix Raimundo <>\", \"Tibor Benke <>\", \"Markus Siemens <markus@m-siemens.de>\", \"Josh Branchaud <jbranchaud@gmail.com>\", \"Huon Wilson <dbau.pp@gmail.com>\", \"Corey Farwell <coref@rwell.org>\", \"Aaron Liblong <>\", \"Nick Cameron <nrc@ncameron.org>\", \"Patrick Walton <pcwalton@mimiga.net>\", \"Felix S Klock II <>\", \"Andrew Paseltiner <apaseltiner@gmail.com>\", \"Sean McArthur <sean.monstar@gmail.com>\", \"Vadim Petrochenkov <>\"]\ndescription = \"A simple map based on a vector for small integer keys\"\ndocumentation = \"https://contain-rs.github.io/vec-map/vec_map\"\nhomepage = \"https://github.com/contain-rs/vec-map\"\nkeywords = [\"data-structures\", \"collections\", \"vecmap\", \"vec_map\", \"contain-rs\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"vec_map\"\nreadme = \"README.md\"\nrepository = \"https://github.com/contain-rs/vec-map\"\nversion = \"0.8.1\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".vte."0.3.3" = mkRustCrate {
    inherit release profiles;
    name = "vte";
    version = "0.3.3";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "vte";
      version = "0.3.3";
      sha256 = "4f42f536e22f7fcbb407639765c8fd78707a33109301f834a594758bedd6e8cf";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      utf8parse = rustPackages."registry+https://github.com/rust-lang/crates.io-index".utf8parse."0.1.1" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Joe Wilm <joe@jwilm.com>\"]\ndescription = \"Parser for implementing terminal emulators\"\ndocumentation = \"https://docs.rs/vte/\"\nkeywords = [\"ansi\", \"vte\", \"parser\", \"terminal\"]\nlicense = \"Apache-2.0 OR MIT\"\nname = \"vte\"\nreadme = \"README.md\"\nrepository = \"https://github.com/jwilm/vte\"\nversion = \"0.3.3\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".walkdir."2.2.9" = mkRustCrate {
    inherit release profiles;
    name = "walkdir";
    version = "2.2.9";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "walkdir";
      version = "2.2.9";
      sha256 = "9658c94fa8b940eab2250bd5a457f9c48b748420d71293b165c8cdbe2f55f71e";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      same_file = rustPackages."registry+https://github.com/rust-lang/crates.io-index".same-file."1.0.5" { };
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { };
      ${ if hostPlatform.isWindows then "winapi_util" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi-util."0.1.2" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Andrew Gallant <jamslam@gmail.com>\"]\ncategories = [\"filesystem\"]\ndescription = \"Recursively walk a directory.\"\ndocumentation = \"https://docs.rs/walkdir/\"\nexclude = [\"/ci/*\", \"/.travis.yml\", \"/appveyor.yml\"]\nhomepage = \"https://github.com/BurntSushi/walkdir\"\nkeywords = [\"directory\", \"recursive\", \"walk\", \"iterator\"]\nlicense = \"Unlicense/MIT\"\nname = \"walkdir\"\nreadme = \"README.md\"\nrepository = \"https://github.com/BurntSushi/walkdir\"\nversion = \"2.2.9\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".wasi."0.7.0" = mkRustCrate {
    inherit release profiles;
    name = "wasi";
    version = "0.7.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "wasi";
      version = "0.7.0";
      sha256 = "b89c3ce4ce14bdc6fb6beaf9ec7928ca331de5df7e5ea278375642a2f478570d";
    };
    features = builtins.concatLists [
      [ "alloc" ]
      [ "default" ]
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"The Cranelift Project Developers\"]\ncategories = [\"no-std\", \"wasm\"]\ndescription = \"Experimental WASI API bindings for Rust\"\ndocumentation = \"https://docs.rs/wasi\"\nedition = \"2018\"\nkeywords = [\"webassembly\", \"wasm\"]\nlicense = \"Apache-2.0 WITH LLVM-exception OR Apache-2.0 OR MIT\"\nname = \"wasi\"\nreadme = \"README.md\"\nrepository = \"https://github.com/CraneStation/rust-wasi\"\nversion = \"0.7.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" = mkRustCrate {
    inherit release profiles;
    name = "winapi";
    version = "0.3.8";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "winapi";
      version = "0.3.8";
      sha256 = "8093091eeb260906a183e6ae1abdba2ef5ef2257a21801128899c3fc699229c6";
    };
    features = builtins.concatLists [
      [ "basetsd" ]
      [ "consoleapi" ]
      [ "errhandlingapi" ]
      [ "fileapi" ]
      [ "handleapi" ]
      [ "ioapiset" ]
      [ "jobapi" ]
      [ "jobapi2" ]
      [ "libloaderapi" ]
      [ "lmcons" ]
      [ "memoryapi" ]
      [ "minschannel" ]
      [ "minwinbase" ]
      [ "minwindef" ]
      [ "namedpipeapi" ]
      [ "ntdef" ]
      [ "ntstatus" ]
      [ "processenv" ]
      [ "processthreadsapi" ]
      [ "psapi" ]
      [ "schannel" ]
      [ "securitybaseapi" ]
      [ "shellapi" ]
      [ "sspi" ]
      [ "std" ]
      [ "synchapi" ]
      [ "sysinfoapi" ]
      [ "timezoneapi" ]
      [ "userenv" ]
      [ "winbase" ]
      [ "wincon" ]
      [ "wincrypt" ]
      [ "winerror" ]
      [ "winnt" ]
      [ "winsock2" ]
      [ "ws2def" ]
      [ "ws2ipdef" ]
      [ "ws2tcpip" ]
    ];
    dependencies = {
      ${ if hostPlatform.config == "i686-pc-windows-gnu" then "winapi_i686_pc_windows_gnu" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi-i686-pc-windows-gnu."0.4.0" { };
      ${ if hostPlatform.config == "x86_64-pc-windows-gnu" then "winapi_x86_64_pc_windows_gnu" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi-x86_64-pc-windows-gnu."0.4.0" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Peter Atashian <retep998@gmail.com>\"]\nbuild = \"build.rs\"\ncategories = [\"external-ffi-bindings\", \"no-std\", \"os::windows-apis\"]\ndescription = \"Raw FFI bindings for all of Windows API.\"\ndocumentation = \"https://docs.rs/winapi/*/x86_64-pc-windows-msvc/winapi/\"\ninclude = [\"/src/**/*\", \"/Cargo.toml\", \"/LICENSE-MIT\", \"/LICENSE-APACHE\", \"/build.rs\", \"/README.md\"]\nkeywords = [\"windows\", \"ffi\", \"win32\", \"com\", \"directx\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"winapi\"\nreadme = \"README.md\"\nrepository = \"https://github.com/retep998/winapi-rs\"\nversion = \"0.3.8\"\n[package.metadata.docs.rs]\ndefault-target = \"x86_64-pc-windows-msvc\"\nfeatures = [\"everything\", \"impl-debug\", \"impl-default\"]\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".winapi-i686-pc-windows-gnu."0.4.0" = mkRustCrate {
    inherit release profiles;
    name = "winapi-i686-pc-windows-gnu";
    version = "0.4.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "winapi-i686-pc-windows-gnu";
      version = "0.4.0";
      sha256 = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Peter Atashian <retep998@gmail.com>\"]\nbuild = \"build.rs\"\ndescription = \"Import libraries for the i686-pc-windows-gnu target. Please don\'t use this crate directly, depend on winapi instead.\"\ninclude = [\"src/*\", \"lib/*\", \"Cargo.toml\", \"build.rs\"]\nkeywords = [\"windows\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"winapi-i686-pc-windows-gnu\"\nrepository = \"https://github.com/retep998/winapi-rs\"\nversion = \"0.4.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".winapi-util."0.1.2" = mkRustCrate {
    inherit release profiles;
    name = "winapi-util";
    version = "0.1.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "winapi-util";
      version = "0.1.2";
      sha256 = "7168bab6e1daee33b4557efd0e95d5ca70a03706d39fa5f3fe7a236f584b03c9";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      ${ if hostPlatform.isWindows then "winapi" else null } = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Andrew Gallant <jamslam@gmail.com>\"]\ncategories = [\"os::windows-apis\", \"external-ffi-bindings\"]\ndescription = \"A dumping ground for high level safe wrappers over winapi.\"\ndocumentation = \"https://docs.rs/winapi-util\"\nhomepage = \"https://github.com/BurntSushi/winapi-util\"\nkeywords = [\"windows\", \"winapi\", \"util\", \"win\"]\nlicense = \"Unlicense/MIT\"\nname = \"winapi-util\"\nreadme = \"README.md\"\nrepository = \"https://github.com/BurntSushi/winapi-util\"\nversion = \"0.1.2\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".winapi-x86_64-pc-windows-gnu."0.4.0" = mkRustCrate {
    inherit release profiles;
    name = "winapi-x86_64-pc-windows-gnu";
    version = "0.4.0";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "winapi-x86_64-pc-windows-gnu";
      version = "0.4.0";
      sha256 = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[package]\nauthors = [\"Peter Atashian <retep998@gmail.com>\"]\nbuild = \"build.rs\"\ndescription = \"Import libraries for the x86_64-pc-windows-gnu target. Please don\'t use this crate directly, depend on winapi instead.\"\ninclude = [\"src/*\", \"lib/*\", \"Cargo.toml\", \"build.rs\"]\nkeywords = [\"windows\"]\nlicense = \"MIT/Apache-2.0\"\nname = \"winapi-x86_64-pc-windows-gnu\"\nrepository = \"https://github.com/retep998/winapi-rs\"\nversion = \"0.4.0\"\n";
  };
  
  "registry+https://github.com/rust-lang/crates.io-index".wincolor."1.0.2" = mkRustCrate {
    inherit release profiles;
    name = "wincolor";
    version = "1.0.2";
    registry = "registry+https://github.com/rust-lang/crates.io-index";
    src = fetchCratesIo {
      name = "wincolor";
      version = "1.0.2";
      sha256 = "96f5016b18804d24db43cebf3c77269e7569b8954a8464501c216cc5e070eaa9";
    };
    features = builtins.concatLists [
    ];
    dependencies = {
      winapi = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.8" { };
      winapi_util = rustPackages."registry+https://github.com/rust-lang/crates.io-index".winapi-util."0.1.2" { };
    };
    devDependencies = {
    };
    buildDependencies = {
    };
    manifest = builtins.fromTOML "[lib]\nbench = false\nname = \"wincolor\"\n\n[package]\nauthors = [\"Andrew Gallant <jamslam@gmail.com>\"]\ndescription = \"A simple Windows specific API for controlling text color in a Windows console.\\n\"\ndocumentation = \"https://docs.rs/wincolor\"\nhomepage = \"https://github.com/BurntSushi/termcolor/tree/master/wincolor\"\nkeywords = [\"windows\", \"win\", \"color\", \"ansi\", \"console\"]\nlicense = \"Unlicense OR MIT\"\nname = \"wincolor\"\nreadme = \"README.md\"\nrepository = \"https://github.com/BurntSushi/termcolor/tree/master/wincolor\"\nversion = \"1.0.2\"\n";
  };
  
}

