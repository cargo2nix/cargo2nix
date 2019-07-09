({
    pkgs
  , callPackage
  , mkRustCrate
  , config
  , ...
}:
  (self:
    {
      "registry+https://github.com/rust-lang/crates.io-index".cargo."0.36.0" = mkRustCrate {
        package-id = "cargo 0.36.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "cargo";
          version = "0.36.0";
          sha256 = "6b7b90c6394578417152b3bb74cd802f3a9ba00d6f8ac97d2ad9abeedc2c6c53";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "atty"
            ];
            extern-name = "atty";
            package-id = "atty 0.2.11 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "byteorder"
            ];
            extern-name = "byteorder";
            package-id = "byteorder 1.3.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "bytesize"
            ];
            extern-name = "bytesize";
            package-id = "bytesize 1.0.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "clap"
            ];
            extern-name = "clap";
            package-id = "clap 2.33.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "core-foundation"
            ];
            extern-name = "core_foundation";
            package-id = "core-foundation 0.6.4 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "crates-io"
            ];
            extern-name = "crates_io";
            package-id = "crates-io 0.24.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "crossbeam-utils"
            ];
            extern-name = "crossbeam_utils";
            package-id = "crossbeam-utils 0.6.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "crypto-hash"
            ];
            extern-name = "crypto_hash";
            package-id = "crypto-hash 0.3.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "curl"
            ];
            extern-name = "curl";
            package-id = "curl 0.4.22 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "curl-sys"
            ];
            extern-name = "curl_sys";
            package-id = "curl-sys 0.4.19 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "env_logger"
            ];
            extern-name = "env_logger";
            package-id = "env_logger 0.6.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "failure"
            ];
            extern-name = "failure";
            package-id = "failure 0.1.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "filetime"
            ];
            extern-name = "filetime";
            package-id = "filetime 0.2.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "flate2"
            ];
            extern-name = "flate2";
            package-id = "flate2 1.0.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "fs2"
            ];
            extern-name = "fs2";
            package-id = "fs2 0.4.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "fwdansi"
            ];
            extern-name = "fwdansi";
            package-id = "fwdansi 1.0.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "git2"
            ];
            extern-name = "git2";
            package-id = "git2 0.8.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "git2-curl"
            ];
            extern-name = "git2_curl";
            package-id = "git2-curl 0.9.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "glob"
            ];
            extern-name = "glob";
            package-id = "glob 0.3.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "hex"
            ];
            extern-name = "hex";
            package-id = "hex 0.3.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "home"
            ];
            extern-name = "home";
            package-id = "home 0.3.4 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "ignore"
            ];
            extern-name = "ignore";
            package-id = "ignore 0.4.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "im-rc"
            ];
            extern-name = "im_rc";
            package-id = "im-rc 12.3.4 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "jobserver"
            ];
            extern-name = "jobserver";
            package-id = "jobserver 0.1.14 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "lazy_static"
            ];
            extern-name = "lazy_static";
            package-id = "lazy_static 1.3.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "lazycell"
            ];
            extern-name = "lazycell";
            package-id = "lazycell 1.2.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libgit2-sys"
            ];
            extern-name = "libgit2_sys";
            package-id = "libgit2-sys 0.7.11 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "log"
            ];
            extern-name = "log";
            package-id = "log 0.4.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "miow"
            ];
            extern-name = "miow";
            package-id = "miow 0.3.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "num_cpus"
            ];
            extern-name = "num_cpus";
            package-id = "num_cpus 1.10.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "opener"
            ];
            extern-name = "opener";
            package-id = "opener 0.3.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rustc-workspace-hack"
            ];
            extern-name = "rustc_workspace_hack";
            package-id = "rustc-workspace-hack 1.0.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rustfix"
            ];
            extern-name = "rustfix";
            package-id = "rustfix 0.4.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "same-file"
            ];
            extern-name = "same_file";
            package-id = "same-file 1.0.4 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "semver"
            ];
            extern-name = "semver";
            package-id = "semver 0.9.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "serde"
            ];
            extern-name = "serde";
            package-id = "serde 1.0.92 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "serde_ignored"
            ];
            extern-name = "serde_ignored";
            package-id = "serde_ignored 0.0.4 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "serde_json"
            ];
            extern-name = "serde_json";
            package-id = "serde_json 1.0.39 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "shell-escape"
            ];
            extern-name = "shell_escape";
            package-id = "shell-escape 0.1.4 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tar"
            ];
            extern-name = "tar";
            package-id = "tar 0.4.26 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tempfile"
            ];
            extern-name = "tempfile";
            package-id = "tempfile 3.0.8 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "termcolor"
            ];
            extern-name = "termcolor";
            package-id = "termcolor 1.0.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "toml"
            ];
            extern-name = "toml";
            package-id = "toml 0.5.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "unicode-width"
            ];
            extern-name = "unicode_width";
            package-id = "unicode-width 0.1.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "url"
            ];
            extern-name = "url";
            package-id = "url 1.7.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "url_serde"
            ];
            extern-name = "url_serde";
            package-id = "url_serde 0.2.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "walkdir"
            ];
            extern-name = "walkdir";
            package-id = "walkdir 2.2.8 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            edition = "2018";
            name = "cargo";
            version = "0.36.0";
            authors = [
              "Yehuda Katz <wycats@gmail.com>"
              "Carl Lerche <me@carllerche.com>"
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "Cargo, a package manager for Rust.\n";
            homepage = "https://crates.io";
            documentation = "https://docs.rs/cargo";
            license = "MIT OR Apache-2.0";
            repository = "https://github.com/rust-lang/cargo";
          };
          lib = {
            name = "cargo";
            path = "src/cargo/lib.rs";
          };
          bin = [
            {
              name = "cargo";
              test = false;
              doc = false;
            }
          ];
          dependencies = {
            atty = {
              version = "0.2";
            };
            byteorder = {
              version = "1.2";
            };
            bytesize = {
              version = "1.0";
            };
            clap = {
              version = "2.31.2";
            };
            crates-io = {
              version = "0.24";
            };
            crossbeam-utils = {
              version = "0.6";
            };
            crypto-hash = {
              version = "0.3.1";
            };
            curl = {
              version = "0.4.19";
              features = [
                "http2"
              ];
            };
            curl-sys = {
              version = "0.4.15";
            };
            env_logger = {
              version = "0.6.0";
            };
            failure = {
              version = "0.1.5";
            };
            filetime = {
              version = "0.2";
            };
            flate2 = {
              version = "1.0.3";
              features = [
                "zlib"
              ];
            };
            fs2 = {
              version = "0.4";
            };
            git2 = {
              version = "0.8.0";
            };
            git2-curl = {
              version = "0.9.0";
            };
            glob = {
              version = "0.3.0";
            };
            hex = {
              version = "0.3";
            };
            home = {
              version = "0.3";
            };
            ignore = {
              version = "0.4";
            };
            im-rc = {
              version = "12.1.0";
            };
            jobserver = {
              version = "0.1.13";
            };
            lazy_static = {
              version = "1.2.0";
            };
            lazycell = {
              version = "1.2.0";
            };
            libc = {
              version = "0.2";
            };
            libgit2-sys = {
              version = "0.7.9";
            };
            log = {
              version = "0.4.6";
            };
            num_cpus = {
              version = "1.0";
            };
            opener = {
              version = "0.3.0";
            };
            openssl = {
              version = "0.10.11";
              optional = true;
            };
            pretty_env_logger = {
              version = "0.3";
              optional = true;
            };
            rustc-workspace-hack = {
              version = "1.0.0";
            };
            rustfix = {
              version = "0.4.4";
            };
            same-file = {
              version = "1";
            };
            semver = {
              version = "0.9.0";
              features = [
                "serde"
              ];
            };
            serde = {
              version = "1.0.82";
              features = [
                "derive"
              ];
            };
            serde_ignored = {
              version = "0.0.4";
            };
            serde_json = {
              version = "1.0.30";
              features = [
                "raw_value"
              ];
            };
            shell-escape = {
              version = "0.1.4";
            };
            tar = {
              version = "0.4.18";
              default-features = false;
            };
            tempfile = {
              version = "3.0";
            };
            termcolor = {
              version = "1.0";
            };
            toml = {
              version = "0.5.0";
            };
            unicode-width = {
              version = "0.1.5";
            };
            url = {
              version = "1.1";
            };
            url_serde = {
              version = "0.2.0";
            };
            walkdir = {
              version = "2.2";
            };
          };
          dev-dependencies = {
            bufstream = {
              version = "0.1";
            };
            proptest = {
              version = "0.9.1";
            };
          };
          features = {
            deny-warnings = [
            ];
            pretty-env-logger = [
              "pretty_env_logger"
            ];
            vendored-openssl = [
              "openssl/vendored"
            ];
          };
          target = {
            "cfg(target_os = \"macos\")" = {
              dependencies = {
                core-foundation = {
                  version = "0.6.0";
                  features = [
                    "mac_os_10_7_support"
                  ];
                };
              };
            };
            "cfg(windows)" = {
              dependencies = {
                fwdansi = {
                  version = "1";
                };
                miow = {
                  version = "0.3.1";
                };
                winapi = {
                  version = "0.3";
                  features = [
                    "basetsd"
                    "handleapi"
                    "jobapi"
                    "jobapi2"
                    "memoryapi"
                    "minwindef"
                    "ntdef"
                    "ntstatus"
                    "processenv"
                    "processthreadsapi"
                    "psapi"
                    "synchapi"
                    "winerror"
                    "winbase"
                    "wincon"
                    "winnt"
                  ];
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".tokio-threadpool."0.1.14" = mkRustCrate {
        package-id = "tokio-threadpool 0.1.14 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "tokio-threadpool";
          version = "0.1.14";
          sha256 = "72558af20be886ea124595ea0f806dd5703b8958e4705429dd58b3d8231f72f2";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "crossbeam-deque"
            ];
            extern-name = "crossbeam_deque";
            package-id = "crossbeam-deque 0.7.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "crossbeam-queue"
            ];
            extern-name = "crossbeam_queue";
            package-id = "crossbeam-queue 0.1.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "crossbeam-utils"
            ];
            extern-name = "crossbeam_utils";
            package-id = "crossbeam-utils 0.6.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "futures"
            ];
            extern-name = "futures";
            package-id = "futures 0.1.27 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "log"
            ];
            extern-name = "log";
            package-id = "log 0.4.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "num_cpus"
            ];
            extern-name = "num_cpus";
            package-id = "num_cpus 1.10.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rand"
            ];
            extern-name = "rand";
            package-id = "rand 0.6.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "slab"
            ];
            extern-name = "slab";
            package-id = "slab 0.4.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-executor"
            ];
            extern-name = "tokio_executor";
            package-id = "tokio-executor 0.1.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "tokio-threadpool";
            version = "0.1.14";
            authors = [
              "Carl Lerche <me@carllerche.com>"
            ];
            description = "A task scheduler backed by a work-stealing thread pool.\n";
            homepage = "https://github.com/tokio-rs/tokio";
            documentation = "https://docs.rs/tokio-threadpool/0.1.14/tokio_threadpool";
            keywords = [
              "futures"
              "tokio"
            ];
            categories = [
              "concurrency"
              "asynchronous"
            ];
            license = "MIT";
            repository = "https://github.com/tokio-rs/tokio";
          };
          dependencies = {
            crossbeam-deque = {
              version = "0.7.0";
            };
            crossbeam-queue = {
              version = "0.1.0";
            };
            crossbeam-utils = {
              version = "0.6.4";
            };
            futures = {
              version = "0.1.19";
            };
            log = {
              version = "0.4";
            };
            num_cpus = {
              version = "1.2";
            };
            rand = {
              version = "0.6";
            };
            slab = {
              version = "0.4.1";
            };
            tokio-executor = {
              version = "0.1.7";
            };
          };
          dev-dependencies = {
            env_logger = {
              version = "0.5";
            };
            futures-cpupool = {
              version = "0.1.7";
            };
            threadpool = {
              version = "1.7.1";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".matches."0.1.8" = mkRustCrate {
        package-id = "matches 0.1.8 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "matches";
          version = "0.1.8";
          sha256 = "7ffc5c5338469d4d3ea17d269fa8ea3512ad247247c30bd2df69e68309ed0a08";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "matches";
            version = "0.1.8";
            authors = [
              "Simon Sapin <simon.sapin@exyr.org>"
            ];
            description = "A macro to evaluate, as a boolean, whether an expression matches a pattern.";
            documentation = "https://docs.rs/matches/";
            license = "MIT";
            repository = "https://github.com/SimonSapin/rust-std-candidates";
          };
          lib = {
            name = "matches";
            path = "lib.rs";
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".rustfix."0.4.5" = mkRustCrate {
        package-id = "rustfix 0.4.5 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "rustfix";
          version = "0.4.5";
          sha256 = "b96ea6eeae40f488397ccc9e1c0da19d720b23c75972bc63eaa6852b84d161e2";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "failure"
            ];
            extern-name = "failure";
            package-id = "failure 0.1.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "log"
            ];
            extern-name = "log";
            package-id = "log 0.4.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "serde"
            ];
            extern-name = "serde";
            package-id = "serde 1.0.92 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "serde_derive"
            ];
            extern-name = "serde_derive";
            package-id = "serde_derive 1.0.92 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "serde_json"
            ];
            extern-name = "serde_json";
            package-id = "serde_json 1.0.39 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "rustfix";
            version = "0.4.5";
            authors = [
              "Pascal Hertleif <killercup@gmail.com>"
              "Oliver Schneider <oli-obk@users.noreply.github.com>"
            ];
            exclude = [
              "etc/*"
              "examples/*"
              "tests/*"
            ];
            description = "Automatically apply the suggestions made by rustc";
            documentation = "https://docs.rs/rustfix";
            readme = "Readme.md";
            license = "Apache-2.0/MIT";
            repository = "https://github.com/rust-lang-nursery/rustfix";
          };
          dependencies = {
            failure = {
              version = "0.1.2";
            };
            log = {
              version = "0.4.1";
            };
            serde = {
              version = "1.0";
            };
            serde_derive = {
              version = "1.0";
            };
            serde_json = {
              version = "1.0";
            };
          };
          dev-dependencies = {
            difference = {
              version = "2.0.0";
            };
            duct = {
              version = "0.9";
            };
            env_logger = {
              version = "0.5.0-rc.1";
            };
            log = {
              version = "0.4.1";
            };
            proptest = {
              version = "0.7.0";
            };
            tempdir = {
              version = "0.3.5";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".redox_termios."0.1.1" = mkRustCrate {
        package-id = "redox_termios 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "redox_termios";
          version = "0.1.1";
          sha256 = "7e891cfe48e9100a70a3b6eb652fef28920c117d366339687bd5576160db0f76";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "redox_syscall"
            ];
            extern-name = "syscall";
            package-id = "redox_syscall 0.1.54 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "redox_termios";
            version = "0.1.1";
            authors = [
              "Jeremy Soller <jackpot51@gmail.com>"
            ];
            description = "A Rust library to access Redox termios functions";
            documentation = "https://docs.rs/redox_termios";
            license = "MIT";
            repository = "https://github.com/redox-os/termios";
          };
          lib = {
            name = "redox_termios";
            path = "src/lib.rs";
          };
          dependencies = {
            redox_syscall = {
              version = "0.1";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".pkg-config."0.3.14" = mkRustCrate {
        package-id = "pkg-config 0.3.14 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "pkg-config";
          version = "0.3.14";
          sha256 = "676e8eb2b1b4c9043511a9b7bea0915320d7e502b0a079fb03f9635a5252b18c";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "pkg-config";
            version = "0.3.14";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "A library to run the pkg-config system tool at build time in order to be used in\nCargo build scripts.\n";
            documentation = "https://docs.rs/pkg-config";
            keywords = [
              "build-dependencies"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/pkg-config-rs";
          };
          dev-dependencies = {
            lazy_static = {
              version = "1";
            };
          };
          badges = {
            travis-ci = {
              repository = "alexcrichton/pkg-config-rs";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".serde_ignored."0.0.4" = mkRustCrate {
        package-id = "serde_ignored 0.0.4 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "serde_ignored";
          version = "0.0.4";
          sha256 = "190e9765dcedb56be63b6e0993a006c7e3b071a016a304736e4a315dc01fb142";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "serde"
            ];
            extern-name = "serde";
            package-id = "serde 1.0.92 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "serde_ignored";
            version = "0.0.4";
            authors = [
              "David Tolnay <dtolnay@gmail.com>"
            ];
            description = "Find out about keys that are ignored when deserializing data";
            keywords = [
              "serde"
            ];
            categories = [
              "encoding"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/dtolnay/serde-ignored";
          };
          dependencies = {
            serde = "1.0";
          };
          dev-dependencies = {
            serde_derive = "1.0";
            serde_json = "1.0";
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".smallvec."0.6.10" = mkRustCrate {
        package-id = "smallvec 0.6.10 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "smallvec";
          version = "0.6.10";
          sha256 = "ab606a9c5e214920bb66c458cd7be8ef094f813f20fe77a54cc7dbfff220d4b7";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "smallvec";
            version = "0.6.10";
            authors = [
              "Simon Sapin <simon.sapin@exyr.org>"
            ];
            description = "'Small vector' optimization: store up to a small number of items on the stack";
            documentation = "https://doc.servo.org/smallvec/";
            readme = "README.md";
            keywords = [
              "small"
              "vec"
              "vector"
              "stack"
              "no_std"
            ];
            categories = [
              "data-structures"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/servo/rust-smallvec";
          };
          lib = {
            name = "smallvec";
            path = "lib.rs";
          };
          dependencies = {
            serde = {
              version = "1";
              optional = true;
            };
          };
          dev-dependencies = {
            bincode = {
              version = "1.0.1";
            };
          };
          features = {
            default = [
              "std"
            ];
            may_dangle = [
            ];
            specialization = [
            ];
            std = [
            ];
            union = [
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".bstr."0.1.4" = mkRustCrate {
        package-id = "bstr 0.1.4 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "bstr";
          version = "0.1.4";
          sha256 = "59604ece62a407dc9164732e5adea02467898954c3a5811fd2dc140af14ef15b";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "memchr"
            ];
            extern-name = "memchr";
            package-id = "memchr 2.2.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "bstr";
            version = "0.1.4";
            authors = [
              "Andrew Gallant <jamslam@gmail.com>"
            ];
            exclude = [
              "/ci/*"
              "/.travis.yml"
              "/appveyor.yml"
            ];
            description = "A string type that is not required to be valid UTF-8.";
            homepage = "https://github.com/BurntSushi/bstr";
            documentation = "https://docs.rs/bstr";
            readme = "README.md";
            keywords = [
              "string"
              "str"
              "byte"
              "bytes"
              "text"
            ];
            categories = [
              "text-processing"
              "encoding"
            ];
            license = "MIT OR Apache-2.0";
            repository = "https://github.com/BurntSushi/bstr";
          };
          profile = {
            release = {
              debug = true;
            };
          };
          lib = {
            bench = false;
          };
          dependencies = {
            lazy_static = {
              version = "1.2";
              optional = true;
            };
            memchr = {
              version = "2.1.2";
              default-features = false;
            };
            regex-automata = {
              version = "0.1.5";
              optional = true;
              default-features = false;
            };
            serde = {
              version = "1.0.85";
              optional = true;
              default-features = false;
            };
          };
          dev-dependencies = {
            quickcheck = {
              version = "0.8.1";
              default-features = false;
            };
            ucd-parse = {
              version = "0.1.3";
            };
            unicode-segmentation = {
              version = "1.2.1";
            };
          };
          features = {
            default = [
              "std"
              "unicode"
            ];
            serde1 = [
              "std"
              "serde1-nostd"
              "serde/std"
            ];
            serde1-nostd = [
              "serde"
            ];
            std = [
              "memchr/use_std"
            ];
            unicode = [
              "lazy_static"
              "regex-automata"
            ];
          };
          badges = {
            appveyor = {
              repository = "BurntSushi/bstr";
            };
            travis-ci = {
              repository = "BurntSushi/bstr";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".curl."0.4.22" = mkRustCrate {
        package-id = "curl 0.4.22 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "curl";
          version = "0.4.22";
          sha256 = "f8ed9a22aa8c4e49ac0c896279ef532a43a7df2f54fcd19fa36960de029f965f";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "curl-sys"
            ];
            extern-name = "curl_sys";
            package-id = "curl-sys 0.4.19 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "kernel32-sys"
            ];
            extern-name = "kernel32";
            package-id = "kernel32-sys 0.2.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "openssl-probe"
            ];
            extern-name = "openssl_probe";
            package-id = "openssl-probe 0.1.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "openssl-sys"
            ];
            extern-name = "openssl_sys";
            package-id = "openssl-sys 0.9.47 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "schannel"
            ];
            extern-name = "schannel";
            package-id = "schannel 0.1.15 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "socket2"
            ];
            extern-name = "socket2";
            package-id = "socket2 0.3.9 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.2.8 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "curl";
            version = "0.4.22";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            autotests = true;
            description = "Rust bindings to libcurl for making HTTP requests";
            homepage = "https://github.com/alexcrichton/curl-rust";
            documentation = "https://docs.rs/curl";
            categories = [
              "api-bindings"
              "web-programming::http-client"
            ];
            license = "MIT";
            repository = "https://github.com/alexcrichton/curl-rust";
          };
          test = [
            {
              name = "atexit";
              harness = false;
            }
          ];
          dependencies = {
            curl-sys = {
              version = "0.4.18";
              default-features = false;
            };
            libc = {
              version = "0.2.42";
            };
            socket2 = {
              version = "0.3.7";
            };
          };
          dev-dependencies = {
            mio = {
              version = "0.6";
            };
            mio-extras = {
              version = "2.0.3";
            };
          };
          features = {
            default = [
              "ssl"
            ];
            force-system-lib-on-osx = [
              "curl-sys/force-system-lib-on-osx"
            ];
            http2 = [
              "curl-sys/http2"
            ];
            ssl = [
              "openssl-sys"
              "openssl-probe"
              "curl-sys/ssl"
            ];
            static-curl = [
              "curl-sys/static-curl"
            ];
            static-ssl = [
              "curl-sys/static-ssl"
            ];
          };
          target = {
            "cfg(all(unix, not(target_os = \"macos\")))" = {
              dependencies = {
                openssl-probe = {
                  version = "0.1.2";
                  optional = true;
                };
                openssl-sys = {
                  version = "0.9.43";
                  optional = true;
                };
              };
            };
            "cfg(target_env = \"msvc\")" = {
              dependencies = {
                kernel32-sys = {
                  version = "0.2.2";
                };
                schannel = {
                  version = "0.1.13";
                };
              };
            };
            "cfg(windows)" = {
              dependencies = {
                winapi = {
                  version = "0.2.7";
                };
              };
            };
          };
          badges = {
            appveyor = {
              repository = "alexcrichton/curl-rust";
            };
            travis-ci = {
              repository = "alexcrichton/curl-rust";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".bitflags."1.1.0" = mkRustCrate {
        package-id = "bitflags 1.1.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "bitflags";
          version = "1.1.0";
          sha256 = "3d155346769a6855b86399e9bc3814ab343cd3d62c7e985113d46a0ec3c281fd";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "bitflags";
            version = "1.1.0";
            authors = [
              "The Rust Project Developers"
            ];
            build = "build.rs";
            exclude = [
              ".travis.yml"
              "appveyor.yml"
              "bors.toml"
            ];
            description = "A macro to generate structures which behave like bitflags.\n";
            homepage = "https://github.com/bitflags/bitflags";
            documentation = "https://docs.rs/bitflags";
            readme = "README.md";
            keywords = [
              "bit"
              "bitmask"
              "bitflags"
              "flags"
            ];
            categories = [
              "no-std"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/bitflags/bitflags";
            metadata = {
              docs = {
                rs = {
                  features = [
                    "example_generated"
                  ];
                };
              };
            };
          };
          features = {
            default = [
            ];
            example_generated = [
            ];
          };
          badges = {
            travis-ci = {
              repository = "bitflags/bitflags";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".tempfile."3.0.8" = mkRustCrate {
        package-id = "tempfile 3.0.8 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "tempfile";
          version = "3.0.8";
          sha256 = "7dc4738f2e68ed2855de5ac9cdbe05c9216773ecde4739b2f095002ab03a13ef";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "cfg-if"
            ];
            extern-name = "cfg_if";
            package-id = "cfg-if 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rand"
            ];
            extern-name = "rand";
            package-id = "rand 0.6.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "redox_syscall"
            ];
            extern-name = "syscall";
            package-id = "redox_syscall 0.1.54 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "remove_dir_all"
            ];
            extern-name = "remove_dir_all";
            package-id = "remove_dir_all 0.5.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "tempfile";
            version = "3.0.8";
            authors = [
              "Steven Allen <steven@stebalien.com>"
              "The Rust Project Developers"
              "Ashley Mannix <ashleymannix@live.com.au>"
              "Jason White <jasonaw0@gmail.com>"
            ];
            exclude = [
              "/.travis.yml"
              "/appveyor.yml"
            ];
            description = "A library for managing temporary files and directories.\n";
            homepage = "http://stebalien.com/projects/tempfile-rs";
            documentation = "https://docs.rs/tempfile";
            keywords = [
              "tempfile"
              "tmpfile"
              "filesystem"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/Stebalien/tempfile";
          };
          dependencies = {
            cfg-if = {
              version = "0.1";
            };
            rand = {
              version = "0.6";
            };
            remove_dir_all = {
              version = "0.5";
            };
          };
          target = {
            "cfg(target_os = \"redox\")" = {
              dependencies = {
                redox_syscall = {
                  version = "0.1";
                };
              };
            };
            "cfg(unix)" = {
              dependencies = {
                libc = {
                  version = "0.2.27";
                };
              };
            };
            "cfg(windows)" = {
              dependencies = {
                winapi = {
                  version = "0.3";
                  features = [
                    "fileapi"
                    "winbase"
                    "handleapi"
                  ];
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".git2-curl."0.9.0" = mkRustCrate {
        package-id = "git2-curl 0.9.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "git2-curl";
          version = "0.9.0";
          sha256 = "d58551e903ed7e2d6fe3a2f3c7efa3a784ec29b19d0fbb035aaf0497c183fbdd";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "curl"
            ];
            extern-name = "curl";
            package-id = "curl 0.4.22 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "git2"
            ];
            extern-name = "git2";
            package-id = "git2 0.8.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "log"
            ];
            extern-name = "log";
            package-id = "log 0.4.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "url"
            ];
            extern-name = "url";
            package-id = "url 1.7.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "git2-curl";
            version = "0.9.0";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "Backend for an HTTP transport in libgit2 powered by libcurl.\n\nIntended to be used with the git2 crate.\n";
            homepage = "https://github.com/alexcrichton/git2-rs";
            documentation = "https://docs.rs/git2-curl";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/git2-rs";
          };
          test = [
            {
              name = "all";
              harness = false;
            }
          ];
          dependencies = {
            curl = {
              version = "0.4";
            };
            git2 = {
              version = "0.8";
              default-features = false;
            };
            log = {
              version = "0.4";
            };
            url = {
              version = "1.0";
            };
          };
          dev-dependencies = {
            civet = {
              version = "0.11";
            };
            conduit = {
              version = "0.8";
            };
            conduit-git-http-backend = {
              version = "0.8";
            };
            tempfile = {
              version = "3.0";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".wincolor."1.0.1" = mkRustCrate {
        package-id = "wincolor 1.0.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "wincolor";
          version = "1.0.1";
          sha256 = "561ed901ae465d6185fa7864d63fbd5720d0ef718366c9a4dc83cf6170d7e9ba";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi-util"
            ];
            extern-name = "winapi_util";
            package-id = "winapi-util 0.1.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "wincolor";
            version = "1.0.1";
            authors = [
              "Andrew Gallant <jamslam@gmail.com>"
            ];
            description = "A simple Windows specific API for controlling text color in a Windows console.\n";
            homepage = "https://github.com/BurntSushi/termcolor/tree/master/wincolor";
            documentation = "https://docs.rs/wincolor";
            readme = "README.md";
            keywords = [
              "windows"
              "win"
              "color"
              "ansi"
              "console"
            ];
            license = "Unlicense/MIT";
            repository = "https://github.com/BurntSushi/termcolor/tree/master/wincolor";
          };
          lib = {
            name = "wincolor";
            bench = false;
          };
          dependencies = {
            winapi = {
              version = "0.3";
              features = [
                "minwindef"
                "wincon"
              ];
            };
            winapi-util = {
              version = "0.1.1";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".arc-swap."0.3.11" = mkRustCrate {
        package-id = "arc-swap 0.3.11 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "arc-swap";
          version = "0.3.11";
          sha256 = "bc4662175ead9cd84451d5c35070517777949a2ed84551764129cedb88384841";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "arc-swap";
            version = "0.3.11";
            authors = [
              "Michal 'vorner' Vaner <vorner@vorner.cz>"
            ];
            description = "Atomically swappable Arc";
            documentation = "https://docs.rs/arc-swap";
            readme = "README.md";
            keywords = [
              "atomic"
              "Arc"
            ];
            categories = [
              "data-structures"
              "memory-management"
            ];
            license = "Apache-2.0/MIT";
            repository = "https://github.com/vorner/arc-swap";
          };
          profile = {
            bench = {
              debug = true;
            };
          };
          bench = [
            {
              name = "atomics";
              path = "benches/atomics.rs";
            }
            {
              name = "background";
              path = "benches/background.rs";
            }
            {
              name = "int-access";
              path = "benches/int-access.rs";
              harness = false;
            }
          ];
          dependencies = {
          };
          dev-dependencies = {
            crossbeam = {
              version = "~0.5";
            };
            crossbeam-utils = {
              version = "~0.6";
            };
            itertools = {
              version = "~0.8";
            };
            lazy_static = {
              version = "~1";
            };
            model = {
              version = "~0.0.4";
            };
            num_cpus = {
              version = "~1";
            };
            parking_lot = {
              version = "~0.7";
            };
            proptest = {
              version = "~0.7";
            };
            version-sync = {
              version = "~0.7";
            };
          };
          badges = {
            appveyor = {
              repository = "vorner/arc-swap";
            };
            maintenance = {
              status = "actively-developed";
            };
            travis-ci = {
              repository = "vorner/arc-swap";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".termcolor."1.0.5" = mkRustCrate {
        package-id = "termcolor 1.0.5 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "termcolor";
          version = "1.0.5";
          sha256 = "96d6098003bde162e4277c70665bd87c326f5a0c3f3fbfb285787fa482d54e6e";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "wincolor"
            ];
            extern-name = "wincolor";
            package-id = "wincolor 1.0.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "termcolor";
            version = "1.0.5";
            authors = [
              "Andrew Gallant <jamslam@gmail.com>"
            ];
            exclude = [
              "/.travis.yml"
              "/appveyor.yml"
              "/ci/**"
            ];
            description = "A simple cross platform library for writing colored text to a terminal.\n";
            homepage = "https://github.com/BurntSushi/termcolor";
            documentation = "https://docs.rs/termcolor";
            readme = "README.md";
            keywords = [
              "windows"
              "win"
              "color"
              "ansi"
              "console"
            ];
            license = "Unlicense OR MIT";
            repository = "https://github.com/BurntSushi/termcolor";
          };
          lib = {
            name = "termcolor";
            bench = false;
          };
          target = {
            "cfg(windows)" = {
              dependencies = {
                wincolor = {
                  version = "1";
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".tokio-io."0.1.12" = mkRustCrate {
        package-id = "tokio-io 0.1.12 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "tokio-io";
          version = "0.1.12";
          sha256 = "5090db468dad16e1a7a54c8c67280c5e4b544f3d3e018f0b913b400261f85926";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "bytes"
            ];
            extern-name = "bytes";
            package-id = "bytes 0.4.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "futures"
            ];
            extern-name = "futures";
            package-id = "futures 0.1.27 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "log"
            ];
            extern-name = "log";
            package-id = "log 0.4.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "tokio-io";
            version = "0.1.12";
            authors = [
              "Carl Lerche <me@carllerche.com>"
            ];
            description = "Core I/O primitives for asynchronous I/O in Rust.\n";
            homepage = "https://tokio.rs";
            documentation = "https://docs.rs/tokio-io/0.1.12/tokio_io";
            categories = [
              "asynchronous"
            ];
            license = "MIT";
            repository = "https://github.com/tokio-rs/tokio";
          };
          dependencies = {
            bytes = {
              version = "0.4.7";
            };
            futures = {
              version = "0.1.18";
            };
            log = {
              version = "0.4";
            };
          };
          dev-dependencies = {
            tokio-current-thread = {
              version = "0.1.1";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".mio-named-pipes."0.1.6" = mkRustCrate {
        package-id = "mio-named-pipes 0.1.6 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "mio-named-pipes";
          version = "0.1.6";
          sha256 = "f5e374eff525ce1c5b7687c4cef63943e7686524a387933ad27ca7ec43779cb3";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "log"
            ];
            extern-name = "log";
            package-id = "log 0.4.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "mio"
            ];
            extern-name = "mio";
            package-id = "mio 0.6.19 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "miow"
            ];
            extern-name = "miow";
            package-id = "miow 0.3.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "mio-named-pipes";
            version = "0.1.6";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "Windows named pipe bindings for mio.\n";
            homepage = "https://github.com/alexcrichton/mio-named-pipes";
            documentation = "https://docs.rs/mio-named-pipes/0.1/x86_64-pc-windows-msvc/mio_named_pipes/";
            readme = "README.md";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/mio-named-pipes";
          };
          dev-dependencies = {
            env_logger = {
              version = "0.4";
              default-features = false;
            };
            rand = {
              version = "0.4";
            };
          };
          target = {
            "cfg(windows)" = {
              dependencies = {
                log = {
                  version = "0.4";
                };
                mio = {
                  version = "0.6.5";
                };
                miow = {
                  version = "0.3";
                };
                winapi = {
                  version = "0.3";
                  features = [
                    "winerror"
                    "ioapiset"
                    "minwinbase"
                    "winbase"
                  ];
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".libgit2-sys."0.7.11" = mkRustCrate {
        package-id = "libgit2-sys 0.7.11 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "libgit2-sys";
          version = "0.7.11";
          sha256 = "48441cb35dc255da8ae72825689a95368bf510659ae1ad55dc4aa88cb1789bf1";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "cc"
              "cc"
            ];
            extern-name = "cc";
            package-id = "cc 1.0.37 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "curl-sys"
            ];
            extern-name = "curl_sys";
            package-id = "curl-sys 0.4.19 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libssh2-sys"
            ];
            extern-name = "libssh2_sys";
            package-id = "libssh2-sys 0.2.11 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libz-sys"
              "libz-sys"
            ];
            extern-name = "libz_sys";
            package-id = "libz-sys 1.0.25 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "openssl-sys"
            ];
            extern-name = "openssl_sys";
            package-id = "openssl-sys 0.9.47 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "pkg-config"
              "pkg-config"
            ];
            extern-name = "pkg_config";
            package-id = "pkg-config 0.3.14 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "libgit2-sys";
            version = "0.7.11";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            build = "build.rs";
            links = "git2";
            exclude = [
              "libgit2/tests/*"
            ];
            description = "Native bindings to the libgit2 library";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/git2-rs";
          };
          lib = {
            name = "libgit2_sys";
            path = "lib.rs";
          };
          dependencies = {
            curl-sys = {
              version = "0.4.10";
              optional = true;
            };
            libc = {
              version = "0.2";
            };
            libssh2-sys = {
              version = "0.2.11";
              optional = true;
            };
            libz-sys = {
              version = "1.0.22";
            };
          };
          build-dependencies = {
            cc = {
              version = "1.0.25";
            };
            pkg-config = {
              version = "0.3";
            };
          };
          features = {
            curl = [
              "curl-sys"
            ];
            https = [
              "openssl-sys"
            ];
            ssh = [
              "libssh2-sys"
            ];
            ssh_key_from_memory = [
            ];
          };
          target = {
            "cfg(unix)" = {
              dependencies = {
                openssl-sys = {
                  version = "0.9";
                  optional = true;
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".rustc-workspace-hack."1.0.0" = mkRustCrate {
        package-id = "rustc-workspace-hack 1.0.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "rustc-workspace-hack";
          version = "1.0.0";
          sha256 = "fc71d2faa173b74b232dedc235e3ee1696581bb132fc116fa3626d6151a1a8fb";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "rustc-workspace-hack";
            version = "1.0.0";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "Hack for the compiler's own build system\n";
            license = "MIT/Apache-2.0";
          };
          dependencies = {
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".miniz_oxide."0.2.1" = mkRustCrate {
        package-id = "miniz_oxide 0.2.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "miniz_oxide";
          version = "0.2.1";
          sha256 = "c468f2369f07d651a5d0bb2c9079f8488a66d5466efe42d0c5c6466edcb7f71e";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "adler32"
            ];
            extern-name = "adler32";
            package-id = "adler32 1.0.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "miniz_oxide";
            version = "0.2.1";
            authors = [
              "Frommi <daniil.liferenko@gmail.com>"
            ];
            description = "DEFLATE compression and decompression library rewritten in Rust based on miniz";
            homepage = "https://github.com/Frommi/miniz_oxide/tree/master/miniz_oxide";
            documentation = "https://docs.rs/miniz_oxide";
            readme = "Readme.md";
            keywords = [
              "zlib"
              "miniz"
              "deflate"
              "encoding"
            ];
            categories = [
              "compression"
            ];
            license = "MIT";
            repository = "https://github.com/Frommi/miniz_oxide/tree/master/miniz_oxide";
          };
          lib = {
            name = "miniz_oxide";
          };
          dependencies = {
            adler32 = {
              version = "1.0.2";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".flate2."1.0.7" = mkRustCrate {
        package-id = "flate2 1.0.7 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "flate2";
          version = "1.0.7";
          sha256 = "f87e68aa82b2de08a6e037f1385455759df6e445a8df5e005b4297191dbf18aa";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "crc32fast"
            ];
            extern-name = "crc32fast";
            package-id = "crc32fast 1.2.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libz-sys"
            ];
            extern-name = "libz_sys";
            package-id = "libz-sys 1.0.25 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "miniz-sys"
            ];
            extern-name = "miniz_sys";
            package-id = "miniz-sys 0.1.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "miniz_oxide_c_api"
            ];
            extern-name = "miniz_oxide_c_api";
            package-id = "miniz_oxide_c_api 0.2.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "flate2";
            version = "1.0.7";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "Bindings to miniz.c for DEFLATE compression and decompression exposed as\nReader/Writer streams. Contains bindings for zlib, deflate, and gzip-based\nstreams.\n";
            homepage = "https://github.com/alexcrichton/flate2-rs";
            documentation = "https://docs.rs/flate2";
            readme = "README.md";
            keywords = [
              "gzip"
              "flate"
              "zlib"
              "encoding"
            ];
            categories = [
              "compression"
              "api-bindings"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/flate2-rs";
          };
          dependencies = {
            crc32fast = {
              version = "1.1";
            };
            futures = {
              version = "0.1.25";
              optional = true;
            };
            libc = {
              version = "0.2";
            };
            libz-sys = {
              version = "1.0";
              optional = true;
            };
            miniz-sys = {
              version = "0.1.11";
              optional = true;
            };
            miniz_oxide_c_api = {
              version = "0.2";
              features = [
                "no_c_export"
              ];
              optional = true;
            };
            tokio-io = {
              version = "0.1.11";
              optional = true;
            };
          };
          dev-dependencies = {
            futures = {
              version = "0.1";
            };
            quickcheck = {
              version = "0.7";
              default-features = false;
            };
            rand = {
              version = "0.6";
            };
            tokio-io = {
              version = "0.1.11";
            };
            tokio-tcp = {
              version = "0.1.3";
            };
            tokio-threadpool = {
              version = "0.1.10";
            };
          };
          features = {
            default = [
              "miniz-sys"
            ];
            rust_backend = [
              "miniz_oxide_c_api"
            ];
            tokio = [
              "tokio-io"
              "futures"
            ];
            zlib = [
              "libz-sys"
            ];
          };
          target = {
            "cfg(all(target_arch = \"wasm32\", not(target_os = \"emscripten\")))" = {
              dependencies = {
                miniz_oxide_c_api = {
                  version = "0.2";
                  features = [
                    "no_c_export"
                  ];
                };
              };
            };
          };
          badges = {
            appveyor = {
              repository = "alexcrichton/flate2-rs";
            };
            travis-ci = {
              repository = "alexcrichton/flate2-rs";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".sized-chunks."0.1.3" = mkRustCrate {
        package-id = "sized-chunks 0.1.3 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "sized-chunks";
          version = "0.1.3";
          sha256 = "9d3e7f23bad2d6694e0f46f5e470ec27eb07b8f3e8b309a4b0dc17501928b9f2";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "typenum"
            ];
            extern-name = "typenum";
            package-id = "typenum 1.10.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            edition = "2018";
            name = "sized-chunks";
            version = "0.1.3";
            authors = [
              "Bodil Stokke <bodil@bodil.org>"
            ];
            exclude = [
              "release.toml"
              "proptest-regressions/**"
            ];
            description = "Efficient sized chunk datatypes";
            documentation = "http://docs.rs/sized-chunks";
            readme = "./README.md";
            keywords = [
              "sparse-array"
            ];
            categories = [
              "data-structures"
            ];
            license = "MPL-2.0+";
            repository = "https://github.com/bodil/sized-chunks";
          };
          dependencies = {
            typenum = {
              version = "1.10.0";
            };
          };
          dev-dependencies = {
            proptest = {
              version = "0.9.1";
            };
            proptest-derive = {
              version = "0.1.0";
            };
          };
          badges = {
            travis-ci = {
              repository = "bodil/sized-chunks";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".nodrop."0.1.13" = mkRustCrate {
        package-id = "nodrop 0.1.13 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "nodrop";
          version = "0.1.13";
          sha256 = "2f9667ddcc6cc8a43afc9b7917599d7216aa09c463919ea32c59ed6cac8bc945";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "nodrop";
            version = "0.1.13";
            authors = [
              "bluss"
            ];
            description = "A wrapper type to inhibit drop (destructor). Use std::mem::ManuallyDrop instead!";
            documentation = "https://docs.rs/nodrop/";
            keywords = [
              "container"
              "drop"
              "no_std"
            ];
            categories = [
              "rust-patterns"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/bluss/arrayvec";
            metadata = {
              release = {
                no-dev-version = true;
              };
            };
          };
          dependencies = {
            nodrop-union = {
              version = "0.1.8";
              optional = true;
            };
          };
          features = {
            default = [
              "std"
            ];
            std = [
            ];
            use_needs_drop = [
            ];
            use_union = [
              "nodrop-union"
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".lock_api."0.1.5" = mkRustCrate {
        package-id = "lock_api 0.1.5 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "lock_api";
          version = "0.1.5";
          sha256 = "62ebf1391f6acad60e5c8b43706dde4582df75c06698ab44511d15016bc2442c";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "owning_ref"
            ];
            extern-name = "owning_ref";
            package-id = "owning_ref 0.4.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "scopeguard"
            ];
            extern-name = "scopeguard";
            package-id = "scopeguard 0.3.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "lock_api";
            version = "0.1.5";
            authors = [
              "Amanieu d'Antras <amanieu@gmail.com>"
            ];
            description = "Wrappers to create fully-featured Mutex and RwLock types. Compatible with no_std.";
            keywords = [
              "mutex"
              "rwlock"
              "lock"
              "no_std"
            ];
            categories = [
              "concurrency"
              "no-std"
            ];
            license = "Apache-2.0/MIT";
            repository = "https://github.com/Amanieu/parking_lot";
          };
          dependencies = {
            owning_ref = {
              version = "0.4";
              optional = true;
            };
            scopeguard = {
              version = "0.3";
              default-features = false;
            };
          };
          features = {
            nightly = [
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".rustc-demangle."0.1.15" = mkRustCrate {
        package-id = "rustc-demangle 0.1.15 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "rustc-demangle";
          version = "0.1.15";
          sha256 = "a7f4dccf6f4891ebcc0c39f9b6eb1a83b9bf5d747cb439ec6fba4f3b977038af";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "rustc-demangle";
            version = "0.1.15";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "Rust compiler symbol demangling.\n";
            homepage = "https://github.com/alexcrichton/rustc-demangle";
            documentation = "https://docs.rs/rustc-demangle";
            readme = "README.md";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/rustc-demangle";
          };
          dependencies = {
            compiler_builtins = {
              version = "0.1.2";
              optional = true;
            };
            core = {
              version = "1.0.0";
              optional = true;
              package = "rustc-std-workspace-core";
            };
          };
          features = {
            rustc-dep-of-std = [
              "core"
              "compiler_builtins"
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".jobserver."0.1.14" = mkRustCrate {
        package-id = "jobserver 0.1.14 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "jobserver";
          version = "0.1.14";
          sha256 = "680de885fb4b562691e35943978a85fa6401197014a4bf545d92510073fa41df";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "log"
            ];
            extern-name = "log";
            package-id = "log 0.4.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rand"
            ];
            extern-name = "rand";
            package-id = "rand 0.6.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "jobserver";
            version = "0.1.14";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "An implementation of the GNU make jobserver for Rust\n";
            homepage = "https://github.com/alexcrichton/jobserver-rs";
            documentation = "https://docs.rs/jobserver";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/jobserver-rs";
          };
          test = [
            {
              name = "client";
              path = "tests/client.rs";
              harness = false;
            }
            {
              name = "server";
              path = "tests/server.rs";
            }
            {
              name = "client-of-myself";
              path = "tests/client-of-myself.rs";
              harness = false;
            }
            {
              name = "make-as-a-client";
              path = "tests/make-as-a-client.rs";
              harness = false;
            }
            {
              name = "helper";
              path = "tests/helper.rs";
            }
          ];
          dependencies = {
            log = {
              version = "0.4.6";
            };
          };
          dev-dependencies = {
            futures = {
              version = "0.1";
            };
            num_cpus = {
              version = "1.0";
            };
            tempdir = {
              version = "0.3";
            };
            tokio-core = {
              version = "0.1";
            };
            tokio-process = {
              version = "0.2";
            };
          };
          target = {
            "cfg(unix)" = {
              dependencies = {
                libc = {
                  version = "0.2.50";
                };
              };
            };
            "cfg(windows)" = {
              dependencies = {
                rand = {
                  version = "0.6.5";
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".termion."1.5.3" = mkRustCrate {
        package-id = "termion 1.5.3 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "termion";
          version = "1.5.3";
          sha256 = "6a8fb22f7cde82c8220e5aeacb3258ed7ce996142c77cba193f203515e26c330";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "numtoa"
            ];
            extern-name = "numtoa";
            package-id = "numtoa 0.1.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "redox_syscall"
            ];
            extern-name = "syscall";
            package-id = "redox_syscall 0.1.54 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "redox_termios"
            ];
            extern-name = "redox_termios";
            package-id = "redox_termios 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "termion";
            version = "1.5.3";
            authors = [
              "ticki <Ticki@users.noreply.github.com>"
              "gycos <alexandre.bury@gmail.com>"
              "IGI-111 <igi-111@protonmail.com>"
            ];
            exclude = [
              "target"
              "CHANGELOG.md"
              "image.png"
              "Cargo.lock"
            ];
            description = "A bindless library for manipulating terminals.";
            documentation = "https://docs.rs/termion";
            keywords = [
              "tty"
              "color"
              "terminal"
              "password"
              "tui"
            ];
            license = "MIT";
            repository = "https://gitlab.redox-os.org/redox-os/termion";
          };
          dependencies = {
            numtoa = {
              version = "0.1.0";
              features = [
                "std"
              ];
            };
          };
          target = {
            "cfg(not(target_os = \"redox\"))" = {
              dependencies = {
                libc = {
                  version = "0.2.8";
                };
              };
            };
            "cfg(target_os = \"redox\")" = {
              dependencies = {
                redox_syscall = {
                  version = "0.1";
                };
                redox_termios = {
                  version = "0.1";
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".serde_derive."1.0.92" = mkRustCrate {
        package-id = "serde_derive 1.0.92 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "serde_derive";
          version = "1.0.92";
          sha256 = "46a3223d0c9ba936b61c0d2e3e559e3217dbfb8d65d06d26e8b3c25de38bae3e";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "proc-macro2"
            ];
            extern-name = "proc_macro2";
            package-id = "proc-macro2 0.4.30 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "quote"
            ];
            extern-name = "quote";
            package-id = "quote 0.6.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "syn"
            ];
            extern-name = "syn";
            package-id = "syn 0.15.36 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "serde_derive";
            version = "1.0.92";
            authors = [
              "Erick Tryzelaar <erick.tryzelaar@gmail.com>"
              "David Tolnay <dtolnay@gmail.com>"
            ];
            include = [
              "Cargo.toml"
              "src/**/*.rs"
              "crates-io.md"
              "README.md"
              "LICENSE-APACHE"
              "LICENSE-MIT"
            ];
            description = "Macros 1.1 implementation of #[derive(Serialize, Deserialize)]";
            homepage = "https://serde.rs";
            documentation = "https://serde.rs/derive.html";
            readme = "crates-io.md";
            keywords = [
              "serde"
              "serialization"
              "no_std"
            ];
            license = "MIT OR Apache-2.0";
            repository = "https://github.com/serde-rs/serde";
          };
          lib = {
            name = "serde_derive";
            proc-macro = true;
          };
          dependencies = {
            proc-macro2 = {
              version = "0.4";
            };
            quote = {
              version = "0.6.3";
            };
            syn = {
              version = "0.15.22";
              features = [
                "visit"
              ];
            };
          };
          dev-dependencies = {
            serde = {
              version = "1.0";
            };
          };
          features = {
            default = [
            ];
            deserialize_in_place = [
            ];
          };
          badges = {
            appveyor = {
              repository = "serde-rs/serde";
            };
            travis-ci = {
              repository = "serde-rs/serde";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".cloudabi."0.0.3" = mkRustCrate {
        package-id = "cloudabi 0.0.3 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "cloudabi";
          version = "0.0.3";
          sha256 = "ddfc5b9aa5d4507acaf872de71051dfd0e309860e88966e1051e462a077aac4f";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "bitflags"
            ];
            extern-name = "bitflags";
            package-id = "bitflags 1.1.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "cloudabi";
            version = "0.0.3";
            authors = [
              "Nuxi (https://nuxi.nl/) and contributors"
            ];
            description = "Low level interface to CloudABI. Contains all syscalls and related types.";
            homepage = "https://nuxi.nl/cloudabi/";
            documentation = "https://docs.rs/cloudabi/";
            keywords = [
              "cloudabi"
            ];
            license = "BSD-2-Clause";
            repository = "https://github.com/nuxinl/cloudabi";
          };
          lib = {
            path = "cloudabi.rs";
          };
          dependencies = {
            bitflags = {
              version = "1.0";
              optional = true;
            };
          };
          features = {
            default = [
              "bitflags"
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".openssl-probe."0.1.2" = mkRustCrate {
        package-id = "openssl-probe 0.1.2 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "openssl-probe";
          version = "0.1.2";
          sha256 = "77af24da69f9d9341038eba93a073b1fdaaa1b788221b00a69bce9e762cb32de";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "openssl-probe";
            version = "0.1.2";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "Tool for helping to find SSL certificate locations on the system for OpenSSL\n";
            homepage = "https://github.com/alexcrichton/openssl-probe";
            readme = "README.md";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/openssl-probe";
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".stable_deref_trait."1.1.1" = mkRustCrate {
        package-id = "stable_deref_trait 1.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "stable_deref_trait";
          version = "1.1.1";
          sha256 = "dba1a27d3efae4351c8051072d619e3ade2820635c3958d826bfea39d59b54c8";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "stable_deref_trait";
            version = "1.1.1";
            authors = [
              "Robert Grosse <n210241048576@gmail.com>"
            ];
            description = "An unsafe marker trait for types like Box and Rc that dereference to a stable address even when moved, and hence can be used with libraries such as owning_ref and rental.\n";
            documentation = "https://docs.rs/stable_deref_trait/1.1.1/stable_deref_trait";
            readme = "README.md";
            categories = [
              "memory-management"
              "no-std"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/storyyeller/stable_deref_trait";
          };
          features = {
            alloc = [
            ];
            default = [
              "std"
            ];
            std = [
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".tokio-codec."0.1.1" = mkRustCrate {
        package-id = "tokio-codec 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "tokio-codec";
          version = "0.1.1";
          sha256 = "5c501eceaf96f0e1793cf26beb63da3d11c738c4a943fdf3746d81d64684c39f";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "bytes"
            ];
            extern-name = "bytes";
            package-id = "bytes 0.4.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "futures"
            ];
            extern-name = "futures";
            package-id = "futures 0.1.27 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-io"
            ];
            extern-name = "tokio_io";
            package-id = "tokio-io 0.1.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "tokio-codec";
            version = "0.1.1";
            authors = [
              "Carl Lerche <me@carllerche.com>"
              "Bryan Burgers <bryan@burgers.io>"
            ];
            description = "Utilities for encoding and decoding frames.\n";
            homepage = "https://tokio.rs";
            documentation = "https://docs.rs/tokio-codec/0.1.1/tokio_codec";
            categories = [
              "asynchronous"
            ];
            license = "MIT";
            repository = "https://github.com/tokio-rs/tokio";
          };
          dependencies = {
            bytes = {
              version = "0.4.7";
            };
            futures = {
              version = "0.1.18";
            };
            tokio-io = {
              version = "0.1.7";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".vcpkg."0.2.6" = mkRustCrate {
        package-id = "vcpkg 0.2.6 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "vcpkg";
          version = "0.2.6";
          sha256 = "def296d3eb3b12371b2c7d0e83bfe1403e4db2d7a0bba324a12b21c4ee13143d";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "vcpkg";
            version = "0.2.6";
            authors = [
              "Jim McGrath <jimmc2@gmail.com>"
            ];
            description = "A library to find native dependencies in a vcpkg tree at build\ntime in order to be used in Cargo build scripts.\n";
            documentation = "https://docs.rs/vcpkg";
            readme = "../README.md";
            keywords = [
              "build-dependencies"
              "windows"
              "ffi"
              "win32"
            ];
            categories = [
              "os::windows-apis"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/mcgoo/vcpkg-rs";
          };
          dependencies = {
          };
          dev-dependencies = {
            lazy_static = {
              version = "1";
            };
            tempdir = {
              version = "0.3.7";
            };
          };
          badges = {
            appveyor = {
              branch = "master";
              repository = "mcgoo/vcpkg-rs";
              service = "github";
            };
            travis-ci = {
              branch = "master";
              repository = "mcgoo/vcpkg-rs";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".fuchsia-zircon."0.3.3" = mkRustCrate {
        package-id = "fuchsia-zircon 0.3.3 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "fuchsia-zircon";
          version = "0.3.3";
          sha256 = "2e9763c69ebaae630ba35f74888db465e49e259ba1bc0eda7d06f4a067615d82";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "bitflags"
            ];
            extern-name = "bitflags";
            package-id = "bitflags 1.1.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "fuchsia-zircon-sys"
            ];
            extern-name = "fuchsia_zircon_sys";
            package-id = "fuchsia-zircon-sys 0.3.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "fuchsia-zircon";
            version = "0.3.3";
            authors = [
              "Raph Levien <raph@google.com>"
            ];
            description = "Rust bindings for the Zircon kernel";
            license = "BSD-3-Clause";
            repository = "https://fuchsia.googlesource.com/garnet/";
          };
          dependencies = {
            bitflags = {
              version = "1.0.0";
            };
            fuchsia-zircon-sys = {
              version = "0.3.3";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".mio."0.6.19" = mkRustCrate {
        package-id = "mio 0.6.19 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "mio";
          version = "0.6.19";
          sha256 = "83f51996a3ed004ef184e16818edc51fadffe8e7ca68be67f9dee67d84d0ff23";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "fuchsia-zircon"
            ];
            extern-name = "fuchsia_zircon";
            package-id = "fuchsia-zircon 0.3.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "fuchsia-zircon-sys"
            ];
            extern-name = "fuchsia_zircon_sys";
            package-id = "fuchsia-zircon-sys 0.3.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "iovec"
            ];
            extern-name = "iovec";
            package-id = "iovec 0.1.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "kernel32-sys"
            ];
            extern-name = "kernel32";
            package-id = "kernel32-sys 0.2.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "log"
            ];
            extern-name = "log";
            package-id = "log 0.4.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "miow"
            ];
            extern-name = "miow";
            package-id = "miow 0.2.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "net2"
            ];
            extern-name = "net2";
            package-id = "net2 0.2.33 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "slab"
            ];
            extern-name = "slab";
            package-id = "slab 0.4.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.2.8 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "mio";
            version = "0.6.19";
            authors = [
              "Carl Lerche <me@carllerche.com>"
            ];
            exclude = [
              ".gitignore"
              ".travis.yml"
              "deploy.sh"
            ];
            description = "Lightweight non-blocking IO";
            homepage = "https://github.com/carllerche/mio";
            documentation = "https://docs.rs/mio/0.6.19/mio/";
            readme = "README.md";
            keywords = [
              "io"
              "async"
              "non-blocking"
            ];
            categories = [
              "asynchronous"
            ];
            license = "MIT";
            repository = "https://github.com/carllerche/mio";
          };
          test = [
            {
              name = "test";
              path = "test/mod.rs";
            }
          ];
          dependencies = {
            iovec = {
              version = "0.1.1";
            };
            log = {
              version = "0.4";
            };
            net2 = {
              version = "0.2.29";
            };
            slab = {
              version = "0.4.0";
            };
          };
          dev-dependencies = {
            bytes = {
              version = "0.3.0";
            };
            env_logger = {
              version = "0.4.0";
              default-features = false;
            };
            tempdir = {
              version = "0.3.4";
            };
          };
          features = {
            default = [
              "with-deprecated"
            ];
            with-deprecated = [
            ];
          };
          target = {
            "cfg(target_os = \"fuchsia\")" = {
              dependencies = {
                fuchsia-zircon = {
                  version = "0.3.2";
                };
                fuchsia-zircon-sys = {
                  version = "0.3.2";
                };
              };
            };
            "cfg(unix)" = {
              dependencies = {
                libc = {
                  version = "0.2.42";
                };
              };
            };
            "cfg(windows)" = {
              dependencies = {
                kernel32-sys = {
                  version = "0.2";
                };
                miow = {
                  version = "0.2.1";
                };
                winapi = {
                  version = "0.2.6";
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".ansi_term."0.11.0" = mkRustCrate {
        package-id = "ansi_term 0.11.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "ansi_term";
          version = "0.11.0";
          sha256 = "ee49baf6cb617b853aa8d93bf420db2383fab46d314482ca2803b40d5fde979b";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "ansi_term";
            version = "0.11.0";
            authors = [
              "ogham@bsago.me"
              "Ryan Scheel (Havvy) <ryan.havvy@gmail.com>"
              "Josh Triplett <josh@joshtriplett.org>"
            ];
            description = "Library for ANSI terminal colours and styles (bold, underline)";
            homepage = "https://github.com/ogham/rust-ansi-term";
            documentation = "https://docs.rs/ansi_term";
            readme = "README.md";
            license = "MIT";
          };
          lib = {
            name = "ansi_term";
          };
          target = {
            "cfg(target_os=\"windows\")" = {
              dependencies = {
                winapi = {
                  version = "0.3.4";
                  features = [
                    "errhandlingapi"
                    "consoleapi"
                    "processenv"
                  ];
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".idna."0.1.5" = mkRustCrate {
        package-id = "idna 0.1.5 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "idna";
          version = "0.1.5";
          sha256 = "38f09e0f0b1fb55fdee1f17470ad800da77af5186a1a76c026b679358b7e844e";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "matches"
            ];
            extern-name = "matches";
            package-id = "matches 0.1.8 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "unicode-bidi"
            ];
            extern-name = "unicode_bidi";
            package-id = "unicode-bidi 0.3.4 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "unicode-normalization"
            ];
            extern-name = "unicode_normalization";
            package-id = "unicode-normalization 0.1.8 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "idna";
            version = "0.1.5";
            authors = [
              "The rust-url developers"
            ];
            description = "IDNA (Internationalizing Domain Names in Applications) and Punycode.";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/servo/rust-url/";
          };
          lib = {
            test = false;
            doctest = false;
          };
          test = [
            {
              name = "tests";
              harness = false;
            }
            {
              name = "unit";
            }
          ];
          dependencies = {
            matches = {
              version = "0.1";
            };
            unicode-bidi = {
              version = "0.3";
            };
            unicode-normalization = {
              version = "0.1.5";
            };
          };
          dev-dependencies = {
            rustc-serialize = {
              version = "0.3";
            };
            rustc-test = {
              version = "0.3";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".atty."0.2.11" = mkRustCrate {
        package-id = "atty 0.2.11 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "atty";
          version = "0.2.11";
          sha256 = "9a7d5b8723950951411ee34d271d99dddcc2035a16ab25310ea2c8cfd4369652";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "termion"
            ];
            extern-name = "termion";
            package-id = "termion 1.5.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "atty";
            version = "0.2.11";
            authors = [
              "softprops <d.tangren@gmail.com>"
            ];
            description = "A simple interface for querying atty";
            homepage = "https://github.com/softprops/atty";
            documentation = "http://softprops.github.io/atty";
            readme = "README.md";
            keywords = [
              "terminal"
              "tty"
            ];
            license = "MIT";
            repository = "https://github.com/softprops/atty";
          };
          target = {
            "cfg(target_os = \"redox\")" = {
              dependencies = {
                termion = {
                  version = "1.5";
                };
              };
            };
            "cfg(unix)" = {
              dependencies = {
                libc = {
                  version = "0.2";
                  default-features = false;
                };
              };
            };
            "cfg(windows)" = {
              dependencies = {
                winapi = {
                  version = "0.3";
                  features = [
                    "consoleapi"
                    "processenv"
                    "minwinbase"
                    "minwindef"
                    "winbase"
                  ];
                };
              };
            };
          };
          badges = {
            travis-ci = {
              repository = "softprops/atty";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".shell-escape."0.1.4" = mkRustCrate {
        package-id = "shell-escape 0.1.4 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "shell-escape";
          version = "0.1.4";
          sha256 = "170a13e64f2a51b77a45702ba77287f5c6829375b04a69cf2222acd17d0cfab9";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "shell-escape";
            version = "0.1.4";
            authors = [
              "Steven Fackler <sfackler@gmail.com>"
            ];
            description = "Escape characters that may have a special meaning in a shell";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/sfackler/shell-escape";
          };
          dependencies = {
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".tokio-current-thread."0.1.6" = mkRustCrate {
        package-id = "tokio-current-thread 0.1.6 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "tokio-current-thread";
          version = "0.1.6";
          sha256 = "d16217cad7f1b840c5a97dfb3c43b0c871fef423a6e8d2118c604e843662a443";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "futures"
            ];
            extern-name = "futures";
            package-id = "futures 0.1.27 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-executor"
            ];
            extern-name = "tokio_executor";
            package-id = "tokio-executor 0.1.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "tokio-current-thread";
            version = "0.1.6";
            authors = [
              "Carl Lerche <me@carllerche.com>"
            ];
            description = "Single threaded executor which manage many tasks concurrently on the current thread.\n";
            homepage = "https://github.com/tokio-rs/tokio";
            documentation = "https://docs.rs/tokio-current-thread/0.1.6/tokio_current_thread";
            keywords = [
              "futures"
              "tokio"
            ];
            categories = [
              "concurrency"
              "asynchronous"
            ];
            license = "MIT";
            repository = "https://github.com/tokio-rs/tokio";
          };
          dependencies = {
            futures = {
              version = "0.1.19";
            };
            tokio-executor = {
              version = "0.1.7";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".build_const."0.2.1" = mkRustCrate {
        package-id = "build_const 0.2.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "build_const";
          version = "0.2.1";
          sha256 = "39092a32794787acd8525ee150305ff051b0aa6cc2abaf193924f5ab05425f39";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "build_const";
            version = "0.2.1";
            authors = [
              "Garrett Berg <vitiral@gmail.com>"
            ];
            description = "library for creating importable constants from build.rs or a script";
            documentation = "https://docs.rs/build_const";
            keywords = [
              "embedded"
              "no_std"
              "build"
              "const"
              "static"
            ];
            license = "MIT";
            repository = "https://github.com/vitiral/build_const";
          };
          features = {
            default = [
              "std"
            ];
            std = [
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".tokio."0.1.21" = mkRustCrate {
        package-id = "tokio 0.1.21 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "tokio";
          version = "0.1.21";
          sha256 = "ec2ffcf4bcfc641413fa0f1427bf8f91dfc78f56a6559cbf50e04837ae442a87";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "bytes"
            ];
            extern-name = "bytes";
            package-id = "bytes 0.4.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "futures"
            ];
            extern-name = "futures";
            package-id = "futures 0.1.27 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "mio"
            ];
            extern-name = "mio";
            package-id = "mio 0.6.19 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "num_cpus"
            ];
            extern-name = "num_cpus";
            package-id = "num_cpus 1.10.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-codec"
            ];
            extern-name = "tokio_codec";
            package-id = "tokio-codec 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-current-thread"
            ];
            extern-name = "tokio_current_thread";
            package-id = "tokio-current-thread 0.1.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-executor"
            ];
            extern-name = "tokio_executor";
            package-id = "tokio-executor 0.1.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-fs"
            ];
            extern-name = "tokio_fs";
            package-id = "tokio-fs 0.1.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-io"
            ];
            extern-name = "tokio_io";
            package-id = "tokio-io 0.1.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-reactor"
            ];
            extern-name = "tokio_reactor";
            package-id = "tokio-reactor 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-sync"
            ];
            extern-name = "tokio_sync";
            package-id = "tokio-sync 0.1.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-tcp"
            ];
            extern-name = "tokio_tcp";
            package-id = "tokio-tcp 0.1.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-threadpool"
            ];
            extern-name = "tokio_threadpool";
            package-id = "tokio-threadpool 0.1.14 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-timer"
            ];
            extern-name = "tokio_timer";
            package-id = "tokio-timer 0.2.11 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-trace-core"
            ];
            extern-name = "tokio_trace_core";
            package-id = "tokio-trace-core 0.2.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-udp"
            ];
            extern-name = "tokio_udp";
            package-id = "tokio-udp 0.1.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-uds"
            ];
            extern-name = "tokio_uds";
            package-id = "tokio-uds 0.2.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "tokio";
            version = "0.1.21";
            authors = [
              "Carl Lerche <me@carllerche.com>"
            ];
            description = "An event-driven, non-blocking I/O platform for writing asynchronous I/O\nbacked applications.\n";
            homepage = "https://tokio.rs";
            documentation = "https://docs.rs/tokio/0.1.21/tokio/";
            readme = "README.md";
            keywords = [
              "io"
              "async"
              "non-blocking"
              "futures"
            ];
            categories = [
              "asynchronous"
              "network-programming"
            ];
            license = "MIT";
            repository = "https://github.com/tokio-rs/tokio";
          };
          dependencies = {
            bytes = {
              version = "0.4";
              optional = true;
            };
            futures = {
              version = "0.1.20";
            };
            mio = {
              version = "0.6.14";
              optional = true;
            };
            num_cpus = {
              version = "1.8.0";
              optional = true;
            };
            tokio-codec = {
              version = "0.1.0";
              optional = true;
            };
            tokio-current-thread = {
              version = "0.1.6";
              optional = true;
            };
            tokio-executor = {
              version = "0.1.7";
              optional = true;
            };
            tokio-fs = {
              version = "0.1.6";
              optional = true;
            };
            tokio-io = {
              version = "0.1.6";
              optional = true;
            };
            tokio-reactor = {
              version = "0.1.1";
              optional = true;
            };
            tokio-sync = {
              version = "0.1.5";
              optional = true;
            };
            tokio-tcp = {
              version = "0.1.0";
              optional = true;
            };
            tokio-threadpool = {
              version = "0.1.14";
              optional = true;
            };
            tokio-timer = {
              version = "0.2.8";
              optional = true;
            };
            tokio-trace-core = {
              version = "0.2";
              optional = true;
            };
            tokio-udp = {
              version = "0.1.0";
              optional = true;
            };
          };
          dev-dependencies = {
            env_logger = {
              version = "0.5";
              default-features = false;
            };
            flate2 = {
              version = "1";
              features = [
                "tokio"
              ];
            };
            futures-cpupool = {
              version = "0.1";
            };
            http = {
              version = "0.1";
            };
            httparse = {
              version = "1.0";
            };
            libc = {
              version = "0.2";
            };
            num_cpus = {
              version = "1.0";
            };
            serde = {
              version = "1.0";
            };
            serde_derive = {
              version = "1.0";
            };
            serde_json = {
              version = "1.0";
            };
            time = {
              version = "0.1";
            };
          };
          features = {
            codec = [
              "io"
              "tokio-codec"
            ];
            default = [
              "codec"
              "fs"
              "io"
              "reactor"
              "rt-full"
              "sync"
              "tcp"
              "timer"
              "udp"
              "uds"
            ];
            fs = [
              "tokio-fs"
            ];
            io = [
              "bytes"
              "tokio-io"
            ];
            reactor = [
              "io"
              "mio"
              "tokio-reactor"
            ];
            rt-full = [
              "num_cpus"
              "reactor"
              "timer"
              "tokio-current-thread"
              "tokio-executor"
              "tokio-threadpool"
              "tokio-trace-core"
            ];
            sync = [
              "tokio-sync"
            ];
            tcp = [
              "tokio-tcp"
            ];
            timer = [
              "tokio-timer"
            ];
            udp = [
              "tokio-udp"
            ];
            uds = [
              "tokio-uds"
            ];
          };
          target = {
            "cfg(unix)" = {
              dependencies = {
                tokio-uds = {
                  version = "0.2.1";
                  optional = true;
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".futures."0.1.27" = mkRustCrate {
        package-id = "futures 0.1.27 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "futures";
          version = "0.1.27";
          sha256 = "a2037ec1c6c1c4f79557762eab1f7eae1f64f6cb418ace90fae88f0942b60139";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "futures";
            version = "0.1.27";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "An implementation of futures and streams featuring zero allocations,\ncomposability, and iterator-like interfaces.\n";
            homepage = "https://github.com/rust-lang-nursery/futures-rs";
            documentation = "https://docs.rs/futures";
            readme = "README.md";
            keywords = [
              "futures"
              "async"
              "future"
            ];
            categories = [
              "asynchronous"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/rust-lang-nursery/futures-rs";
          };
          dependencies = {
          };
          features = {
            default = [
              "use_std"
              "with-deprecated"
            ];
            nightly = [
            ];
            use_std = [
            ];
            with-deprecated = [
            ];
          };
          badges = {
            appveyor = {
              repository = "rust-lang-nursery/futures-rs";
            };
            travis-ci = {
              repository = "rust-lang-nursery/futures-rs";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".crossbeam-deque."0.7.1" = mkRustCrate {
        package-id = "crossbeam-deque 0.7.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "crossbeam-deque";
          version = "0.7.1";
          sha256 = "b18cd2e169ad86297e6bc0ad9aa679aee9daa4f19e8163860faf7c164e4f5a71";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "crossbeam-epoch"
            ];
            extern-name = "crossbeam_epoch";
            package-id = "crossbeam-epoch 0.7.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "crossbeam-utils"
            ];
            extern-name = "crossbeam_utils";
            package-id = "crossbeam-utils 0.6.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "crossbeam-deque";
            version = "0.7.1";
            authors = [
              "The Crossbeam Project Developers"
            ];
            description = "Concurrent work-stealing deque";
            homepage = "https://github.com/crossbeam-rs/crossbeam/tree/master/crossbeam-deque";
            documentation = "https://docs.rs/crossbeam-deque";
            readme = "README.md";
            keywords = [
              "chase-lev"
              "lock-free"
              "scheduler"
              "scheduling"
            ];
            categories = [
              "algorithms"
              "concurrency"
              "data-structures"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/crossbeam-rs/crossbeam";
          };
          dependencies = {
            crossbeam-epoch = {
              version = "0.7";
            };
            crossbeam-utils = {
              version = "0.6.5";
            };
          };
          dev-dependencies = {
            rand = {
              version = "0.6";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".rand_jitter."0.1.4" = mkRustCrate {
        package-id = "rand_jitter 0.1.4 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "rand_jitter";
          version = "0.1.4";
          sha256 = "1166d5c91dc97b88d1decc3285bb0a99ed84b05cfd0bc2341bdf2d43fc41e39b";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rand_core"
            ];
            extern-name = "rand_core";
            package-id = "rand_core 0.4.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "rand_jitter";
            version = "0.1.4";
            authors = [
              "The Rand Project Developers"
            ];
            description = "Random number generator based on timing jitter";
            documentation = "https://docs.rs/rand_jitter";
            readme = "README.md";
            keywords = [
              "random"
              "rng"
              "os"
            ];
            license = "MIT OR Apache-2.0";
            repository = "https://github.com/rust-random/rand";
          };
          dependencies = {
            log = {
              version = "0.4";
              optional = true;
            };
            rand_core = {
              version = "0.4";
            };
          };
          features = {
            std = [
              "rand_core/std"
            ];
          };
          target = {
            "cfg(any(target_os = \"macos\", target_os = \"ios\"))" = {
              dependencies = {
                libc = {
                  version = "0.2";
                  default_features = false;
                };
              };
            };
            "cfg(target_os = \"windows\")" = {
              dependencies = {
                winapi = {
                  version = "0.3";
                  features = [
                    "profileapi"
                  ];
                };
              };
            };
          };
          badges = {
            appveyor = {
              repository = "rust-random/rand";
            };
            travis-ci = {
              repository = "rust-random/rand";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".rand_xorshift."0.1.1" = mkRustCrate {
        package-id = "rand_xorshift 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "rand_xorshift";
          version = "0.1.1";
          sha256 = "cbf7e9e623549b0e21f6e97cf8ecf247c1a8fd2e8a992ae265314300b2455d5c";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "rand_core"
            ];
            extern-name = "rand_core";
            package-id = "rand_core 0.3.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "rand_xorshift";
            version = "0.1.1";
            authors = [
              "The Rand Project Developers"
              "The Rust Project Developers"
            ];
            description = "Xorshift random number generator\n";
            homepage = "https://crates.io/crates/rand_xorshift";
            documentation = "https://rust-random.github.io/rand/rand_xorshift";
            readme = "README.md";
            keywords = [
              "random"
              "rng"
              "xorshift"
            ];
            categories = [
              "algorithms"
              "no-std"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/rust-random/rand";
          };
          dependencies = {
            rand_core = {
              version = ">=0.2, <0.4";
              default-features = false;
            };
            serde = {
              version = "1";
              optional = true;
            };
            serde_derive = {
              version = "^1.0.38";
              optional = true;
            };
          };
          dev-dependencies = {
            bincode = {
              version = "1";
            };
          };
          features = {
            serde1 = [
              "serde"
              "serde_derive"
            ];
          };
          badges = {
            appveyor = {
              repository = "rust-random/rand";
            };
            travis-ci = {
              repository = "rust-random/rand";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".unicode-width."0.1.5" = mkRustCrate {
        package-id = "unicode-width 0.1.5 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "unicode-width";
          version = "0.1.5";
          sha256 = "882386231c45df4700b275c7ff55b6f3698780a650026380e72dabe76fa46526";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "unicode-width";
            version = "0.1.5";
            authors = [
              "kwantam <kwantam@gmail.com>"
            ];
            exclude = [
              "target/*"
              "Cargo.lock"
            ];
            description = "Determine displayed width of `char` and `str` types\naccording to Unicode Standard Annex #11 rules.\n";
            homepage = "https://github.com/unicode-rs/unicode-width";
            documentation = "https://unicode-rs.github.io/unicode-width";
            readme = "README.md";
            keywords = [
              "text"
              "width"
              "unicode"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/unicode-rs/unicode-width";
          };
          features = {
            bench = [
            ];
            default = [
            ];
            no_std = [
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".ignore."0.4.7" = mkRustCrate {
        package-id = "ignore 0.4.7 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "ignore";
          version = "0.4.7";
          sha256 = "8dc57fa12805f367736a38541ac1a9fc6a52812a0ca959b1d4d4b640a89eb002";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "crossbeam-channel"
            ];
            extern-name = "crossbeam_channel";
            package-id = "crossbeam-channel 0.3.8 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "globset"
            ];
            extern-name = "globset";
            package-id = "globset 0.4.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "lazy_static"
            ];
            extern-name = "lazy_static";
            package-id = "lazy_static 1.3.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "log"
            ];
            extern-name = "log";
            package-id = "log 0.4.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "memchr"
            ];
            extern-name = "memchr";
            package-id = "memchr 2.2.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "regex"
            ];
            extern-name = "regex";
            package-id = "regex 1.1.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "same-file"
            ];
            extern-name = "same_file";
            package-id = "same-file 1.0.4 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "thread_local"
            ];
            extern-name = "thread_local";
            package-id = "thread_local 0.3.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "walkdir"
            ];
            extern-name = "walkdir";
            package-id = "walkdir 2.2.8 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi-util"
            ];
            extern-name = "winapi_util";
            package-id = "winapi-util 0.1.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "ignore";
            version = "0.4.7";
            authors = [
              "Andrew Gallant <jamslam@gmail.com>"
            ];
            description = "A fast library for efficiently matching ignore files such as `.gitignore`\nagainst file paths.\n";
            homepage = "https://github.com/BurntSushi/ripgrep/tree/master/ignore";
            documentation = "https://docs.rs/ignore";
            readme = "README.md";
            keywords = [
              "glob"
              "ignore"
              "gitignore"
              "pattern"
              "file"
            ];
            license = "Unlicense/MIT";
            repository = "https://github.com/BurntSushi/ripgrep/tree/master/ignore";
          };
          lib = {
            name = "ignore";
            bench = false;
          };
          dependencies = {
            crossbeam-channel = {
              version = "0.3.6";
            };
            globset = {
              version = "0.4.3";
            };
            lazy_static = {
              version = "1.1";
            };
            log = {
              version = "0.4.5";
            };
            memchr = {
              version = "2.1";
            };
            regex = {
              version = "1.1";
            };
            same-file = {
              version = "1.0.4";
            };
            thread_local = {
              version = "0.3.6";
            };
            walkdir = {
              version = "2.2.7";
            };
          };
          dev-dependencies = {
            tempfile = {
              version = "3.0.5";
            };
          };
          features = {
            simd-accel = [
              "globset/simd-accel"
            ];
          };
          target = {
            "cfg(windows)" = {
              dependencies = {
                winapi-util = {
                  version = "0.1.2";
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".globset."0.4.3" = mkRustCrate {
        package-id = "globset 0.4.3 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "globset";
          version = "0.4.3";
          sha256 = "ef4feaabe24a0a658fd9cf4a9acf6ed284f045c77df0f49020ba3245cfb7b454";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "aho-corasick"
            ];
            extern-name = "aho_corasick";
            package-id = "aho-corasick 0.7.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "bstr"
            ];
            extern-name = "bstr";
            package-id = "bstr 0.1.4 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "fnv"
            ];
            extern-name = "fnv";
            package-id = "fnv 1.0.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "log"
            ];
            extern-name = "log";
            package-id = "log 0.4.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "regex"
            ];
            extern-name = "regex";
            package-id = "regex 1.1.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "globset";
            version = "0.4.3";
            authors = [
              "Andrew Gallant <jamslam@gmail.com>"
            ];
            description = "Cross platform single glob and glob set matching. Glob set matching is the\nprocess of matching one or more glob patterns against a single candidate path\nsimultaneously, and returning all of the globs that matched.\n";
            homepage = "https://github.com/BurntSushi/ripgrep/tree/master/globset";
            documentation = "https://docs.rs/globset";
            readme = "README.md";
            keywords = [
              "regex"
              "glob"
              "multiple"
              "set"
              "pattern"
            ];
            license = "Unlicense/MIT";
            repository = "https://github.com/BurntSushi/ripgrep/tree/master/globset";
          };
          lib = {
            name = "globset";
            bench = false;
          };
          dependencies = {
            aho-corasick = {
              version = "0.7.3";
            };
            bstr = {
              version = "0.1.2";
              features = [
                "std"
              ];
              default-features = false;
            };
            fnv = {
              version = "1.0.6";
            };
            log = {
              version = "0.4.5";
            };
            regex = {
              version = "1.1.5";
            };
          };
          dev-dependencies = {
            glob = {
              version = "0.3.0";
            };
          };
          features = {
            simd-accel = [
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".typenum."1.10.0" = mkRustCrate {
        package-id = "typenum 1.10.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "typenum";
          version = "1.10.0";
          sha256 = "612d636f949607bdf9b123b4a6f6d966dedf3ff669f7f045890d3a4a73948169";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "typenum";
            version = "1.10.0";
            authors = [
              "Paho Lurie-Gregg <paho@paholg.com>"
              "Andre Bogus <bogusandre@gmail.com>"
            ];
            build = "build/main.rs";
            description = "Typenum is a Rust library for type-level numbers evaluated at compile time. It currently supports bits, unsigned integers, and signed integers. It also provides a type-level array of type-level numbers, but its implementation is incomplete.";
            documentation = "https://docs.rs/typenum";
            readme = "README.md";
            categories = [
              "no-std"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/paholg/typenum";
          };
          lib = {
            name = "typenum";
          };
          features = {
            i128 = [
            ];
            no_std = [
            ];
            strict = [
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".backtrace-sys."0.1.28" = mkRustCrate {
        package-id = "backtrace-sys 0.1.28 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "backtrace-sys";
          version = "0.1.28";
          sha256 = "797c830ac25ccc92a7f8a7b9862bde440715531514594a6154e3d4a54dd769b6";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "cc"
            ];
            extern-name = "cc";
            package-id = "cc 1.0.37 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "backtrace-sys";
            version = "0.1.28";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            build = "build.rs";
            description = "Bindings to the libbacktrace gcc library\n";
            homepage = "https://github.com/alexcrichton/backtrace-rs";
            documentation = "http://alexcrichton.com/backtrace-rs";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/backtrace-rs";
          };
          dependencies = {
            libc = {
              version = "0.2";
              default-features = false;
            };
          };
          build-dependencies = {
            cc = {
              version = "1.0";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".http."0.1.17" = mkRustCrate {
        package-id = "http 0.1.17 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "http";
          version = "0.1.17";
          sha256 = "eed324f0f0daf6ec10c474f150505af2c143f251722bf9dbd1261bd1f2ee2c1a";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "bytes"
            ];
            extern-name = "bytes";
            package-id = "bytes 0.4.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "fnv"
            ];
            extern-name = "fnv";
            package-id = "fnv 1.0.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "itoa"
            ];
            extern-name = "itoa";
            package-id = "itoa 0.4.4 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "http";
            version = "0.1.17";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
              "Carl Lerche <me@carllerche.com>"
              "Sean McArthur <sean@seanmonstar.com>"
            ];
            description = "A set of types for representing HTTP requests and responses.\n";
            homepage = "https://github.com/hyperium/http";
            documentation = "https://docs.rs/http";
            readme = "README.md";
            keywords = [
              "http"
            ];
            categories = [
              "web-programming"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/hyperium/http";
          };
          bench = [
            {
              name = "header_map";
              path = "benches/header_map/mod.rs";
            }
            {
              name = "header_value";
              path = "benches/header_value.rs";
            }
            {
              name = "uri";
              path = "benches/uri.rs";
            }
          ];
          dependencies = {
            bytes = {
              version = "0.4";
            };
            fnv = {
              version = "1.0.5";
            };
            itoa = {
              version = "0.4.1";
            };
          };
          dev-dependencies = {
            indexmap = {
              version = "1.0";
            };
            quickcheck = {
              version = "0.6";
            };
            rand = {
              version = "0.4";
            };
            seahash = {
              version = "3.0.5";
            };
            serde = {
              version = "1.0";
            };
            serde_json = {
              version = "1.0";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".tokio-fs."0.1.6" = mkRustCrate {
        package-id = "tokio-fs 0.1.6 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "tokio-fs";
          version = "0.1.6";
          sha256 = "3fe6dc22b08d6993916647d108a1a7d15b9cd29c4f4496c62b92c45b5041b7af";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "futures"
            ];
            extern-name = "futures";
            package-id = "futures 0.1.27 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-io"
            ];
            extern-name = "tokio_io";
            package-id = "tokio-io 0.1.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-threadpool"
            ];
            extern-name = "tokio_threadpool";
            package-id = "tokio-threadpool 0.1.14 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "tokio-fs";
            version = "0.1.6";
            authors = [
              "Carl Lerche <me@carllerche.com>"
            ];
            description = "Filesystem API for Tokio.\n";
            homepage = "https://tokio.rs";
            documentation = "https://docs.rs/tokio-fs/0.1.6/tokio_fs";
            readme = "README.md";
            keywords = [
              "tokio"
              "futures"
              "fs"
              "file"
              "async"
            ];
            categories = [
              "asynchronous"
              "network-programming"
              "filesystem"
            ];
            license = "MIT";
            repository = "https://github.com/tokio-rs/tokio";
          };
          dependencies = {
            futures = {
              version = "0.1.21";
            };
            tokio-io = {
              version = "0.1.6";
            };
            tokio-threadpool = {
              version = "0.1.3";
            };
          };
          dev-dependencies = {
            rand = {
              version = "0.6";
            };
            tempdir = {
              version = "0.3";
            };
            tempfile = {
              version = "3";
            };
            tokio = {
              version = "0.1.7";
            };
            tokio-codec = {
              version = "0.1.0";
            };
            tokio-io = {
              version = "0.1.6";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".libnghttp2-sys."0.1.1" = mkRustCrate {
        package-id = "libnghttp2-sys 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "libnghttp2-sys";
          version = "0.1.1";
          sha256 = "d75d7966bda4730b722d1eab8e668df445368a24394bae9fc1e8dc0ab3dbe4f4";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "cc"
            ];
            extern-name = "cc";
            package-id = "cc 1.0.37 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "libnghttp2-sys";
            version = "0.1.1";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            links = "nghttp2";
            description = "FFI bindings for libnghttp2 (nghttp2)\n";
            homepage = "https://github.com/alexcrichton/nghttp2-rs";
            readme = "README.md";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/nghttp2-rs";
          };
          lib = {
            doctest = false;
          };
          dependencies = {
            libc = {
              version = "0.2";
            };
          };
          build-dependencies = {
            cc = {
              version = "1.0.24";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".url."1.7.2" = mkRustCrate {
        package-id = "url 1.7.2 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "url";
          version = "1.7.2";
          sha256 = "dd4e7c0d531266369519a4aa4f399d748bd37043b00bde1e4ff1f60a120b355a";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "idna"
            ];
            extern-name = "idna";
            package-id = "idna 0.1.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "matches"
            ];
            extern-name = "matches";
            package-id = "matches 0.1.8 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "percent-encoding"
            ];
            extern-name = "percent_encoding";
            package-id = "percent-encoding 1.0.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "url";
            version = "1.7.2";
            authors = [
              "The rust-url developers"
            ];
            description = "URL library for Rust, based on the WHATWG URL Standard";
            documentation = "https://docs.rs/url";
            readme = "README.md";
            keywords = [
              "url"
              "parser"
            ];
            categories = [
              "parser-implementations"
              "web-programming"
              "encoding"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/servo/rust-url";
            metadata = {
              docs = {
                rs = {
                  features = [
                    "query_encoding"
                  ];
                };
              };
            };
          };
          lib = {
            test = false;
          };
          test = [
            {
              name = "unit";
            }
            {
              name = "data";
              harness = false;
            }
          ];
          bench = [
            {
              name = "parse_url";
              harness = false;
            }
          ];
          dependencies = {
            encoding = {
              version = "0.2";
              optional = true;
            };
            heapsize = {
              version = ">=0.4.1, <0.5";
              optional = true;
            };
            idna = {
              version = "0.1.0";
            };
            matches = {
              version = "0.1";
            };
            percent-encoding = {
              version = "1.0.0";
            };
            rustc-serialize = {
              version = "0.3";
              optional = true;
            };
            serde = {
              version = ">=0.6.1, <0.9";
              optional = true;
            };
          };
          dev-dependencies = {
            bencher = {
              version = "0.1";
            };
            rustc-serialize = {
              version = "0.3";
            };
            rustc-test = {
              version = "0.3";
            };
            serde_json = {
              version = ">=0.6.1, <0.9";
            };
          };
          features = {
            heap_size = [
              "heapsize"
            ];
            query_encoding = [
              "encoding"
            ];
          };
          badges = {
            appveyor = {
              repository = "Manishearth/rust-url";
            };
            travis-ci = {
              repository = "servo/rust-url";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".filetime."0.2.6" = mkRustCrate {
        package-id = "filetime 0.2.6 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "filetime";
          version = "0.2.6";
          sha256 = "450537dc346f0c4d738dda31e790da1da5d4bd12145aad4da0d03d713cb3794f";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "cfg-if"
            ];
            extern-name = "cfg_if";
            package-id = "cfg-if 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "redox_syscall"
            ];
            extern-name = "syscall";
            package-id = "redox_syscall 0.1.54 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            edition = "2018";
            name = "filetime";
            version = "0.2.6";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "Platform-agnostic accessors of timestamps in File metadata\n";
            homepage = "https://github.com/alexcrichton/filetime";
            documentation = "https://docs.rs/filetime";
            readme = "README.md";
            keywords = [
              "timestamp"
              "mtime"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/filetime";
          };
          dependencies = {
            cfg-if = {
              version = "0.1";
            };
          };
          dev-dependencies = {
            tempdir = {
              version = "0.3";
            };
          };
          target = {
            "cfg(target_os = \"redox\")" = {
              dependencies = {
                redox_syscall = {
                  version = "0.1";
                };
              };
            };
            "cfg(unix)" = {
              dependencies = {
                libc = {
                  version = "0.2";
                };
              };
            };
            "cfg(windows)" = {
              dependencies = {
                winapi = {
                  version = "0.3";
                  features = [
                    "fileapi"
                    "minwindef"
                    "winbase"
                  ];
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".unicode-normalization."0.1.8" = mkRustCrate {
        package-id = "unicode-normalization 0.1.8 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "unicode-normalization";
          version = "0.1.8";
          sha256 = "141339a08b982d942be2ca06ff8b076563cbe223d1befd5450716790d44e2426";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "smallvec"
            ];
            extern-name = "smallvec";
            package-id = "smallvec 0.6.10 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "unicode-normalization";
            version = "0.1.8";
            authors = [
              "kwantam <kwantam@gmail.com>"
            ];
            exclude = [
              "target/*"
              "Cargo.lock"
              "scripts/tmp"
              "*.txt"
              "src/normalization_tests.rs"
              "src/test.rs"
            ];
            description = "This crate provides functions for normalization of\nUnicode strings, including Canonical and Compatible\nDecomposition and Recomposition, as described in\nUnicode Standard Annex #15.\n";
            homepage = "https://github.com/unicode-rs/unicode-normalization";
            documentation = "https://docs.rs/unicode-normalization/";
            readme = "README.md";
            keywords = [
              "text"
              "unicode"
              "normalization"
              "decomposition"
              "recomposition"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/unicode-rs/unicode-normalization";
          };
          dependencies = {
            smallvec = {
              version = "0.6";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".slab."0.4.2" = mkRustCrate {
        package-id = "slab 0.4.2 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "slab";
          version = "0.4.2";
          sha256 = "c111b5bd5695e56cffe5129854aa230b39c93a305372fdbb2668ca2394eea9f8";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "slab";
            version = "0.4.2";
            authors = [
              "Carl Lerche <me@carllerche.com>"
            ];
            description = "Pre-allocated storage for a uniform data type";
            homepage = "https://github.com/carllerche/slab";
            documentation = "https://docs.rs/slab/0.4.2/slab/";
            readme = "README.md";
            keywords = [
              "slab"
              "allocator"
            ];
            categories = [
              "memory-management"
              "data-structures"
            ];
            license = "MIT";
            repository = "https://github.com/carllerche/slab";
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".rand_pcg."0.1.2" = mkRustCrate {
        package-id = "rand_pcg 0.1.2 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "rand_pcg";
          version = "0.1.2";
          sha256 = "abf9b09b01790cfe0364f52bf32995ea3c39f4d2dd011eac241d2914146d0b44";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "autocfg"
            ];
            extern-name = "autocfg";
            package-id = "autocfg 0.1.4 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rand_core"
            ];
            extern-name = "rand_core";
            package-id = "rand_core 0.4.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "rand_pcg";
            version = "0.1.2";
            authors = [
              "The Rand Project Developers"
            ];
            build = "build.rs";
            description = "Selected PCG random number generators\n";
            homepage = "https://crates.io/crates/rand_pcg";
            documentation = "https://rust-random.github.io/rand/rand_pcg";
            readme = "README.md";
            keywords = [
              "random"
              "rng"
              "pcg"
            ];
            categories = [
              "algorithms"
              "no-std"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/rust-random/rand";
          };
          dependencies = {
            rand_core = {
              version = "0.4";
            };
            serde = {
              version = "1";
              optional = true;
            };
            serde_derive = {
              version = "^1.0.38";
              optional = true;
            };
          };
          dev-dependencies = {
            bincode = {
              version = "1.1.2";
            };
          };
          build-dependencies = {
            autocfg = {
              version = "0.1";
            };
          };
          features = {
            serde1 = [
              "serde"
              "serde_derive"
            ];
          };
          badges = {
            appveyor = {
              repository = "rust-random/rand";
            };
            travis-ci = {
              repository = "rust-random/rand";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".tokio-reactor."0.1.9" = mkRustCrate {
        package-id = "tokio-reactor 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "tokio-reactor";
          version = "0.1.9";
          sha256 = "6af16bfac7e112bea8b0442542161bfc41cbfa4466b580bdda7d18cb88b911ce";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "crossbeam-utils"
            ];
            extern-name = "crossbeam_utils";
            package-id = "crossbeam-utils 0.6.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "futures"
            ];
            extern-name = "futures";
            package-id = "futures 0.1.27 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "lazy_static"
            ];
            extern-name = "lazy_static";
            package-id = "lazy_static 1.3.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "log"
            ];
            extern-name = "log";
            package-id = "log 0.4.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "mio"
            ];
            extern-name = "mio";
            package-id = "mio 0.6.19 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "num_cpus"
            ];
            extern-name = "num_cpus";
            package-id = "num_cpus 1.10.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "parking_lot"
            ];
            extern-name = "parking_lot";
            package-id = "parking_lot 0.7.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "slab"
            ];
            extern-name = "slab";
            package-id = "slab 0.4.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-executor"
            ];
            extern-name = "tokio_executor";
            package-id = "tokio-executor 0.1.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-io"
            ];
            extern-name = "tokio_io";
            package-id = "tokio-io 0.1.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-sync"
            ];
            extern-name = "tokio_sync";
            package-id = "tokio-sync 0.1.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "tokio-reactor";
            version = "0.1.9";
            authors = [
              "Carl Lerche <me@carllerche.com>"
            ];
            description = "Event loop that drives Tokio I/O resources.\n";
            homepage = "https://tokio.rs";
            documentation = "https://docs.rs/tokio-reactor/0.1.9/tokio_reactor";
            readme = "README.md";
            categories = [
              "asynchronous"
              "network-programming"
            ];
            license = "MIT";
            repository = "https://github.com/tokio-rs/tokio";
          };
          dependencies = {
            crossbeam-utils = {
              version = "0.6.0";
            };
            futures = {
              version = "0.1.19";
            };
            lazy_static = {
              version = "1.0.2";
            };
            log = {
              version = "0.4.1";
            };
            mio = {
              version = "0.6.14";
            };
            num_cpus = {
              version = "1.8.0";
            };
            parking_lot = {
              version = "0.7.0";
            };
            slab = {
              version = "0.4.0";
            };
            tokio-executor = {
              version = "0.1.1";
            };
            tokio-io = {
              version = "0.1.6";
            };
            tokio-sync = {
              version = "0.1.1";
            };
          };
          dev-dependencies = {
            num_cpus = {
              version = "1.8.0";
            };
            tokio = {
              version = "0.1.7";
            };
            tokio-io-pool = {
              version = "0.1.4";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".bytesize."1.0.0" = mkRustCrate {
        package-id = "bytesize 1.0.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "bytesize";
          version = "1.0.0";
          sha256 = "716960a18f978640f25101b5cbf1c6f6b0d3192fab36a2d98ca96f0ecbe41010";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "bytesize";
            version = "1.0.0";
            authors = [
              "Hyunsik Choi <hyunsik.choi@gmail.com>"
            ];
            description = "an utility for human-readable bytes representations";
            homepage = "https://github.com/hyunsik/bytesize/";
            documentation = "https://docs.rs/bytesize/";
            readme = "README.md";
            keywords = [
              "byte"
              "byte-size"
              "utility"
              "human-readable"
              "format"
            ];
            license = "Apache-2.0";
            repository = "https://github.com/hyunsik/bytesize/";
          };
          dependencies = {
            serde = {
              version = "1.0";
              features = [
                "derive"
              ];
              optional = true;
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".scopeguard."0.3.3" = mkRustCrate {
        package-id = "scopeguard 0.3.3 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "scopeguard";
          version = "0.3.3";
          sha256 = "94258f53601af11e6a49f722422f6e3425c52b06245a5cf9bc09908b174f5e27";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "scopeguard";
            version = "0.3.3";
            authors = [
              "bluss"
            ];
            description = "A RAII scope guard that will run a given closure when it goes out of scope,\neven if the code between panics (assuming unwinding panic).\n\nDefines the macros `defer!` and `defer_on_unwind!`; the latter only runs\nif the scope is extited through unwinding on panic.\n";
            documentation = "https://docs.rs/scopeguard/";
            keywords = [
              "scope-guard"
              "defer"
              "panic"
            ];
            categories = [
              "rust-patterns"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/bluss/scopeguard";
            metadata = {
              release = {
                no-dev-version = true;
              };
            };
          };
          features = {
            default = [
              "use_std"
            ];
            use_std = [
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".foreign-types-shared."0.1.1" = mkRustCrate {
        package-id = "foreign-types-shared 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "foreign-types-shared";
          version = "0.1.1";
          sha256 = "00b0228411908ca8685dba7fc2cdd70ec9990a6e753e89b6ac91a84c40fbaf4b";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "foreign-types-shared";
            version = "0.1.1";
            authors = [
              "Steven Fackler <sfackler@gmail.com>"
            ];
            description = "An internal crate used by foreign-types";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/sfackler/foreign-types";
          };
          dependencies = {
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".tokio-udp."0.1.3" = mkRustCrate {
        package-id = "tokio-udp 0.1.3 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "tokio-udp";
          version = "0.1.3";
          sha256 = "66268575b80f4a4a710ef83d087fdfeeabdce9b74c797535fbac18a2cb906e92";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "bytes"
            ];
            extern-name = "bytes";
            package-id = "bytes 0.4.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "futures"
            ];
            extern-name = "futures";
            package-id = "futures 0.1.27 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "log"
            ];
            extern-name = "log";
            package-id = "log 0.4.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "mio"
            ];
            extern-name = "mio";
            package-id = "mio 0.6.19 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-codec"
            ];
            extern-name = "tokio_codec";
            package-id = "tokio-codec 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-io"
            ];
            extern-name = "tokio_io";
            package-id = "tokio-io 0.1.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-reactor"
            ];
            extern-name = "tokio_reactor";
            package-id = "tokio-reactor 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "tokio-udp";
            version = "0.1.3";
            authors = [
              "Carl Lerche <me@carllerche.com>"
            ];
            description = "UDP bindings for tokio.\n";
            homepage = "https://tokio.rs";
            documentation = "https://docs.rs/tokio-udp/0.1.3/tokio_udp";
            categories = [
              "asynchronous"
            ];
            license = "MIT";
            repository = "https://github.com/tokio-rs/tokio";
          };
          dependencies = {
            bytes = {
              version = "0.4";
            };
            futures = {
              version = "0.1.19";
            };
            log = {
              version = "0.4";
            };
            mio = {
              version = "0.6.14";
            };
            tokio-codec = {
              version = "0.1.0";
            };
            tokio-io = {
              version = "0.1.7";
            };
            tokio-reactor = {
              version = "0.1.1";
            };
          };
          dev-dependencies = {
            env_logger = {
              version = "0.5";
              default-features = false;
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".bytes."0.4.12" = mkRustCrate {
        package-id = "bytes 0.4.12 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "bytes";
          version = "0.4.12";
          sha256 = "206fdffcfa2df7cbe15601ef46c813fce0965eb3286db6b56c583b814b51c81c";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "byteorder"
            ];
            extern-name = "byteorder";
            package-id = "byteorder 1.3.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "iovec"
            ];
            extern-name = "iovec";
            package-id = "iovec 0.1.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "bytes";
            version = "0.4.12";
            authors = [
              "Carl Lerche <me@carllerche.com>"
            ];
            exclude = [
              ".gitignore"
              ".travis.yml"
              "deploy.sh"
              "bench/**/*"
              "test/**/*"
            ];
            description = "Types and traits for working with bytes";
            homepage = "https://github.com/carllerche/bytes";
            documentation = "https://docs.rs/bytes/0.4.12/bytes";
            readme = "README.md";
            keywords = [
              "buffers"
              "zero-copy"
              "io"
            ];
            categories = [
              "network-programming"
              "data-structures"
            ];
            license = "MIT";
            repository = "https://github.com/carllerche/bytes";
            metadata = {
              docs = {
                rs = {
                  features = [
                    "i128"
                  ];
                };
              };
            };
          };
          dependencies = {
            byteorder = {
              version = "1.1.0";
            };
            either = {
              version = "1.5";
              optional = true;
              default-features = false;
            };
            iovec = {
              version = "0.1";
            };
            serde = {
              version = "1.0";
              optional = true;
            };
          };
          dev-dependencies = {
            serde_test = {
              version = "1.0";
            };
          };
          features = {
            i128 = [
              "byteorder/i128"
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".arrayvec."0.4.10" = mkRustCrate {
        package-id = "arrayvec 0.4.10 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "arrayvec";
          version = "0.4.10";
          sha256 = "92c7fb76bc8826a8b33b4ee5bb07a247a81e76764ab4d55e8f73e3a4d8808c71";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "nodrop"
            ];
            extern-name = "nodrop";
            package-id = "nodrop 0.1.13 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "arrayvec";
            version = "0.4.10";
            authors = [
              "bluss"
            ];
            description = "A vector with fixed capacity, backed by an array (it can be stored on the stack too). Implements fixed capacity ArrayVec and ArrayString.";
            documentation = "https://docs.rs/arrayvec/";
            keywords = [
              "stack"
              "vector"
              "array"
              "data-structure"
              "no_std"
            ];
            categories = [
              "data-structures"
              "no-std"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/bluss/arrayvec";
            metadata = {
              docs = {
                rs = {
                  features = [
                    "serde-1"
                  ];
                };
              };
              release = {
                no-dev-version = true;
              };
            };
          };
          bench = [
            {
              name = "extend";
              harness = false;
            }
            {
              name = "arraystring";
              harness = false;
            }
          ];
          dependencies = {
            nodrop = {
              version = "0.1.12";
              default-features = false;
            };
            serde = {
              version = "1.0";
              optional = true;
              default-features = false;
            };
          };
          dev-dependencies = {
            bencher = {
              version = "0.1.4";
            };
            matches = {
              version = "0.1";
            };
            serde_test = {
              version = "1.0";
            };
          };
          build-dependencies = {
          };
          features = {
            array-sizes-129-255 = [
            ];
            array-sizes-33-128 = [
            ];
            default = [
              "std"
            ];
            serde-1 = [
              "serde"
            ];
            std = [
            ];
            use_union = [
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".lazycell."1.2.1" = mkRustCrate {
        package-id = "lazycell 1.2.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "lazycell";
          version = "1.2.1";
          sha256 = "b294d6fa9ee409a054354afc4352b0b9ef7ca222c69b8812cbea9e7d2bf3783f";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "lazycell";
            version = "1.2.1";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
              "Nikita Pekin <contact@nikitapek.in>"
            ];
            include = [
              "CHANGELOG.md"
              "Cargo.toml"
              "LICENSE-MIT"
              "LICENSE-APACHE"
              "README.md"
              "src/**/*.rs"
            ];
            description = "A library providing a lazily filled Cell struct";
            documentation = "http://indiv0.github.io/lazycell/lazycell/";
            readme = "README.md";
            keywords = [
              "lazycell"
              "lazy"
              "cell"
              "library"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/indiv0/lazycell";
          };
          dependencies = {
            clippy = {
              version = "0.0";
              optional = true;
            };
          };
          features = {
            nightly = [
            ];
            nightly-testing = [
              "clippy"
              "nightly"
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".fuchsia-zircon-sys."0.3.3" = mkRustCrate {
        package-id = "fuchsia-zircon-sys 0.3.3 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "fuchsia-zircon-sys";
          version = "0.3.3";
          sha256 = "3dcaa9ae7725d12cdb85b3ad99a434db70b468c09ded17e012d86b5c1010f7a7";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "fuchsia-zircon-sys";
            version = "0.3.3";
            authors = [
              "Raph Levien <raph@google.com>"
            ];
            description = "Low-level Rust bindings for the Zircon kernel";
            license = "BSD-3-Clause";
            repository = "https://fuchsia.googlesource.com/garnet/";
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".memoffset."0.2.1" = mkRustCrate {
        package-id = "memoffset 0.2.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "memoffset";
          version = "0.2.1";
          sha256 = "0f9dc261e2b62d7a622bf416ea3c5245cdd5d9a7fcc428c0d06804dfce1775b3";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "memoffset";
            version = "0.2.1";
            authors = [
              "Gilad Naaman <gilad.naaman@gmail.com>"
            ];
            description = "offset_of functionality for Rust structs.";
            readme = "README.md";
            keywords = [
              "mem"
              "offset"
              "offset_of"
              "offsetof"
            ];
            categories = [
              "no-std"
            ];
            license = "MIT";
            repository = "https://github.com/Gilnaa/memoffset";
          };
          dependencies = {
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".proc-macro2."0.4.30" = mkRustCrate {
        package-id = "proc-macro2 0.4.30 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "proc-macro2";
          version = "0.4.30";
          sha256 = "cf3d2011ab5c909338f7887f4fc896d35932e29146c12c8d01da6b22a80ba759";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "unicode-xid"
            ];
            extern-name = "unicode_xid";
            package-id = "unicode-xid 0.1.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "proc-macro2";
            version = "0.4.30";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            build = "build.rs";
            description = "A stable implementation of the upcoming new `proc_macro` API. Comes with an\noption, off by default, to also reimplement itself in terms of the upstream\nunstable API.\n";
            homepage = "https://github.com/alexcrichton/proc-macro2";
            documentation = "https://docs.rs/proc-macro2";
            readme = "README.md";
            keywords = [
              "macros"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/proc-macro2";
            metadata = {
              docs = {
                rs = {
                  rustc-args = [
                    "--cfg"
                    "procmacro2_semver_exempt"
                  ];
                  rustdoc-args = [
                    "--cfg"
                    "procmacro2_semver_exempt"
                  ];
                };
              };
            };
          };
          dependencies = {
            unicode-xid = {
              version = "0.1";
            };
          };
          dev-dependencies = {
            quote = {
              version = "0.6";
            };
          };
          features = {
            default = [
              "proc-macro"
            ];
            nightly = [
            ];
            proc-macro = [
            ];
            span-locations = [
            ];
          };
          badges = {
            travis-ci = {
              repository = "alexcrichton/proc-macro2";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".crypto-hash."0.3.3" = mkRustCrate {
        package-id = "crypto-hash 0.3.3 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "crypto-hash";
          version = "0.3.3";
          sha256 = "20ff87d28defc77c9980a5b81cae1a33c791dd0ead8af0cee0833eb98c8305b9";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "commoncrypto"
            ];
            extern-name = "commoncrypto";
            package-id = "commoncrypto 0.2.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "hex"
            ];
            extern-name = "hex";
            package-id = "hex 0.3.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "openssl"
            ];
            extern-name = "openssl";
            package-id = "openssl 0.10.23 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "crypto-hash";
            version = "0.3.3";
            authors = [
              "Mark Lee"
            ];
            exclude = [
              ".*.yml"
              "ci/*"
            ];
            description = "A wrapper for OS-level cryptographic hash functions";
            documentation = "https://docs.rs/crypto-hash";
            readme = "README.md";
            keywords = [
              "crypto"
              "hash"
              "digest"
            ];
            license = "MIT";
            repository = "https://github.com/malept/crypto-hash";
          };
          dependencies = {
            hex = {
              version = "0.3";
            };
          };
          target = {
            "cfg(any(target_os = \"macos\", target_os = \"ios\"))" = {
              dependencies = {
                commoncrypto = {
                  version = "0.2";
                };
              };
            };
            "cfg(not(any(target_os = \"windows\", target_os = \"macos\", target_os = \"ios\")))" = {
              dependencies = {
                openssl = {
                  version = "0.10";
                };
              };
            };
            "cfg(target_os = \"windows\")" = {
              dependencies = {
                winapi = {
                  version = "0.3";
                  features = [
                    "minwindef"
                    "wincrypt"
                  ];
                };
              };
            };
          };
          badges = {
            appveyor = {
              repository = "malept/crypto-hash";
            };
            travis-ci = {
              repository = "malept/crypto-hash";
            };
          };
        };
      };
      unknown.cargo2nix."0.1.0" = mkRustCrate {
        package-id = "cargo2nix 0.1.0";
        src = config.resolver {
          source = "unknown";
          name = "cargo2nix";
          version = "0.1.0";
          sha256 = "0000000000000000000000000000000000000000000000000000";
          source-info = {
          };
        };
        dependencies = [
          {
            toml-names = [
              "cargo"
            ];
            extern-name = "cargo";
            package-id = "cargo 0.36.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "clap"
            ];
            extern-name = "clap";
            package-id = "clap 2.33.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "env_logger"
            ];
            extern-name = "env_logger";
            package-id = "env_logger 0.6.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "failure"
            ];
            extern-name = "failure";
            package-id = "failure 0.1.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "futures"
            ];
            extern-name = "futures";
            package-id = "futures 0.1.27 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "lazy_static"
            ];
            extern-name = "lazy_static";
            package-id = "lazy_static 1.3.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "log"
            ];
            extern-name = "log";
            package-id = "log 0.4.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "regex"
            ];
            extern-name = "regex";
            package-id = "regex 1.1.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "serde"
            ];
            extern-name = "serde";
            package-id = "serde 1.0.92 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "serde_json"
            ];
            extern-name = "serde_json";
            package-id = "serde_json 1.0.39 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio"
            ];
            extern-name = "tokio";
            package-id = "tokio 0.1.21 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-process"
            ];
            extern-name = "tokio_process";
            package-id = "tokio-process 0.2.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "toml"
            ];
            extern-name = "toml";
            package-id = "toml 0.5.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            edition = "2018";
            name = "cargo2nix";
            version = "0.1.0";
          };
          dependencies = {
            cargo = "0.36.0";
            clap = "2.33.0";
            env_logger = "0.6.2";
            failure = "0.1.5";
            futures = "0.1";
            lazy_static = "1.3.0";
            log = "0.4.0";
            regex = "1.1.7";
            serde = {
              version = "1.0";
              features = [
                "derive"
              ];
            };
            serde_json = "1.0.39";
            tokio = "0.1.21";
            tokio-process = "0.2";
            toml = "0.5";
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".tokio-uds."0.2.5" = mkRustCrate {
        package-id = "tokio-uds 0.2.5 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "tokio-uds";
          version = "0.2.5";
          sha256 = "037ffc3ba0e12a0ab4aca92e5234e0dedeb48fddf6ccd260f1f150a36a9f2445";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "bytes"
            ];
            extern-name = "bytes";
            package-id = "bytes 0.4.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "futures"
            ];
            extern-name = "futures";
            package-id = "futures 0.1.27 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "iovec"
            ];
            extern-name = "iovec";
            package-id = "iovec 0.1.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "log"
            ];
            extern-name = "log";
            package-id = "log 0.4.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "mio"
            ];
            extern-name = "mio";
            package-id = "mio 0.6.19 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "mio-uds"
            ];
            extern-name = "mio_uds";
            package-id = "mio-uds 0.6.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-codec"
            ];
            extern-name = "tokio_codec";
            package-id = "tokio-codec 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-io"
            ];
            extern-name = "tokio_io";
            package-id = "tokio-io 0.1.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-reactor"
            ];
            extern-name = "tokio_reactor";
            package-id = "tokio-reactor 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "tokio-uds";
            version = "0.2.5";
            authors = [
              "Carl Lerche <me@carllerche.com>"
            ];
            description = "Unix Domain sockets for Tokio\n";
            homepage = "https://github.com/tokio-rs/tokio";
            documentation = "https://docs.rs/tokio-uds/0.2.5/tokio_uds/";
            categories = [
              "asynchronous"
            ];
            license = "MIT";
            repository = "https://github.com/tokio-rs/tokio";
          };
          dependencies = {
            bytes = {
              version = "0.4.8";
            };
            futures = {
              version = "0.1.21";
            };
            iovec = {
              version = "0.1.2";
            };
            libc = {
              version = "0.2.42";
            };
            log = {
              version = "0.4.2";
            };
            mio = {
              version = "0.6.14";
            };
            mio-uds = {
              version = "0.6.5";
            };
            tokio-codec = {
              version = "0.1.0";
            };
            tokio-io = {
              version = "0.1.6";
            };
            tokio-reactor = {
              version = "0.1.1";
            };
          };
          dev-dependencies = {
            tempfile = {
              version = "3";
            };
            tokio = {
              version = "0.1.6";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".rand."0.6.5" = mkRustCrate {
        package-id = "rand 0.6.5 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "rand";
          version = "0.6.5";
          sha256 = "6d71dacdc3c88c1fde3885a3be3fbab9f35724e6ce99467f7d9c5026132184ca";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "autocfg"
            ];
            extern-name = "autocfg";
            package-id = "autocfg 0.1.4 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rand_chacha"
            ];
            extern-name = "rand_chacha";
            package-id = "rand_chacha 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rand_core"
            ];
            extern-name = "rand_core";
            package-id = "rand_core 0.4.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rand_hc"
            ];
            extern-name = "rand_hc";
            package-id = "rand_hc 0.1.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rand_isaac"
            ];
            extern-name = "rand_isaac";
            package-id = "rand_isaac 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rand_jitter"
            ];
            extern-name = "rand_jitter";
            package-id = "rand_jitter 0.1.4 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rand_os"
            ];
            extern-name = "rand_os";
            package-id = "rand_os 0.1.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rand_pcg"
            ];
            extern-name = "rand_pcg";
            package-id = "rand_pcg 0.1.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rand_xorshift"
            ];
            extern-name = "rand_xorshift";
            package-id = "rand_xorshift 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "rand";
            version = "0.6.5";
            authors = [
              "The Rand Project Developers"
              "The Rust Project Developers"
            ];
            build = "build.rs";
            exclude = [
              "/utils/*"
              "/.travis.yml"
              "/appveyor.yml"
              ".gitignore"
            ];
            description = "Random number generators and other randomness functionality.\n";
            homepage = "https://crates.io/crates/rand";
            documentation = "https://rust-random.github.io/rand";
            readme = "README.md";
            keywords = [
              "random"
              "rng"
            ];
            categories = [
              "algorithms"
              "no-std"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/rust-random/rand";
            metadata = {
              docs = {
                rs = {
                  all-features = true;
                };
              };
            };
          };
          dependencies = {
            log = {
              version = "0.4";
              optional = true;
            };
            packed_simd = {
              version = "0.3";
              features = [
                "into_bits"
              ];
              optional = true;
            };
            rand_chacha = {
              version = "0.1";
            };
            rand_core = {
              version = "0.4";
            };
            rand_hc = {
              version = "0.1";
            };
            rand_isaac = {
              version = "0.1";
            };
            rand_jitter = {
              version = "0.1";
            };
            rand_os = {
              version = "0.1";
              optional = true;
            };
            rand_pcg = {
              version = "0.1";
            };
            rand_xorshift = {
              version = "0.1";
            };
          };
          dev-dependencies = {
            average = {
              version = "0.9.2";
            };
            rand_xoshiro = {
              version = "0.1";
            };
          };
          build-dependencies = {
            autocfg = {
              version = "0.1";
            };
          };
          features = {
            alloc = [
              "rand_core/alloc"
            ];
            default = [
              "std"
            ];
            i128_support = [
            ];
            nightly = [
              "simd_support"
            ];
            serde1 = [
              "rand_core/serde1"
              "rand_isaac/serde1"
              "rand_xorshift/serde1"
            ];
            simd_support = [
              "packed_simd"
            ];
            std = [
              "rand_core/std"
              "alloc"
              "rand_os"
              "rand_jitter/std"
            ];
            stdweb = [
              "rand_os/stdweb"
            ];
            wasm-bindgen = [
              "rand_os/wasm-bindgen"
            ];
          };
          target = {
            "cfg(unix)" = {
              dependencies = {
                libc = {
                  version = "0.2";
                  default-features = false;
                };
              };
            };
            "cfg(windows)" = {
              dependencies = {
                winapi = {
                  version = "0.3";
                  features = [
                    "minwindef"
                    "ntsecapi"
                    "profileapi"
                    "winnt"
                  ];
                };
              };
            };
          };
          badges = {
            appveyor = {
              repository = "rust-random/rand";
            };
            travis-ci = {
              repository = "rust-random/rand";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".glob."0.3.0" = mkRustCrate {
        package-id = "glob 0.3.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "glob";
          version = "0.3.0";
          sha256 = "9b919933a397b79c37e33b77bb2aa3dc8eb6e165ad809e58ff75bc7db2e34574";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "glob";
            version = "0.3.0";
            authors = [
              "The Rust Project Developers"
            ];
            description = "Support for matching file paths against Unix shell style patterns.\n";
            homepage = "https://github.com/rust-lang/glob";
            documentation = "https://docs.rs/glob/0.3.0";
            categories = [
              "filesystem"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/rust-lang/glob";
          };
          dev-dependencies = {
            tempdir = {
              version = "0.3";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".tar."0.4.26" = mkRustCrate {
        package-id = "tar 0.4.26 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "tar";
          version = "0.4.26";
          sha256 = "b3196bfbffbba3e57481b6ea32249fbaf590396a52505a2615adbb79d9d826d3";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "filetime"
            ];
            extern-name = "filetime";
            package-id = "filetime 0.2.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "redox_syscall"
            ];
            extern-name = "syscall";
            package-id = "redox_syscall 0.1.54 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            edition = "2018";
            name = "tar";
            version = "0.4.26";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            exclude = [
              "tests/archives/*"
            ];
            description = "A Rust implementation of a TAR file reader and writer. This library does not\ncurrently handle compression, but it is abstract over all I/O readers and\nwriters. Additionally, great lengths are taken to ensure that the entire\ncontents are never required to be entirely resident in memory all at once.\n";
            homepage = "https://github.com/alexcrichton/tar-rs";
            documentation = "https://docs.rs/tar";
            readme = "README.md";
            keywords = [
              "tar"
              "tarfile"
              "encoding"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/tar-rs";
          };
          dependencies = {
            filetime = {
              version = "0.2.6";
            };
          };
          dev-dependencies = {
            tempdir = {
              version = "0.3";
            };
          };
          features = {
            default = [
              "xattr"
            ];
          };
          target = {
            "cfg(target_os = \"redox\")" = {
              dependencies = {
                redox_syscall = {
                  version = "0.1";
                };
              };
            };
            "cfg(unix)" = {
              dependencies = {
                libc = {
                  version = "0.2";
                };
                xattr = {
                  version = "0.2";
                  optional = true;
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".mio-uds."0.6.7" = mkRustCrate {
        package-id = "mio-uds 0.6.7 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "mio-uds";
          version = "0.6.7";
          sha256 = "966257a94e196b11bb43aca423754d87429960a768de9414f3691d6957abf125";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "iovec"
            ];
            extern-name = "iovec";
            package-id = "iovec 0.1.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "mio"
            ];
            extern-name = "mio";
            package-id = "mio 0.6.19 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "mio-uds";
            version = "0.6.7";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "Unix domain socket bindings for mio\n";
            homepage = "https://github.com/alexcrichton/mio-uds";
            documentation = "https://docs.rs/mio-uds";
            readme = "README.md";
            categories = [
              "asynchronous"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/mio-uds";
          };
          dev-dependencies = {
            tempdir = {
              version = "0.3";
            };
          };
          target = {
            "cfg(unix)" = {
              dependencies = {
                iovec = {
                  version = "0.1";
                };
                libc = {
                  version = "0.2.42";
                };
                mio = {
                  version = "0.6.5";
                };
              };
            };
          };
          badges = {
            travis-ci = {
              repository = "alexcrichton/mio-uds";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".itoa."0.4.4" = mkRustCrate {
        package-id = "itoa 0.4.4 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "itoa";
          version = "0.4.4";
          sha256 = "501266b7edd0174f8530248f87f99c88fbe60ca4ef3dd486835b8d8d53136f7f";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "itoa";
            version = "0.4.4";
            authors = [
              "David Tolnay <dtolnay@gmail.com>"
            ];
            exclude = [
              "performance.png"
            ];
            description = "Fast functions for printing integer primitives to an io::Write";
            documentation = "https://github.com/dtolnay/itoa";
            readme = "README.md";
            categories = [
              "value-formatting"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/dtolnay/itoa";
          };
          features = {
            default = [
              "std"
            ];
            i128 = [
            ];
            std = [
            ];
          };
          badges = {
            travis-ci = {
              repository = "dtolnay/itoa";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".serde_json."1.0.39" = mkRustCrate {
        package-id = "serde_json 1.0.39 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "serde_json";
          version = "1.0.39";
          sha256 = "5a23aa71d4a4d43fdbfaac00eff68ba8a06a51759a89ac3304323e800c4dd40d";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "itoa"
              "itoa"
            ];
            extern-name = "itoa";
            package-id = "itoa 0.4.4 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "ryu"
              "ryu"
            ];
            extern-name = "ryu";
            package-id = "ryu 0.2.8 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "serde"
              "serde"
            ];
            extern-name = "serde";
            package-id = "serde 1.0.92 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "serde_json";
            version = "1.0.39";
            authors = [
              "Erick Tryzelaar <erick.tryzelaar@gmail.com>"
              "David Tolnay <dtolnay@gmail.com>"
            ];
            include = [
              "Cargo.toml"
              "src/**/*.rs"
              "README.md"
              "LICENSE-APACHE"
              "LICENSE-MIT"
            ];
            description = "A JSON serialization file format";
            documentation = "http://docs.serde.rs/serde_json/";
            readme = "README.md";
            keywords = [
              "json"
              "serde"
              "serialization"
            ];
            categories = [
              "encoding"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/serde-rs/json";
            metadata = {
              docs = {
                rs = {
                  features = [
                    "raw_value"
                    "unbounded_depth"
                  ];
                };
              };
              playground = {
                features = [
                  "raw_value"
                ];
              };
            };
          };
          dependencies = {
            indexmap = {
              version = "1.0";
              optional = true;
            };
            itoa = {
              version = "0.4.3";
            };
            ryu = {
              version = "0.2";
            };
            serde = {
              version = "1.0.60";
            };
          };
          dev-dependencies = {
            automod = {
              version = "0.1";
            };
            compiletest_rs = {
              version = "0.3";
              features = [
                "stable"
              ];
            };
            serde_bytes = {
              version = "0.10";
            };
            serde_derive = {
              version = "1.0";
            };
            serde_stacker = {
              version = "0.1";
            };
          };
          features = {
            arbitrary_precision = [
            ];
            default = [
            ];
            preserve_order = [
              "indexmap"
            ];
            raw_value = [
            ];
            unbounded_depth = [
            ];
          };
          badges = {
            appveyor = {
              repository = "serde-rs/json";
            };
            travis-ci = {
              repository = "serde-rs/json";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".crc."1.8.1" = mkRustCrate {
        package-id = "crc 1.8.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "crc";
          version = "1.8.1";
          sha256 = "d663548de7f5cca343f1e0a48d14dcfb0e9eb4e079ec58883b7251539fa10aeb";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "build_const"
            ];
            extern-name = "build_const";
            package-id = "build_const 0.2.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "crc";
            version = "1.8.1";
            authors = [
              "Rui Hu <code@mrhooray.com>"
            ];
            description = "Rust implementation of CRC(16, 32, 64) with support of various standards";
            documentation = "https://docs.rs/crc";
            readme = "README.md";
            keywords = [
              "crc"
              "crc16"
              "crc32"
              "crc64"
              "hash"
            ];
            license = "MIT OR Apache-2.0";
            repository = "https://github.com/mrhooray/crc-rs.git";
          };
          build-dependencies = {
            build_const = {
              version = "0.2";
            };
          };
          features = {
            default = [
              "std"
            ];
            std = [
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".winapi-x86_64-pc-windows-gnu."0.4.0" = mkRustCrate {
        package-id = "winapi-x86_64-pc-windows-gnu 0.4.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "winapi-x86_64-pc-windows-gnu";
          version = "0.4.0";
          sha256 = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "winapi-x86_64-pc-windows-gnu";
            version = "0.4.0";
            authors = [
              "Peter Atashian <retep998@gmail.com>"
            ];
            build = "build.rs";
            include = [
              "src/*"
              "lib/*"
              "Cargo.toml"
              "build.rs"
            ];
            description = "Import libraries for the x86_64-pc-windows-gnu target. Please don't use this crate directly, depend on winapi instead.";
            keywords = [
              "windows"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/retep998/winapi-rs";
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".rdrand."0.4.0" = mkRustCrate {
        package-id = "rdrand 0.4.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "rdrand";
          version = "0.4.0";
          sha256 = "678054eb77286b51581ba43620cc911abf02758c91f93f479767aed0f90458b2";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "rand_core"
            ];
            extern-name = "rand_core";
            package-id = "rand_core 0.3.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "rdrand";
            version = "0.4.0";
            authors = [
              "Simonas Kazlauskas <rdrand@kazlauskas.me>"
            ];
            description = "An implementation of random number generator based on rdrand and rdseed instructions";
            documentation = "https://docs.rs/rdrand/0.4.0/";
            keywords = [
              "rand"
              "rdrand"
              "rdseed"
              "random"
            ];
            license = "ISC";
            repository = "https://github.com/nagisa/rust_rdrand/";
          };
          dependencies = {
            rand_core = {
              version = "0.3";
              default-features = false;
            };
          };
          features = {
            default = [
              "std"
            ];
            std = [
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".crossbeam-utils."0.6.5" = mkRustCrate {
        package-id = "crossbeam-utils 0.6.5 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "crossbeam-utils";
          version = "0.6.5";
          sha256 = "f8306fcef4a7b563b76b7dd949ca48f52bc1141aa067d2ea09565f3e2652aa5c";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "cfg-if"
            ];
            extern-name = "cfg_if";
            package-id = "cfg-if 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "lazy_static"
            ];
            extern-name = "lazy_static";
            package-id = "lazy_static 1.3.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "crossbeam-utils";
            version = "0.6.5";
            authors = [
              "The Crossbeam Project Developers"
            ];
            description = "Utilities for concurrent programming";
            homepage = "https://github.com/crossbeam-rs/crossbeam/tree/master/crossbeam-utils";
            documentation = "https://docs.rs/crossbeam-utils";
            readme = "README.md";
            keywords = [
              "scoped"
              "thread"
              "atomic"
              "cache"
            ];
            categories = [
              "algorithms"
              "concurrency"
              "data-structures"
              "no-std"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/crossbeam-rs/crossbeam";
          };
          dependencies = {
            cfg-if = {
              version = "0.1";
            };
            lazy_static = {
              version = "1.1.0";
              optional = true;
            };
          };
          dev-dependencies = {
            rand = {
              version = "0.6";
            };
          };
          features = {
            default = [
              "std"
            ];
            nightly = [
            ];
            std = [
              "lazy_static"
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".clap."2.33.0" = mkRustCrate {
        package-id = "clap 2.33.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "clap";
          version = "2.33.0";
          sha256 = "5067f5bb2d80ef5d68b4c87db81601f0b75bca627bc2ef76b141d7b846a3c6d9";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "ansi_term"
            ];
            extern-name = "ansi_term";
            package-id = "ansi_term 0.11.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "atty"
            ];
            extern-name = "atty";
            package-id = "atty 0.2.11 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "bitflags"
            ];
            extern-name = "bitflags";
            package-id = "bitflags 1.1.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "strsim"
            ];
            extern-name = "strsim";
            package-id = "strsim 0.8.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "textwrap"
            ];
            extern-name = "textwrap";
            package-id = "textwrap 0.11.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "unicode-width"
            ];
            extern-name = "unicode_width";
            package-id = "unicode-width 0.1.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "vec_map"
            ];
            extern-name = "vec_map";
            package-id = "vec_map 0.8.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "clap";
            version = "2.33.0";
            authors = [
              "Kevin K. <kbknapp@gmail.com>"
            ];
            exclude = [
              "examples/*"
              "clap-test/*"
              "tests/*"
              "benches/*"
              "*.png"
              "clap-perf/*"
              "*.dot"
            ];
            description = "A simple to use, efficient, and full-featured Command Line Argument Parser\n";
            homepage = "https://clap.rs/";
            documentation = "https://docs.rs/clap/";
            readme = "README.md";
            keywords = [
              "argument"
              "cli"
              "arg"
              "parser"
              "parse"
            ];
            categories = [
              "command-line-interface"
            ];
            license = "MIT";
            repository = "https://github.com/clap-rs/clap";
            metadata = {
              docs = {
                rs = {
                  features = [
                    "doc"
                  ];
                };
              };
            };
          };
          profile = {
            test = {
              opt-level = 1;
              lto = false;
              codegen-units = 4;
              debug = true;
              debug-assertions = true;
              rpath = false;
            };
            bench = {
              opt-level = 3;
              lto = true;
              codegen-units = 1;
              debug = false;
              debug-assertions = false;
              rpath = false;
            };
            dev = {
              opt-level = 0;
              lto = false;
              codegen-units = 4;
              debug = true;
              debug-assertions = true;
              rpath = false;
            };
            release = {
              opt-level = 3;
              lto = true;
              codegen-units = 1;
              debug = false;
              debug-assertions = false;
              rpath = false;
            };
          };
          dependencies = {
            atty = {
              version = "0.2.2";
              optional = true;
            };
            bitflags = {
              version = "1.0";
            };
            clippy = {
              version = "~0.0.166";
              optional = true;
            };
            strsim = {
              version = "0.8";
              optional = true;
            };
            term_size = {
              version = "0.3.0";
              optional = true;
            };
            textwrap = {
              version = "0.11.0";
            };
            unicode-width = {
              version = "0.1.4";
            };
            vec_map = {
              version = "0.8";
              optional = true;
            };
            yaml-rust = {
              version = "0.3.5";
              optional = true;
            };
          };
          dev-dependencies = {
            lazy_static = {
              version = "1.3";
            };
            regex = {
              version = "1";
            };
            version-sync = {
              version = "0.8";
            };
          };
          features = {
            color = [
              "ansi_term"
              "atty"
            ];
            debug = [
            ];
            default = [
              "suggestions"
              "color"
              "vec_map"
            ];
            doc = [
              "yaml"
            ];
            lints = [
              "clippy"
            ];
            nightly = [
            ];
            no_cargo = [
            ];
            suggestions = [
              "strsim"
            ];
            unstable = [
            ];
            wrap_help = [
              "term_size"
              "textwrap/term_size"
            ];
            yaml = [
              "yaml-rust"
            ];
          };
          target = {
            "cfg(not(windows))" = {
              dependencies = {
                ansi_term = {
                  version = "0.11";
                  optional = true;
                };
              };
            };
          };
          badges = {
            appveyor = {
              repository = "clap-rs/clap";
            };
            coveralls = {
              branch = "master";
              repository = "clap-rs/clap";
            };
            is-it-maintained-issue-resolution = {
              repository = "clap-rs/clap";
            };
            is-it-maintained-open-issues = {
              repository = "clap-rs/clap";
            };
            maintenance = {
              status = "actively-developed";
            };
            travis-ci = {
              repository = "clap-rs/clap";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".url_serde."0.2.0" = mkRustCrate {
        package-id = "url_serde 0.2.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "url_serde";
          version = "0.2.0";
          sha256 = "74e7d099f1ee52f823d4bdd60c93c3602043c728f5db3b97bdb548467f7bddea";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "serde"
            ];
            extern-name = "serde";
            package-id = "serde 1.0.92 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "url"
            ];
            extern-name = "url";
            package-id = "url 1.7.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "url_serde";
            version = "0.2.0";
            authors = [
              "The rust-url developers"
            ];
            description = "Serde support for URL types";
            documentation = "https://docs.rs/url_serde/";
            readme = "README.md";
            keywords = [
              "url"
              "serde"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/servo/rust-url";
          };
          lib = {
            doctest = false;
          };
          dependencies = {
            serde = "1.0";
            url = "1.0.0";
          };
          dev-dependencies = {
            serde_derive = "1.0";
            serde_json = "1.0";
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".autocfg."0.1.4" = mkRustCrate {
        package-id = "autocfg 0.1.4 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "autocfg";
          version = "0.1.4";
          sha256 = "0e49efa51329a5fd37e7c79db4621af617cd4e3e5bc224939808d076077077bf";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "autocfg";
            version = "0.1.4";
            authors = [
              "Josh Stone <cuviper@gmail.com>"
            ];
            description = "Automatic cfg for Rust compiler features";
            readme = "README.md";
            keywords = [
              "rustc"
              "build"
              "autoconf"
            ];
            categories = [
              "development-tools::build-utils"
            ];
            license = "Apache-2.0/MIT";
            repository = "https://github.com/cuviper/autocfg";
          };
          dependencies = {
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".synstructure."0.10.2" = mkRustCrate {
        package-id = "synstructure 0.10.2 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "synstructure";
          version = "0.10.2";
          sha256 = "02353edf96d6e4dc81aea2d8490a7e9db177bf8acb0e951c24940bf866cb313f";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "proc-macro2"
            ];
            extern-name = "proc_macro2";
            package-id = "proc-macro2 0.4.30 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "quote"
            ];
            extern-name = "quote";
            package-id = "quote 0.6.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "syn"
            ];
            extern-name = "syn";
            package-id = "syn 0.15.36 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "unicode-xid"
            ];
            extern-name = "unicode_xid";
            package-id = "unicode-xid 0.1.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "synstructure";
            version = "0.10.2";
            authors = [
              "Nika Layzell <nika@thelayzells.com>"
            ];
            include = [
              "src/**/*"
              "Cargo.toml"
              "README.md"
              "LICENSE"
            ];
            description = "Helper methods and macros for custom derives";
            documentation = "https://docs.rs/synstructure";
            readme = "README.md";
            keywords = [
              "syn"
              "macros"
              "derive"
              "expand_substructure"
              "enum"
            ];
            license = "MIT";
            repository = "https://github.com/mystor/synstructure";
          };
          dependencies = {
            proc-macro2 = {
              version = "0.4";
            };
            quote = {
              version = "0.6";
            };
            syn = {
              version = "0.15";
              features = [
                "visit"
                "extra-traits"
              ];
            };
            unicode-xid = {
              version = "0.1";
            };
          };
          dev-dependencies = {
            synstructure_test_traits = {
              version = "0.1";
            };
          };
          features = {
            simple-derive = [
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".openssl-sys."0.9.47" = mkRustCrate {
        package-id = "openssl-sys 0.9.47 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "openssl-sys";
          version = "0.9.47";
          sha256 = "75bdd6dbbb4958d38e47a1d2348847ad1eb4dc205dc5d37473ae504391865acc";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "autocfg"
            ];
            extern-name = "autocfg";
            package-id = "autocfg 0.1.4 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "cc"
            ];
            extern-name = "cc";
            package-id = "cc 1.0.37 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "pkg-config"
            ];
            extern-name = "pkg_config";
            package-id = "pkg-config 0.3.14 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "vcpkg"
            ];
            extern-name = "vcpkg";
            package-id = "vcpkg 0.2.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "openssl-sys";
            version = "0.9.47";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
              "Steven Fackler <sfackler@gmail.com>"
            ];
            build = "build/main.rs";
            links = "openssl";
            description = "FFI bindings to OpenSSL";
            readme = "README.md";
            categories = [
              "cryptography"
              "external-ffi-bindings"
            ];
            license = "MIT";
            repository = "https://github.com/sfackler/rust-openssl";
            metadata = {
              pkg-config = {
                openssl = "1.0.1";
              };
            };
          };
          dependencies = {
            libc = {
              version = "0.2";
            };
          };
          build-dependencies = {
            autocfg = {
              version = "0.1.2";
            };
            cc = {
              version = "1.0";
            };
            openssl-src = {
              version = "111.0.1";
              optional = true;
            };
            pkg-config = {
              version = "0.3.9";
            };
          };
          features = {
            vendored = [
              "openssl-src"
            ];
          };
          target = {
            "cfg(target_env = \"msvc\")" = {
              build-dependencies = {
                vcpkg = {
                  version = "0.2";
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".percent-encoding."1.0.1" = mkRustCrate {
        package-id = "percent-encoding 1.0.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "percent-encoding";
          version = "1.0.1";
          sha256 = "31010dd2e1ac33d5b46a5b413495239882813e0369f8ed8a5e266f173602f831";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "percent-encoding";
            version = "1.0.1";
            authors = [
              "The rust-url developers"
            ];
            description = "Percent encoding and decoding";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/servo/rust-url/";
          };
          lib = {
            path = "lib.rs";
            test = false;
            doctest = false;
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".fuchsia-cprng."0.1.1" = mkRustCrate {
        package-id = "fuchsia-cprng 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "fuchsia-cprng";
          version = "0.1.1";
          sha256 = "a06f77d526c1a601b7c4cdd98f54b5eaabffc14d5f2f0296febdc7f357c6d3ba";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            edition = "2018";
            name = "fuchsia-cprng";
            version = "0.1.1";
            authors = [
              "Erick Tryzelaar <etryzelaar@google.com>"
            ];
            include = [
              "src/*.rs"
              "Cargo.toml"
              "AUTHORS"
              "LICENSE"
              "PATENTS"
            ];
            description = "Rust crate for the Fuchsia cryptographically secure pseudorandom number generator";
            readme = "README.md";
            license-file = "LICENSE";
            repository = "https://fuchsia.googlesource.com/fuchsia/+/master/garnet/public/rust/fuchsia-cprng";
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".adler32."1.0.3" = mkRustCrate {
        package-id = "adler32 1.0.3 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "adler32";
          version = "1.0.3";
          sha256 = "7e522997b529f05601e05166c07ed17789691f562762c7f3b987263d2dedee5c";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "adler32";
            version = "1.0.3";
            authors = [
              "Remi Rampin <remirampin@gmail.com>"
            ];
            description = "Minimal Adler32 implementation for Rust.";
            documentation = "https://remram44.github.io/adler32-rs/index.html";
            readme = "README.md";
            keywords = [
              "adler32"
              "hash"
              "rolling"
            ];
            license = "BSD-3-Clause AND Zlib";
            repository = "https://github.com/remram44/adler32-rs";
          };
          dev-dependencies = {
            rand = {
              version = "0.4";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".crossbeam-queue."0.1.2" = mkRustCrate {
        package-id = "crossbeam-queue 0.1.2 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "crossbeam-queue";
          version = "0.1.2";
          sha256 = "7c979cd6cfe72335896575c6b5688da489e420d36a27a0b9eb0c73db574b4a4b";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "crossbeam-utils"
            ];
            extern-name = "crossbeam_utils";
            package-id = "crossbeam-utils 0.6.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "crossbeam-queue";
            version = "0.1.2";
            authors = [
              "The Crossbeam Project Developers"
            ];
            description = "Concurrent queues";
            homepage = "https://github.com/crossbeam-rs/crossbeam/tree/master/crossbeam-utils";
            documentation = "https://docs.rs/crossbeam-queue";
            readme = "README.md";
            keywords = [
              "queue"
              "mpmc"
              "lock-free"
              "producer"
              "consumer"
            ];
            categories = [
              "concurrency"
              "data-structures"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/crossbeam-rs/crossbeam";
          };
          dependencies = {
            crossbeam-utils = {
              version = "0.6.5";
            };
          };
          dev-dependencies = {
            rand = {
              version = "0.6";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".walkdir."2.2.8" = mkRustCrate {
        package-id = "walkdir 2.2.8 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "walkdir";
          version = "2.2.8";
          sha256 = "c7904a7e2bb3cdf0cf5e783f44204a85a37a93151738fa349f06680f59a98b45";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "same-file"
            ];
            extern-name = "same_file";
            package-id = "same-file 1.0.4 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi-util"
            ];
            extern-name = "winapi_util";
            package-id = "winapi-util 0.1.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "walkdir";
            version = "2.2.8";
            authors = [
              "Andrew Gallant <jamslam@gmail.com>"
            ];
            exclude = [
              "/ci/*"
              "/.travis.yml"
              "/appveyor.yml"
            ];
            description = "Recursively walk a directory.";
            homepage = "https://github.com/BurntSushi/walkdir";
            documentation = "https://docs.rs/walkdir/";
            readme = "README.md";
            keywords = [
              "directory"
              "recursive"
              "walk"
              "iterator"
            ];
            categories = [
              "filesystem"
            ];
            license = "Unlicense/MIT";
            repository = "https://github.com/BurntSushi/walkdir";
          };
          dependencies = {
            same-file = {
              version = "1.0.1";
            };
          };
          dev-dependencies = {
            doc-comment = {
              version = "0.3";
            };
            docopt = {
              version = "1.0.1";
            };
            quickcheck = {
              version = "0.8";
              default-features = false;
            };
            rand = {
              version = "0.6";
            };
            serde = {
              version = "1";
            };
            serde_derive = {
              version = "1";
            };
          };
          target = {
            "cfg(windows)" = {
              dependencies = {
                winapi = {
                  version = "0.3";
                  features = [
                    "std"
                    "winnt"
                  ];
                };
                winapi-util = {
                  version = "0.1.1";
                };
              };
            };
          };
          badges = {
            appveyor = {
              repository = "BurntSushi/walkdir";
            };
            travis-ci = {
              repository = "BurntSushi/walkdir";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".rustc_version."0.2.3" = mkRustCrate {
        package-id = "rustc_version 0.2.3 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "rustc_version";
          version = "0.2.3";
          sha256 = "138e3e0acb6c9fb258b19b67cb8abd63c00679d2851805ea151465464fe9030a";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "semver"
            ];
            extern-name = "semver";
            package-id = "semver 0.9.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "rustc_version";
            version = "0.2.3";
            authors = [
              "Marvin Löbel <loebel.marvin@gmail.com>"
            ];
            description = "A library for querying the version of a installed rustc compiler";
            documentation = "https://docs.rs/rustc_version/";
            readme = "README.md";
            keywords = [
              "version"
              "rustc"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/Kimundi/rustc-version-rs";
          };
          dependencies = {
            semver = {
              version = "0.9";
            };
          };
          badges = {
            travis-ci = {
              repository = "Kimundi/rustc-version-rs";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".textwrap."0.11.0" = mkRustCrate {
        package-id = "textwrap 0.11.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "textwrap";
          version = "0.11.0";
          sha256 = "d326610f408c7a4eb6f51c37c330e496b08506c9457c9d34287ecc38809fb060";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "unicode-width"
            ];
            extern-name = "unicode_width";
            package-id = "unicode-width 0.1.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "textwrap";
            version = "0.11.0";
            authors = [
              "Martin Geisler <martin@geisler.net>"
            ];
            exclude = [
              ".dir-locals.el"
            ];
            description = "Textwrap is a small library for word wrapping, indenting, and\ndedenting strings.\n\nYou can use it to format strings (such as help and error messages) for\ndisplay in commandline applications. It is designed to be efficient\nand handle Unicode characters correctly.\n";
            documentation = "https://docs.rs/textwrap/";
            readme = "README.md";
            keywords = [
              "text"
              "formatting"
              "wrap"
              "typesetting"
              "hyphenation"
            ];
            categories = [
              "text-processing"
              "command-line-interface"
            ];
            license = "MIT";
            repository = "https://github.com/mgeisler/textwrap";
            metadata = {
              docs = {
                rs = {
                  all-features = true;
                };
              };
            };
          };
          dependencies = {
            hyphenation = {
              version = "0.7.1";
              features = [
                "embed_all"
              ];
              optional = true;
            };
            term_size = {
              version = "0.3.0";
              optional = true;
            };
            unicode-width = {
              version = "0.1.3";
            };
          };
          dev-dependencies = {
            lipsum = {
              version = "0.6";
            };
            rand = {
              version = "0.6";
            };
            rand_xorshift = {
              version = "0.1";
            };
            version-sync = {
              version = "0.6";
            };
          };
          badges = {
            appveyor = {
              repository = "mgeisler/textwrap";
            };
            codecov = {
              repository = "mgeisler/textwrap";
            };
            travis-ci = {
              repository = "mgeisler/textwrap";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".fs2."0.4.3" = mkRustCrate {
        package-id = "fs2 0.4.3 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "fs2";
          version = "0.4.3";
          sha256 = "9564fc758e15025b46aa6643b1b77d047d1a56a1aea6e01002ac0c7026876213";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "fs2";
            version = "0.4.3";
            authors = [
              "Dan Burkert <dan@danburkert.com>"
            ];
            description = "Cross-platform file locks and file duplication.";
            documentation = "https://docs.rs/fs2";
            keywords = [
              "file"
              "file-system"
              "lock"
              "duplicate"
              "flock"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/danburkert/fs2-rs";
          };
          dev-dependencies = {
            tempdir = {
              version = "0.3";
            };
          };
          target = {
            "cfg(unix)" = {
              dependencies = {
                libc = {
                  version = "0.2.30";
                };
              };
            };
            "cfg(windows)" = {
              dependencies = {
                winapi = {
                  version = "0.3";
                  features = [
                    "handleapi"
                    "processthreadsapi"
                    "winerror"
                    "fileapi"
                    "winbase"
                    "std"
                  ];
                };
              };
            };
          };
          badges = {
            appveyor = {
              repository = "danburkert/fs2-rs";
            };
            travis-ci = {
              repository = "danburkert/fs2-rs";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".parking_lot_core."0.4.0" = mkRustCrate {
        package-id = "parking_lot_core 0.4.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "parking_lot_core";
          version = "0.4.0";
          sha256 = "94c8c7923936b28d546dfd14d4472eaf34c99b14e1c973a32b3e6d4eb04298c9";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rand"
            ];
            extern-name = "rand";
            package-id = "rand 0.6.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rustc_version"
            ];
            extern-name = "rustc_version";
            package-id = "rustc_version 0.2.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "smallvec"
            ];
            extern-name = "smallvec";
            package-id = "smallvec 0.6.10 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "parking_lot_core";
            version = "0.4.0";
            authors = [
              "Amanieu d'Antras <amanieu@gmail.com>"
            ];
            description = "An advanced API for creating custom synchronization primitives.";
            keywords = [
              "mutex"
              "condvar"
              "rwlock"
              "once"
              "thread"
            ];
            categories = [
              "concurrency"
            ];
            license = "Apache-2.0/MIT";
            repository = "https://github.com/Amanieu/parking_lot";
          };
          dependencies = {
            backtrace = {
              version = "0.3.2";
              optional = true;
            };
            petgraph = {
              version = "0.4.5";
              optional = true;
            };
            rand = {
              version = "0.6";
            };
            smallvec = {
              version = "0.6";
            };
            thread-id = {
              version = "3.2.0";
              optional = true;
            };
          };
          build-dependencies = {
            rustc_version = {
              version = "0.2";
            };
          };
          features = {
            deadlock_detection = [
              "petgraph"
              "thread-id"
              "backtrace"
            ];
            nightly = [
            ];
          };
          target = {
            "cfg(unix)" = {
              dependencies = {
                libc = {
                  version = "0.2.27";
                };
              };
            };
            "cfg(windows)" = {
              dependencies = {
                winapi = {
                  version = "0.3";
                  features = [
                    "winnt"
                    "ntstatus"
                    "minwindef"
                    "winerror"
                    "winbase"
                    "errhandlingapi"
                    "handleapi"
                  ];
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".failure."0.1.5" = mkRustCrate {
        package-id = "failure 0.1.5 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "failure";
          version = "0.1.5";
          sha256 = "795bd83d3abeb9220f257e597aa0080a508b27533824adf336529648f6abf7e2";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "backtrace"
            ];
            extern-name = "backtrace";
            package-id = "backtrace 0.3.30 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "failure_derive"
            ];
            extern-name = "failure_derive";
            package-id = "failure_derive 0.1.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "failure";
            version = "0.1.5";
            authors = [
              "Without Boats <boats@mozilla.com>"
            ];
            description = "Experimental error handling abstraction.";
            homepage = "https://rust-lang-nursery.github.io/failure/";
            documentation = "https://docs.rs/failure";
            license = "MIT OR Apache-2.0";
            repository = "https://github.com/rust-lang-nursery/failure";
          };
          dependencies = {
            backtrace = {
              version = "0.3.3";
              optional = true;
            };
            failure_derive = {
              version = "0.1.5";
              optional = true;
            };
          };
          features = {
            default = [
              "std"
              "derive"
            ];
            derive = [
              "failure_derive"
            ];
            std = [
              "backtrace"
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".redox_syscall."0.1.54" = mkRustCrate {
        package-id = "redox_syscall 0.1.54 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "redox_syscall";
          version = "0.1.54";
          sha256 = "12229c14a0f65c4f1cb046a3b52047cdd9da1f4b30f8a39c5063c8bae515e252";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "redox_syscall";
            version = "0.1.54";
            authors = [
              "Jeremy Soller <jackpot51@gmail.com>"
            ];
            description = "A Rust library to access raw Redox system calls";
            documentation = "https://docs.rs/redox_syscall";
            license = "MIT";
            repository = "https://gitlab.redox-os.org/redox-os/syscall";
          };
          lib = {
            name = "syscall";
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".tokio-executor."0.1.7" = mkRustCrate {
        package-id = "tokio-executor 0.1.7 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "tokio-executor";
          version = "0.1.7";
          sha256 = "83ea44c6c0773cc034771693711c35c677b4b5a4b21b9e7071704c54de7d555e";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "crossbeam-utils"
            ];
            extern-name = "crossbeam_utils";
            package-id = "crossbeam-utils 0.6.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "futures"
            ];
            extern-name = "futures";
            package-id = "futures 0.1.27 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "tokio-executor";
            version = "0.1.7";
            authors = [
              "Carl Lerche <me@carllerche.com>"
            ];
            description = "Future execution primitives\n";
            homepage = "https://github.com/tokio-rs/tokio";
            documentation = "https://docs.rs/tokio-executor/0.1.7/tokio_executor";
            keywords = [
              "futures"
              "tokio"
            ];
            categories = [
              "concurrency"
              "asynchronous"
            ];
            license = "MIT";
            repository = "https://github.com/tokio-rs/tokio";
          };
          dependencies = {
            crossbeam-utils = {
              version = "0.6.2";
            };
            futures = {
              version = "0.1.19";
            };
          };
          dev-dependencies = {
            tokio = {
              version = "0.1.17";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".winapi."0.3.7" = mkRustCrate {
        package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "winapi";
          version = "0.3.7";
          sha256 = "f10e386af2b13e47c89e7236a7a14a086791a2b88ebad6df9bf42040195cf770";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "winapi-i686-pc-windows-gnu"
              "winapi-i686-pc-windows-gnu"
              "winapi-i686-pc-windows-gnu"
              "winapi-i686-pc-windows-gnu"
              "winapi-i686-pc-windows-gnu"
              "winapi-i686-pc-windows-gnu"
              "winapi-i686-pc-windows-gnu"
              "winapi-i686-pc-windows-gnu"
              "winapi-i686-pc-windows-gnu"
              "winapi-i686-pc-windows-gnu"
              "winapi-i686-pc-windows-gnu"
              "winapi-i686-pc-windows-gnu"
              "winapi-i686-pc-windows-gnu"
            ];
            extern-name = "winapi_i686_pc_windows_gnu";
            package-id = "winapi-i686-pc-windows-gnu 0.4.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi-x86_64-pc-windows-gnu"
              "winapi-x86_64-pc-windows-gnu"
              "winapi-x86_64-pc-windows-gnu"
              "winapi-x86_64-pc-windows-gnu"
              "winapi-x86_64-pc-windows-gnu"
              "winapi-x86_64-pc-windows-gnu"
              "winapi-x86_64-pc-windows-gnu"
              "winapi-x86_64-pc-windows-gnu"
              "winapi-x86_64-pc-windows-gnu"
              "winapi-x86_64-pc-windows-gnu"
              "winapi-x86_64-pc-windows-gnu"
              "winapi-x86_64-pc-windows-gnu"
              "winapi-x86_64-pc-windows-gnu"
            ];
            extern-name = "winapi_x86_64_pc_windows_gnu";
            package-id = "winapi-x86_64-pc-windows-gnu 0.4.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "winapi";
            version = "0.3.7";
            authors = [
              "Peter Atashian <retep998@gmail.com>"
            ];
            build = "build.rs";
            include = [
              "/src/**/*"
              "/Cargo.toml"
              "/LICENSE-MIT"
              "/LICENSE-APACHE"
              "/build.rs"
              "/README.md"
            ];
            description = "Raw FFI bindings for all of Windows API.";
            documentation = "https://docs.rs/winapi/*/x86_64-pc-windows-msvc/winapi/";
            readme = "README.md";
            keywords = [
              "windows"
              "ffi"
              "win32"
              "com"
              "directx"
            ];
            categories = [
              "external-ffi-bindings"
              "no-std"
              "os::windows-apis"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/retep998/winapi-rs";
            metadata = {
              docs = {
                rs = {
                  default-target = "x86_64-pc-windows-msvc";
                  features = [
                    "everything"
                    "impl-debug"
                    "impl-default"
                  ];
                };
              };
            };
          };
          features = {
            accctrl = [
            ];
            aclapi = [
            ];
            activation = [
            ];
            appmgmt = [
            ];
            audioclient = [
            ];
            audiosessiontypes = [
            ];
            avrt = [
            ];
            basetsd = [
            ];
            bcrypt = [
            ];
            bits = [
            ];
            bits10_1 = [
            ];
            bits1_5 = [
            ];
            bits2_0 = [
            ];
            bits2_5 = [
            ];
            bits3_0 = [
            ];
            bits4_0 = [
            ];
            bits5_0 = [
            ];
            bitscfg = [
            ];
            bitsmsg = [
            ];
            bugcodes = [
            ];
            cderr = [
            ];
            cfg = [
            ];
            cfgmgr32 = [
            ];
            cguid = [
            ];
            combaseapi = [
            ];
            coml2api = [
            ];
            commapi = [
            ];
            commctrl = [
            ];
            commdlg = [
            ];
            commoncontrols = [
            ];
            consoleapi = [
            ];
            corsym = [
            ];
            d2d1 = [
            ];
            d2d1_1 = [
            ];
            d2d1_2 = [
            ];
            d2d1_3 = [
            ];
            d2d1effectauthor = [
            ];
            d2d1effects = [
            ];
            d2d1effects_1 = [
            ];
            d2d1effects_2 = [
            ];
            d2d1svg = [
            ];
            d2dbasetypes = [
            ];
            d3d = [
            ];
            d3d10 = [
            ];
            d3d10_1 = [
            ];
            d3d10_1shader = [
            ];
            d3d10effect = [
            ];
            d3d10misc = [
            ];
            d3d10sdklayers = [
            ];
            d3d10shader = [
            ];
            d3d11 = [
            ];
            d3d11_1 = [
            ];
            d3d11_2 = [
            ];
            d3d11_3 = [
            ];
            d3d11_4 = [
            ];
            d3d11on12 = [
            ];
            d3d11sdklayers = [
            ];
            d3d11shader = [
            ];
            d3d11tokenizedprogramformat = [
            ];
            d3d12 = [
            ];
            d3d12sdklayers = [
            ];
            d3d12shader = [
            ];
            d3d9 = [
            ];
            d3d9caps = [
            ];
            d3d9types = [
            ];
            d3dcommon = [
            ];
            d3dcompiler = [
            ];
            d3dcsx = [
            ];
            d3dkmdt = [
            ];
            d3dkmthk = [
            ];
            d3dukmdt = [
            ];
            d3dx10core = [
            ];
            d3dx10math = [
            ];
            d3dx10mesh = [
            ];
            datetimeapi = [
            ];
            davclnt = [
            ];
            dbghelp = [
            ];
            dbt = [
            ];
            dcommon = [
            ];
            dcomp = [
            ];
            dcompanimation = [
            ];
            dcomptypes = [
            ];
            dde = [
            ];
            ddraw = [
            ];
            ddrawi = [
            ];
            ddrawint = [
            ];
            debug = [
              "impl-debug"
            ];
            debugapi = [
            ];
            devguid = [
            ];
            devicetopology = [
            ];
            devpkey = [
            ];
            devpropdef = [
            ];
            dinput = [
            ];
            dinputd = [
            ];
            dispex = [
            ];
            dmksctl = [
            ];
            dmusicc = [
            ];
            docobj = [
            ];
            documenttarget = [
            ];
            dpa_dsa = [
            ];
            dpapi = [
            ];
            dsgetdc = [
            ];
            dsound = [
            ];
            dsrole = [
            ];
            dvp = [
            ];
            dwmapi = [
            ];
            dwrite = [
            ];
            dwrite_1 = [
            ];
            dwrite_2 = [
            ];
            dwrite_3 = [
            ];
            dxdiag = [
            ];
            dxfile = [
            ];
            dxgi = [
            ];
            dxgi1_2 = [
            ];
            dxgi1_3 = [
            ];
            dxgi1_4 = [
            ];
            dxgi1_5 = [
            ];
            dxgi1_6 = [
            ];
            dxgidebug = [
            ];
            dxgiformat = [
            ];
            dxgitype = [
            ];
            dxva2api = [
            ];
            dxvahd = [
            ];
            enclaveapi = [
            ];
            endpointvolume = [
            ];
            errhandlingapi = [
            ];
            everything = [
            ];
            evntcons = [
            ];
            evntprov = [
            ];
            evntrace = [
            ];
            excpt = [
            ];
            exdisp = [
            ];
            fibersapi = [
            ];
            fileapi = [
            ];
            gl-gl = [
            ];
            guiddef = [
            ];
            handleapi = [
            ];
            heapapi = [
            ];
            hidclass = [
            ];
            hidpi = [
            ];
            hidsdi = [
            ];
            hidusage = [
            ];
            highlevelmonitorconfigurationapi = [
            ];
            hstring = [
            ];
            http = [
            ];
            ifdef = [
            ];
            imm = [
            ];
            impl-debug = [
            ];
            impl-default = [
            ];
            in6addr = [
            ];
            inaddr = [
            ];
            inspectable = [
            ];
            interlockedapi = [
            ];
            intsafe = [
            ];
            ioapiset = [
            ];
            jobapi = [
            ];
            jobapi2 = [
            ];
            knownfolders = [
            ];
            ks = [
            ];
            ksmedia = [
            ];
            ktmtypes = [
            ];
            ktmw32 = [
            ];
            libloaderapi = [
            ];
            limits = [
            ];
            lmaccess = [
            ];
            lmalert = [
            ];
            lmapibuf = [
            ];
            lmat = [
            ];
            lmcons = [
            ];
            lmdfs = [
            ];
            lmerrlog = [
            ];
            lmjoin = [
            ];
            lmmsg = [
            ];
            lmremutl = [
            ];
            lmrepl = [
            ];
            lmserver = [
            ];
            lmshare = [
            ];
            lmstats = [
            ];
            lmsvc = [
            ];
            lmuse = [
            ];
            lmwksta = [
            ];
            lowlevelmonitorconfigurationapi = [
            ];
            lsalookup = [
            ];
            memoryapi = [
            ];
            minschannel = [
            ];
            minwinbase = [
            ];
            minwindef = [
            ];
            mmdeviceapi = [
            ];
            mmeapi = [
            ];
            mmreg = [
            ];
            mmsystem = [
            ];
            msaatext = [
            ];
            mscat = [
            ];
            mschapp = [
            ];
            mssip = [
            ];
            mstcpip = [
            ];
            mswsock = [
            ];
            mswsockdef = [
            ];
            namedpipeapi = [
            ];
            namespaceapi = [
            ];
            nb30 = [
            ];
            ncrypt = [
            ];
            netioapi = [
            ];
            ntddscsi = [
            ];
            ntddser = [
            ];
            ntdef = [
            ];
            ntlsa = [
            ];
            ntsecapi = [
            ];
            ntstatus = [
            ];
            oaidl = [
            ];
            objbase = [
            ];
            objidl = [
            ];
            objidlbase = [
            ];
            ocidl = [
            ];
            ole2 = [
            ];
            oleauto = [
            ];
            olectl = [
            ];
            oleidl = [
            ];
            opmapi = [
            ];
            pdh = [
            ];
            perflib = [
            ];
            physicalmonitorenumerationapi = [
            ];
            playsoundapi = [
            ];
            portabledevice = [
            ];
            portabledeviceapi = [
            ];
            portabledevicetypes = [
            ];
            powerbase = [
            ];
            powersetting = [
            ];
            powrprof = [
            ];
            processenv = [
            ];
            processsnapshot = [
            ];
            processthreadsapi = [
            ];
            processtopologyapi = [
            ];
            profileapi = [
            ];
            propidl = [
            ];
            propkeydef = [
            ];
            propsys = [
            ];
            prsht = [
            ];
            psapi = [
            ];
            qos = [
            ];
            realtimeapiset = [
            ];
            reason = [
            ];
            restartmanager = [
            ];
            restrictederrorinfo = [
            ];
            rmxfguid = [
            ];
            roapi = [
            ];
            robuffer = [
            ];
            roerrorapi = [
            ];
            rpc = [
            ];
            rpcdce = [
            ];
            rpcndr = [
            ];
            sapi = [
            ];
            sapi51 = [
            ];
            sapi53 = [
            ];
            sapiddk = [
            ];
            sapiddk51 = [
            ];
            schannel = [
            ];
            sddl = [
            ];
            securityappcontainer = [
            ];
            securitybaseapi = [
            ];
            servprov = [
            ];
            setupapi = [
            ];
            shellapi = [
            ];
            shellscalingapi = [
            ];
            shlobj = [
            ];
            shobjidl = [
            ];
            shobjidl_core = [
            ];
            shtypes = [
            ];
            spapidef = [
            ];
            spellcheck = [
            ];
            sporder = [
            ];
            sql = [
            ];
            sqlext = [
            ];
            sqltypes = [
            ];
            sqlucode = [
            ];
            sspi = [
            ];
            std = [
            ];
            stralign = [
            ];
            stringapiset = [
            ];
            strmif = [
            ];
            subauth = [
            ];
            synchapi = [
            ];
            sysinfoapi = [
            ];
            systemtopologyapi = [
            ];
            taskschd = [
            ];
            textstor = [
            ];
            threadpoolapiset = [
            ];
            threadpoollegacyapiset = [
            ];
            timeapi = [
            ];
            timezoneapi = [
            ];
            tlhelp32 = [
            ];
            transportsettingcommon = [
            ];
            tvout = [
            ];
            unknwnbase = [
            ];
            urlhist = [
            ];
            urlmon = [
            ];
            usb = [
            ];
            usbiodef = [
            ];
            usbspec = [
            ];
            userenv = [
            ];
            usp10 = [
            ];
            utilapiset = [
            ];
            uxtheme = [
            ];
            vadefs = [
            ];
            vcruntime = [
            ];
            vsbackup = [
            ];
            vss = [
            ];
            vsserror = [
            ];
            vswriter = [
            ];
            wbemads = [
            ];
            wbemcli = [
            ];
            wbemdisp = [
            ];
            wbemprov = [
            ];
            wbemtran = [
            ];
            wct = [
            ];
            werapi = [
            ];
            winbase = [
            ];
            wincodec = [
            ];
            wincodecsdk = [
            ];
            wincon = [
            ];
            wincontypes = [
            ];
            wincred = [
            ];
            wincrypt = [
            ];
            windef = [
            ];
            windowsceip = [
            ];
            windowsx = [
            ];
            winefs = [
            ];
            winerror = [
            ];
            winevt = [
            ];
            wingdi = [
            ];
            winhttp = [
            ];
            wininet = [
            ];
            winineti = [
            ];
            winioctl = [
            ];
            winnetwk = [
            ];
            winnls = [
            ];
            winnt = [
            ];
            winreg = [
            ];
            winsafer = [
            ];
            winscard = [
            ];
            winsmcrd = [
            ];
            winsock2 = [
            ];
            winspool = [
            ];
            winstring = [
            ];
            winsvc = [
            ];
            winusb = [
            ];
            winusbio = [
            ];
            winuser = [
            ];
            winver = [
            ];
            wmistr = [
            ];
            wnnc = [
            ];
            wow64apiset = [
            ];
            wpdmtpextensions = [
            ];
            ws2def = [
            ];
            ws2ipdef = [
            ];
            ws2spi = [
            ];
            ws2tcpip = [
            ];
            wtypes = [
            ];
            wtypesbase = [
            ];
            xinput = [
            ];
          };
          target = {
            i686-pc-windows-gnu = {
              dependencies = {
                winapi-i686-pc-windows-gnu = {
                  version = "0.4";
                };
              };
            };
            x86_64-pc-windows-gnu = {
              dependencies = {
                winapi-x86_64-pc-windows-gnu = {
                  version = "0.4";
                };
              };
            };
          };
          badges = {
            appveyor = {
              branch = "0.3";
              repository = "retep998/winapi-rs";
              service = "github";
            };
            travis-ci = {
              branch = "0.3";
              repository = "retep998/winapi-rs";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".core-foundation-sys."0.6.2" = mkRustCrate {
        package-id = "core-foundation-sys 0.6.2 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "core-foundation-sys";
          version = "0.6.2";
          sha256 = "e7ca8a5221364ef15ce201e8ed2f609fc312682a8f4e0e3d4aa5879764e0fa3b";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "core-foundation-sys";
            version = "0.6.2";
            authors = [
              "The Servo Project Developers"
            ];
            build = "build.rs";
            description = "Bindings to Core Foundation for OS X";
            homepage = "https://github.com/servo/core-foundation-rs";
            license = "MIT / Apache-2.0";
            repository = "https://github.com/servo/core-foundation-rs";
          };
          dependencies = {
          };
          features = {
            mac_os_10_7_support = [
            ];
            mac_os_10_8_features = [
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".tokio-tcp."0.1.3" = mkRustCrate {
        package-id = "tokio-tcp 0.1.3 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "tokio-tcp";
          version = "0.1.3";
          sha256 = "1d14b10654be682ac43efee27401d792507e30fd8d26389e1da3b185de2e4119";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "bytes"
            ];
            extern-name = "bytes";
            package-id = "bytes 0.4.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "futures"
            ];
            extern-name = "futures";
            package-id = "futures 0.1.27 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "iovec"
            ];
            extern-name = "iovec";
            package-id = "iovec 0.1.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "mio"
            ];
            extern-name = "mio";
            package-id = "mio 0.6.19 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-io"
            ];
            extern-name = "tokio_io";
            package-id = "tokio-io 0.1.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-reactor"
            ];
            extern-name = "tokio_reactor";
            package-id = "tokio-reactor 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "tokio-tcp";
            version = "0.1.3";
            authors = [
              "Carl Lerche <me@carllerche.com>"
            ];
            description = "TCP bindings for tokio.\n";
            homepage = "https://tokio.rs";
            documentation = "https://docs.rs/tokio-tcp/0.1.3/tokio_tcp";
            categories = [
              "asynchronous"
            ];
            license = "MIT";
            repository = "https://github.com/tokio-rs/tokio";
          };
          dependencies = {
            bytes = {
              version = "0.4";
            };
            futures = {
              version = "0.1.19";
            };
            iovec = {
              version = "0.1";
            };
            mio = {
              version = "0.6.14";
            };
            tokio-io = {
              version = "0.1.6";
            };
            tokio-reactor = {
              version = "0.1.1";
            };
          };
          dev-dependencies = {
            env_logger = {
              version = "0.5";
              default-features = false;
            };
            tokio = {
              version = "0.1.13";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".numtoa."0.1.0" = mkRustCrate {
        package-id = "numtoa 0.1.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "numtoa";
          version = "0.1.0";
          sha256 = "b8f8bdf33df195859076e54ab11ee78a1b208382d3a26ec40d142ffc1ecc49ef";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "numtoa";
            version = "0.1.0";
            authors = [
              "Michael Aaron Murphy <mmstickman@gmail.com>"
            ];
            description = "Convert numbers into stack-allocated byte arrays";
            documentation = "https://docs.rs/numtoa";
            readme = "README.md";
            keywords = [
              "numbers"
              "convert"
              "numtoa"
              "itoa"
              "no_std"
            ];
            categories = [
              "value-formatting"
            ];
            license = "MIT OR Apache-2.0";
            repository = "https://gitlab.com/mmstick/numtoa";
          };
          features = {
            std = [
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".git2."0.8.0" = mkRustCrate {
        package-id = "git2 0.8.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "git2";
          version = "0.8.0";
          sha256 = "c7339329bfa14a00223244311560d11f8f489b453fb90092af97f267a6090ab0";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "bitflags"
            ];
            extern-name = "bitflags";
            package-id = "bitflags 1.1.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libgit2-sys"
            ];
            extern-name = "libgit2_sys";
            package-id = "libgit2-sys 0.7.11 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "log"
            ];
            extern-name = "log";
            package-id = "log 0.4.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "openssl-probe"
            ];
            extern-name = "openssl_probe";
            package-id = "openssl-probe 0.1.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "openssl-sys"
            ];
            extern-name = "openssl_sys";
            package-id = "openssl-sys 0.9.47 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "url"
            ];
            extern-name = "url";
            package-id = "url 1.7.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "git2";
            version = "0.8.0";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "Bindings to libgit2 for interoperating with git repositories. This library is\nboth threadsafe and memory safe and allows both reading and writing git\nrepositories.\n";
            homepage = "https://github.com/alexcrichton/git2-rs";
            documentation = "https://docs.rs/git2";
            readme = "README.md";
            keywords = [
              "git"
            ];
            categories = [
              "api-bindings"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/git2-rs";
          };
          dependencies = {
            bitflags = {
              version = "1.0";
            };
            libc = {
              version = "0.2";
            };
            libgit2-sys = {
              version = "0.7.11";
            };
            log = {
              version = "0.4";
            };
            url = {
              version = "1.0";
            };
          };
          dev-dependencies = {
            docopt = {
              version = "1.0";
            };
            serde = {
              version = "1.0";
            };
            serde_derive = {
              version = "1.0";
            };
            tempdir = {
              version = "0.3.7";
            };
            thread-id = {
              version = "3.3.0";
            };
            time = {
              version = "0.1.39";
            };
          };
          features = {
            curl = [
              "libgit2-sys/curl"
            ];
            default = [
              "ssh"
              "https"
              "curl"
              "ssh_key_from_memory"
            ];
            https = [
              "libgit2-sys/https"
              "openssl-sys"
              "openssl-probe"
            ];
            ssh = [
              "libgit2-sys/ssh"
            ];
            ssh_key_from_memory = [
              "libgit2-sys/ssh_key_from_memory"
            ];
            unstable = [
            ];
            vendored-openssl = [
              "openssl-sys/vendored"
            ];
          };
          target = {
            "cfg(all(unix, not(target_os = \"macos\")))" = {
              dependencies = {
                openssl-probe = {
                  version = "0.1";
                  optional = true;
                };
                openssl-sys = {
                  version = "0.9.0";
                  optional = true;
                };
              };
            };
          };
          badges = {
            appveyor = {
              repository = "alexcrichton/git2-rs";
            };
            travis-ci = {
              repository = "alexcrichton/git2-rs";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".utf8-ranges."1.0.3" = mkRustCrate {
        package-id = "utf8-ranges 1.0.3 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "utf8-ranges";
          version = "1.0.3";
          sha256 = "9d50aa7650df78abf942826607c62468ce18d9019673d4a2ebe1865dbb96ffde";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "utf8-ranges";
            version = "1.0.3";
            authors = [
              "Andrew Gallant <jamslam@gmail.com>"
            ];
            exclude = [
              "/ci/*"
              "/.travis.yml"
              "/Makefile"
              "/ctags.rust"
              "/session.vim"
            ];
            description = "Convert ranges of Unicode codepoints to UTF-8 byte ranges.";
            homepage = "https://github.com/BurntSushi/utf8-ranges";
            documentation = "https://docs.rs/utf8-ranges";
            readme = "README.md";
            keywords = [
              "codepoint"
              "utf8"
              "automaton"
              "range"
            ];
            license = "Unlicense/MIT";
            repository = "https://github.com/BurntSushi/utf8-ranges";
          };
          dev-dependencies = {
            doc-comment = {
              version = "0.3";
            };
            quickcheck = {
              version = "0.8";
              default-features = false;
            };
          };
          badges = {
            travis-ci = {
              repository = "BurntSushi/utf8-ranges";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".rand_isaac."0.1.1" = mkRustCrate {
        package-id = "rand_isaac 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "rand_isaac";
          version = "0.1.1";
          sha256 = "ded997c9d5f13925be2a6fd7e66bf1872597f759fd9dd93513dd7e92e5a5ee08";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "rand_core"
            ];
            extern-name = "rand_core";
            package-id = "rand_core 0.3.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "rand_isaac";
            version = "0.1.1";
            authors = [
              "The Rand Project Developers"
              "The Rust Project Developers"
            ];
            description = "ISAAC random number generator\n";
            homepage = "https://crates.io/crates/rand_isaac";
            documentation = "https://rust-random.github.io/rand/rand_isaac";
            readme = "README.md";
            keywords = [
              "random"
              "rng"
              "isaac"
            ];
            categories = [
              "algorithms"
              "no-std"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/rust-random/rand";
          };
          dependencies = {
            rand_core = {
              version = "0.3";
              default-features = false;
            };
            serde = {
              version = "1";
              optional = true;
            };
            serde_derive = {
              version = "^1.0.38";
              optional = true;
            };
          };
          dev-dependencies = {
            bincode = {
              version = "1";
            };
          };
          features = {
            serde1 = [
              "serde"
              "serde_derive"
              "rand_core/serde1"
            ];
          };
          badges = {
            appveyor = {
              repository = "rust-random/rand";
            };
            travis-ci = {
              repository = "rust-random/rand";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".unicode-bidi."0.3.4" = mkRustCrate {
        package-id = "unicode-bidi 0.3.4 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "unicode-bidi";
          version = "0.3.4";
          sha256 = "49f2bd0c6468a8230e1db229cff8029217cf623c767ea5d60bfbd42729ea54d5";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "matches"
            ];
            extern-name = "matches";
            package-id = "matches 0.1.8 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "unicode-bidi";
            version = "0.3.4";
            authors = [
              "The Servo Project Developers"
            ];
            exclude = [
              "benches/**"
              "data/**"
              "examples/**"
              "tests/**"
              "tools/**"
            ];
            description = "Implementation of the Unicode Bidirectional Algorithm";
            documentation = "http://doc.servo.org/unicode_bidi/";
            keywords = [
              "rtl"
              "unicode"
              "text"
              "layout"
              "bidi"
            ];
            license = "MIT / Apache-2.0";
            repository = "https://github.com/servo/unicode-bidi";
          };
          lib = {
            name = "unicode_bidi";
          };
          dependencies = {
            flame = {
              version = "0.1";
              optional = true;
            };
            flamer = {
              version = "0.1";
              optional = true;
            };
            matches = {
              version = "0.1";
            };
            serde = {
              version = ">=0.8, <2.0";
              features = [
                "derive"
              ];
              optional = true;
            };
          };
          dev-dependencies = {
            serde_test = {
              version = ">=0.8, <2.0";
            };
          };
          features = {
            bench_it = [
            ];
            default = [
            ];
            flame_it = [
              "flame"
              "flamer"
            ];
            unstable = [
            ];
            with_serde = [
              "serde"
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".byteorder."1.3.2" = mkRustCrate {
        package-id = "byteorder 1.3.2 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "byteorder";
          version = "1.3.2";
          sha256 = "a7c3dd8985a7111efc5c80b44e23ecdd8c007de8ade3b96595387e812b957cf5";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "byteorder";
            version = "1.3.2";
            authors = [
              "Andrew Gallant <jamslam@gmail.com>"
            ];
            build = "build.rs";
            exclude = [
              "/ci/*"
            ];
            description = "Library for reading/writing numbers in big-endian and little-endian.";
            homepage = "https://github.com/BurntSushi/byteorder";
            documentation = "https://docs.rs/byteorder";
            readme = "README.md";
            keywords = [
              "byte"
              "endian"
              "big-endian"
              "little-endian"
              "binary"
            ];
            categories = [
              "encoding"
              "parsing"
            ];
            license = "Unlicense OR MIT";
            repository = "https://github.com/BurntSushi/byteorder";
          };
          profile = {
            bench = {
              opt-level = 3;
            };
          };
          lib = {
            name = "byteorder";
            bench = false;
          };
          dev-dependencies = {
            doc-comment = {
              version = "0.3";
            };
            quickcheck = {
              version = "0.8";
              default-features = false;
            };
            rand = {
              version = "0.6";
            };
          };
          features = {
            default = [
              "std"
            ];
            i128 = [
            ];
            std = [
            ];
          };
          badges = {
            travis-ci = {
              repository = "BurntSushi/byteorder";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".iovec."0.1.2" = mkRustCrate {
        package-id = "iovec 0.1.2 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "iovec";
          version = "0.1.2";
          sha256 = "dbe6e417e7d0975db6512b90796e8ce223145ac4e33c377e4a42882a0e88bb08";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.2.8 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "iovec";
            version = "0.1.2";
            authors = [
              "Carl Lerche <me@carllerche.com>"
            ];
            description = "Portable buffer type for scatter/gather I/O operations\n";
            homepage = "https://github.com/carllerche/iovec";
            documentation = "https://docs.rs/iovec";
            readme = "README.md";
            keywords = [
              "scatter"
              "gather"
              "vectored"
              "io"
              "networking"
            ];
            categories = [
              "network-programming"
              "api-bindings"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/carllerche/iovec";
          };
          target = {
            "cfg(unix)" = {
              dependencies = {
                libc = {
                  version = "0.2";
                };
              };
            };
            "cfg(windows)" = {
              dependencies = {
                winapi = {
                  version = "0.2";
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".quick-error."1.2.2" = mkRustCrate {
        package-id = "quick-error 1.2.2 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "quick-error";
          version = "1.2.2";
          sha256 = "9274b940887ce9addde99c4eee6b5c44cc494b182b97e73dc8ffdcb3397fd3f0";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "quick-error";
            version = "1.2.2";
            authors = [
              "Paul Colomiets <paul@colomiets.name>"
              "Colin Kiegel <kiegel@gmx.de>"
            ];
            description = "    A macro which makes error types pleasant to write.\n";
            homepage = "http://github.com/tailhook/quick-error";
            documentation = "http://docs.rs/quick-error";
            keywords = [
              "macro"
              "error"
              "type"
              "enum"
            ];
            categories = [
              "rust-patterns"
            ];
            license = "MIT/Apache-2.0";
            repository = "http://github.com/tailhook/quick-error";
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".tokio-process."0.2.3" = mkRustCrate {
        package-id = "tokio-process 0.2.3 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "tokio-process";
          version = "0.2.3";
          sha256 = "88e1281e412013f1ff5787def044a9577a0bed059f451e835f1643201f8b777d";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "futures"
            ];
            extern-name = "futures";
            package-id = "futures 0.1.27 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "mio"
            ];
            extern-name = "mio";
            package-id = "mio 0.6.19 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "mio-named-pipes"
            ];
            extern-name = "mio_named_pipes";
            package-id = "mio-named-pipes 0.1.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-io"
            ];
            extern-name = "tokio_io";
            package-id = "tokio-io 0.1.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-reactor"
            ];
            extern-name = "tokio_reactor";
            package-id = "tokio-reactor 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-signal"
            ];
            extern-name = "tokio_signal";
            package-id = "tokio-signal 0.2.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "tokio-process";
            version = "0.2.3";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "An implementation of an asynchronous process management backed futures.\n";
            homepage = "https://github.com/alexcrichton/tokio-process";
            documentation = "https://docs.rs/tokio-process";
            categories = [
              "asynchronous"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/tokio-process";
          };
          dependencies = {
            futures = {
              version = "0.1.11";
            };
            mio = {
              version = "0.6.5";
            };
            tokio-io = {
              version = "0.1";
            };
            tokio-reactor = {
              version = "0.1";
            };
          };
          dev-dependencies = {
            env_logger = {
              version = "0.4";
              default-features = false;
            };
            log = {
              version = "0.4";
            };
            tokio = {
              version = "0.1";
            };
            tokio-current-thread = {
              version = "0.1";
            };
          };
          target = {
            "cfg(unix)" = {
              dependencies = {
                libc = {
                  version = "0.2";
                };
                tokio-signal = {
                  version = "0.2.5";
                };
              };
            };
            "cfg(windows)" = {
              dependencies = {
                mio-named-pipes = {
                  version = "0.1";
                };
                winapi = {
                  version = "0.3";
                  features = [
                    "handleapi"
                    "winerror"
                    "minwindef"
                    "processthreadsapi"
                    "synchapi"
                    "threadpoollegacyapiset"
                    "winbase"
                    "winnt"
                  ];
                };
              };
            };
          };
          badges = {
            appveyor = {
              repository = "alexcrichton/tokio-process";
            };
            travis-ci = {
              repository = "alexcrichton/tokio-process";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".libc."0.2.58" = mkRustCrate {
        package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "libc";
          version = "0.2.58";
          sha256 = "6281b86796ba5e4366000be6e9e18bf35580adf9e63fbe2294aadb587613a319";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "libc";
            version = "0.2.58";
            authors = [
              "The Rust Project Developers"
            ];
            build = "build.rs";
            exclude = [
              "/ci/*"
              "/.travis.yml"
              "/appveyor.yml"
            ];
            description = "Raw FFI bindings to platform libraries like libc.\n";
            homepage = "https://github.com/rust-lang/libc";
            documentation = "http://doc.rust-lang.org/libc";
            readme = "README.md";
            keywords = [
              "libc"
              "ffi"
              "bindings"
              "operating"
              "system"
            ];
            categories = [
              "external-ffi-bindings"
              "no-std"
              "os"
            ];
            license = "MIT OR Apache-2.0";
            repository = "https://github.com/rust-lang/libc";
          };
          dependencies = {
            rustc-std-workspace-core = {
              version = "1.0.0";
              optional = true;
            };
          };
          features = {
            align = [
            ];
            default = [
              "std"
            ];
            extra_traits = [
            ];
            rustc-dep-of-std = [
              "align"
              "rustc-std-workspace-core"
            ];
            std = [
            ];
            use_std = [
              "std"
            ];
          };
          badges = {
            appveyor = {
              project_name = "rust-lang-libs/libc";
              repository = "rust-lang/libc";
            };
            travis-ci = {
              repository = "rust-lang/libc";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".winapi-build."0.1.1" = mkRustCrate {
        package-id = "winapi-build 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "winapi-build";
          version = "0.1.1";
          sha256 = "2d315eee3b34aca4797b2da6b13ed88266e6d612562a0c46390af8299fc699bc";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "winapi-build";
            version = "0.1.1";
            authors = [
              "Peter Atashian <retep998@gmail.com>"
            ];
            description = "Common code for build.rs in WinAPI -sys crates.";
            keywords = [
              "Windows"
              "FFI"
              "WinSDK"
            ];
            license = "MIT";
            repository = "https://github.com/retep998/winapi-rs";
          };
          lib = {
            name = "build";
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".hex."0.3.2" = mkRustCrate {
        package-id = "hex 0.3.2 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "hex";
          version = "0.3.2";
          sha256 = "805026a5d0141ffc30abb3be3173848ad46a1b1664fe632428479619a3644d77";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "hex";
            version = "0.3.2";
            authors = [
              "KokaKiwi <kokakiwi@kokakiwi.net>"
            ];
            description = "Encoding and decoding data into/from hexadecimal representation.";
            documentation = "https://docs.rs/hex/";
            license = "MIT OR Apache-2.0";
            repository = "https://github.com/KokaKiwi/rust-hex";
          };
          features = {
            benchmarks = [
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".thread_local."0.3.6" = mkRustCrate {
        package-id = "thread_local 0.3.6 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "thread_local";
          version = "0.3.6";
          sha256 = "c6b53e329000edc2b34dbe8545fd20e55a333362d0a321909685a19bd28c3f1b";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "lazy_static"
            ];
            extern-name = "lazy_static";
            package-id = "lazy_static 1.3.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "thread_local";
            version = "0.3.6";
            authors = [
              "Amanieu d'Antras <amanieu@gmail.com>"
            ];
            description = "Per-object thread-local storage";
            documentation = "https://amanieu.github.io/thread_local-rs/thread_local/index.html";
            readme = "README.md";
            keywords = [
              "thread_local"
              "concurrent"
              "thread"
            ];
            license = "Apache-2.0/MIT";
            repository = "https://github.com/Amanieu/thread_local-rs";
          };
          dependencies = {
            lazy_static = {
              version = "1.0";
            };
          };
          badges = {
            travis-ci = {
              repository = "Amanieu/thread_local-rs";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".vec_map."0.8.1" = mkRustCrate {
        package-id = "vec_map 0.8.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "vec_map";
          version = "0.8.1";
          sha256 = "05c78687fb1a80548ae3250346c3db86a80a7cdd77bda190189f2d0a0987c81a";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "vec_map";
            version = "0.8.1";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
              "Jorge Aparicio <japaricious@gmail.com>"
              "Alexis Beingessner <a.beingessner@gmail.com>"
              "Brian Anderson <>"
              "tbu- <>"
              "Manish Goregaokar <>"
              "Aaron Turon <aturon@mozilla.com>"
              "Adolfo Ochagavía <>"
              "Niko Matsakis <>"
              "Steven Fackler <>"
              "Chase Southwood <csouth3@illinois.edu>"
              "Eduard Burtescu <>"
              "Florian Wilkens <>"
              "Félix Raimundo <>"
              "Tibor Benke <>"
              "Markus Siemens <markus@m-siemens.de>"
              "Josh Branchaud <jbranchaud@gmail.com>"
              "Huon Wilson <dbau.pp@gmail.com>"
              "Corey Farwell <coref@rwell.org>"
              "Aaron Liblong <>"
              "Nick Cameron <nrc@ncameron.org>"
              "Patrick Walton <pcwalton@mimiga.net>"
              "Felix S Klock II <>"
              "Andrew Paseltiner <apaseltiner@gmail.com>"
              "Sean McArthur <sean.monstar@gmail.com>"
              "Vadim Petrochenkov <>"
            ];
            description = "A simple map based on a vector for small integer keys";
            homepage = "https://github.com/contain-rs/vec-map";
            documentation = "https://contain-rs.github.io/vec-map/vec_map";
            readme = "README.md";
            keywords = [
              "data-structures"
              "collections"
              "vecmap"
              "vec_map"
              "contain-rs"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/contain-rs/vec-map";
          };
          dependencies = {
            serde = {
              version = "1.0";
              features = [
                "derive"
              ];
              optional = true;
            };
          };
          features = {
            eders = [
              "serde"
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".tokio-timer."0.2.11" = mkRustCrate {
        package-id = "tokio-timer 0.2.11 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "tokio-timer";
          version = "0.2.11";
          sha256 = "f2106812d500ed25a4f38235b9cae8f78a09edf43203e16e59c3b769a342a60e";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "crossbeam-utils"
            ];
            extern-name = "crossbeam_utils";
            package-id = "crossbeam-utils 0.6.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "futures"
            ];
            extern-name = "futures";
            package-id = "futures 0.1.27 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "slab"
            ];
            extern-name = "slab";
            package-id = "slab 0.4.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-executor"
            ];
            extern-name = "tokio_executor";
            package-id = "tokio-executor 0.1.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "tokio-timer";
            version = "0.2.11";
            authors = [
              "Carl Lerche <me@carllerche.com>"
            ];
            description = "Timer facilities for Tokio\n";
            homepage = "https://github.com/tokio-rs/tokio";
            documentation = "https://docs.rs/tokio-timer/0.2.11/tokio_timer";
            readme = "README.md";
            license = "MIT";
            repository = "https://github.com/tokio-rs/tokio";
          };
          dependencies = {
            crossbeam-utils = {
              version = "0.6.0";
            };
            futures = {
              version = "0.1.19";
            };
            slab = {
              version = "0.4.1";
            };
            tokio-executor = {
              version = "0.1.1";
            };
          };
          dev-dependencies = {
            rand = {
              version = "0.6";
            };
            tokio = {
              version = "0.1.7";
            };
            tokio-mock-task = {
              version = "0.1.0";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".strsim."0.8.0" = mkRustCrate {
        package-id = "strsim 0.8.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "strsim";
          version = "0.8.0";
          sha256 = "8ea5119cdb4c55b55d432abb513a0429384878c15dde60cc77b1c99de1a95a6a";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "strsim";
            version = "0.8.0";
            authors = [
              "Danny Guo <dannyguo91@gmail.com>"
            ];
            description = "Implementations of string similarity metrics.\nIncludes Hamming, Levenshtein, OSA, Damerau-Levenshtein, Jaro, and Jaro-Winkler.\n";
            homepage = "https://github.com/dguo/strsim-rs";
            documentation = "https://docs.rs/strsim/";
            readme = "README.md";
            keywords = [
              "string"
              "similarity"
              "Hamming"
              "Levenshtein"
              "Jaro"
            ];
            license = "MIT";
            repository = "https://github.com/dguo/strsim-rs";
          };
          badges = {
            appveyor = {
              repository = "dguo/strsim-rs";
            };
            travis-ci = {
              repository = "dguo/strsim-rs";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".ryu."0.2.8" = mkRustCrate {
        package-id = "ryu 0.2.8 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "ryu";
          version = "0.2.8";
          sha256 = "b96a9549dc8d48f2c283938303c4b5a77aa29bfbc5b54b084fb1630408899a8f";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "ryu";
            version = "0.2.8";
            authors = [
              "David Tolnay <dtolnay@gmail.com>"
            ];
            build = "build.rs";
            description = "Fast floating point to string conversion";
            documentation = "https://docs.rs/ryu";
            readme = "README.md";
            license = "Apache-2.0 OR BSL-1.0";
            repository = "https://github.com/dtolnay/ryu";
          };
          dependencies = {
            no-panic = {
              version = "0.1";
              optional = true;
            };
          };
          dev-dependencies = {
            num_cpus = {
              version = "1.8";
            };
            rand = {
              version = "0.5";
            };
          };
          features = {
            small = [
            ];
          };
          badges = {
            travis-ci = {
              repository = "dtolnay/ryu";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".rand_os."0.1.3" = mkRustCrate {
        package-id = "rand_os 0.1.3 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "rand_os";
          version = "0.1.3";
          sha256 = "7b75f676a1e053fc562eafbb47838d67c84801e38fc1ba459e8f180deabd5071";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "cloudabi"
            ];
            extern-name = "cloudabi";
            package-id = "cloudabi 0.0.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "fuchsia-cprng"
            ];
            extern-name = "fuchsia_cprng";
            package-id = "fuchsia-cprng 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rand_core"
            ];
            extern-name = "rand_core";
            package-id = "rand_core 0.4.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rdrand"
            ];
            extern-name = "rdrand";
            package-id = "rdrand 0.4.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "rand_os";
            version = "0.1.3";
            authors = [
              "The Rand Project Developers"
            ];
            description = "OS backed Random Number Generator";
            homepage = "https://crates.io/crates/rand_os";
            documentation = "https://docs.rs/rand_os";
            readme = "README.md";
            keywords = [
              "random"
              "rng"
              "os"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/rust-random/rand";
          };
          dependencies = {
            log = {
              version = "0.4";
              optional = true;
            };
            rand_core = {
              version = "0.4";
              features = [
                "std"
              ];
            };
          };
          target = {
            "cfg(target_env = \"sgx\")" = {
              dependencies = {
                rdrand = {
                  version = "0.4.0";
                };
              };
            };
            "cfg(target_os = \"cloudabi\")" = {
              dependencies = {
                cloudabi = {
                  version = "0.0.3";
                };
              };
            };
            "cfg(target_os = \"fuchsia\")" = {
              dependencies = {
                fuchsia-cprng = {
                  version = "0.1.0";
                };
              };
            };
            "cfg(unix)" = {
              dependencies = {
                libc = {
                  version = "0.2";
                };
              };
            };
            "cfg(windows)" = {
              dependencies = {
                winapi = {
                  version = "0.3";
                  features = [
                    "minwindef"
                    "ntsecapi"
                    "winnt"
                  ];
                };
              };
            };
            wasm32-unknown-unknown = {
              dependencies = {
                stdweb = {
                  version = "0.4";
                  optional = true;
                };
                wasm-bindgen = {
                  version = "0.2.12";
                  optional = true;
                };
              };
            };
          };
          badges = {
            appveyor = {
              repository = "rust-random/rand";
            };
            travis-ci = {
              repository = "rust-random/rand";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".signal-hook-registry."1.0.1" = mkRustCrate {
        package-id = "signal-hook-registry 1.0.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "signal-hook-registry";
          version = "1.0.1";
          sha256 = "cded4ffa32146722ec54ab1f16320568465aa922aa9ab4708129599740da85d7";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "arc-swap"
            ];
            extern-name = "arc_swap";
            package-id = "arc-swap 0.3.11 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "signal-hook-registry";
            version = "1.0.1";
            authors = [
              "Michal 'vorner' Vaner <vorner@vorner.cz>"
            ];
            description = "Backend crate for signal-hook";
            documentation = "https://docs.rs/signal-hook-registry";
            readme = "README.md";
            keywords = [
              "signal"
              "unix"
              "daemon"
            ];
            license = "Apache-2.0/MIT";
            repository = "https://github.com/vorner/signal-hook";
          };
          dependencies = {
            arc-swap = {
              version = "~0.3.5";
            };
            libc = {
              version = "~0.2";
            };
          };
          dev-dependencies = {
            signal-hook = {
              version = "~0.1";
            };
            version-sync = {
              version = "~0.8";
            };
          };
          badges = {
            maintenance = {
              status = "actively-developed";
            };
            travis-ci = {
              repository = "vorner/signal-hook";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".rand_core."0.3.1" = mkRustCrate {
        package-id = "rand_core 0.3.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "rand_core";
          version = "0.3.1";
          sha256 = "7a6fdeb83b075e8266dcc8762c22776f6877a63111121f5f8c7411e5be7eed4b";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "rand_core"
            ];
            extern-name = "rand_core";
            package-id = "rand_core 0.4.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "rand_core";
            version = "0.3.1";
            authors = [
              "The Rand Project Developers"
              "The Rust Project Developers"
            ];
            description = "Core random number generator traits and tools for implementation.\n";
            homepage = "https://crates.io/crates/rand_core";
            documentation = "https://rust-random.github.io/rand/rand_core";
            readme = "README.md";
            keywords = [
              "random"
              "rng"
            ];
            categories = [
              "algorithms"
              "no-std"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/rust-random/rand";
          };
          dependencies = {
            rand_core = {
              version = "0.4";
            };
          };
          features = {
            alloc = [
              "rand_core/alloc"
            ];
            default = [
              "std"
            ];
            serde1 = [
              "rand_core/serde1"
            ];
            std = [
              "rand_core/std"
            ];
          };
          badges = {
            appveyor = {
              repository = "rust-random/rand";
            };
            travis-ci = {
              repository = "rust-random/rand";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".winapi-util."0.1.2" = mkRustCrate {
        package-id = "winapi-util 0.1.2 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "winapi-util";
          version = "0.1.2";
          sha256 = "7168bab6e1daee33b4557efd0e95d5ca70a03706d39fa5f3fe7a236f584b03c9";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "winapi-util";
            version = "0.1.2";
            authors = [
              "Andrew Gallant <jamslam@gmail.com>"
            ];
            description = "A dumping ground for high level safe wrappers over winapi.";
            homepage = "https://github.com/BurntSushi/winapi-util";
            documentation = "https://docs.rs/winapi-util";
            readme = "README.md";
            keywords = [
              "windows"
              "winapi"
              "util"
              "win"
            ];
            categories = [
              "os::windows-apis"
              "external-ffi-bindings"
            ];
            license = "Unlicense/MIT";
            repository = "https://github.com/BurntSushi/winapi-util";
          };
          target = {
            "cfg(windows)" = {
              dependencies = {
                winapi = {
                  version = "0.3";
                  features = [
                    "std"
                    "consoleapi"
                    "errhandlingapi"
                    "fileapi"
                    "minwindef"
                    "processenv"
                    "winbase"
                    "wincon"
                    "winerror"
                    "winnt"
                  ];
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".crc32fast."1.2.0" = mkRustCrate {
        package-id = "crc32fast 1.2.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "crc32fast";
          version = "1.2.0";
          sha256 = "ba125de2af0df55319f41944744ad91c71113bf74a4646efff39afe1f6842db1";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "cfg-if"
            ];
            extern-name = "cfg_if";
            package-id = "cfg-if 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "crc32fast";
            version = "1.2.0";
            authors = [
              "Sam Rijs <srijs@airpost.net>"
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "Fast, SIMD-accelerated CRC32 (IEEE) checksum computation";
            readme = "README.md";
            keywords = [
              "checksum"
              "crc"
              "crc32"
              "simd"
              "fast"
            ];
            license = "MIT OR Apache-2.0";
            repository = "https://github.com/srijs/rust-crc32fast";
          };
          bench = [
            {
              name = "bench";
              harness = false;
            }
          ];
          dependencies = {
            cfg-if = {
              version = "0.1";
            };
          };
          dev-dependencies = {
            bencher = {
              version = "0.1";
            };
            quickcheck = {
              version = "0.6";
              default-features = false;
            };
            rand = {
              version = "0.4";
            };
          };
          features = {
            default = [
              "std"
            ];
            nightly = [
            ];
            std = [
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".ws2_32-sys."0.2.1" = mkRustCrate {
        package-id = "ws2_32-sys 0.2.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "ws2_32-sys";
          version = "0.2.1";
          sha256 = "d59cefebd0c892fa2dd6de581e937301d8552cb44489cdff035c6187cb63fa5e";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.2.8 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi-build"
            ];
            extern-name = "build";
            package-id = "winapi-build 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "ws2_32-sys";
            version = "0.2.1";
            authors = [
              "Peter Atashian <retep998@gmail.com>"
            ];
            build = "build.rs";
            description = "Contains function definitions for the Windows API library ws2_32. See winapi for types and constants.";
            documentation = "https://retep998.github.io/doc/ws2_32/";
            readme = "README.md";
            keywords = [
              "windows"
              "ffi"
              "win32"
            ];
            license = "MIT";
            repository = "https://github.com/retep998/winapi-rs";
          };
          lib = {
            name = "ws2_32";
          };
          dependencies = {
            winapi = {
              version = "0.2.5";
              path = "../..";
            };
          };
          build-dependencies = {
            winapi-build = {
              version = "0.1.1";
              path = "../../build";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".regex."1.1.7" = mkRustCrate {
        package-id = "regex 1.1.7 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "regex";
          version = "1.1.7";
          sha256 = "0b2f0808e7d7e4fb1cb07feb6ff2f4bc827938f24f8c2e6a3beb7370af544bdd";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "aho-corasick"
            ];
            extern-name = "aho_corasick";
            package-id = "aho-corasick 0.7.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "memchr"
            ];
            extern-name = "memchr";
            package-id = "memchr 2.2.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "regex-syntax"
            ];
            extern-name = "regex_syntax";
            package-id = "regex-syntax 0.6.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "thread_local"
            ];
            extern-name = "thread_local";
            package-id = "thread_local 0.3.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "utf8-ranges"
            ];
            extern-name = "utf8_ranges";
            package-id = "utf8-ranges 1.0.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "regex";
            version = "1.1.7";
            authors = [
              "The Rust Project Developers"
            ];
            exclude = [
              "/.travis.yml"
              "/appveyor.yml"
              "/ci/*"
              "/scripts/*"
            ];
            autotests = false;
            description = "An implementation of regular expressions for Rust. This implementation uses\nfinite automata and guarantees linear time matching on all inputs.\n";
            homepage = "https://github.com/rust-lang/regex";
            documentation = "https://docs.rs/regex";
            readme = "README.md";
            categories = [
              "text-processing"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/rust-lang/regex";
          };
          profile = {
            test = {
              debug = true;
            };
            bench = {
              debug = true;
            };
            release = {
              debug = true;
            };
          };
          lib = {
            bench = false;
          };
          test = [
            {
              name = "default";
              path = "tests/test_default.rs";
            }
            {
              name = "default-bytes";
              path = "tests/test_default_bytes.rs";
            }
            {
              name = "nfa";
              path = "tests/test_nfa.rs";
            }
            {
              name = "nfa-utf8bytes";
              path = "tests/test_nfa_utf8bytes.rs";
            }
            {
              name = "nfa-bytes";
              path = "tests/test_nfa_bytes.rs";
            }
            {
              name = "backtrack";
              path = "tests/test_backtrack.rs";
            }
            {
              name = "backtrack-utf8bytes";
              path = "tests/test_backtrack_utf8bytes.rs";
            }
            {
              name = "backtrack-bytes";
              path = "tests/test_backtrack_bytes.rs";
            }
            {
              name = "crates-regex";
              path = "tests/test_crates_regex.rs";
            }
          ];
          dependencies = {
            aho-corasick = {
              version = "0.7.3";
            };
            memchr = {
              version = "2.0.2";
            };
            regex-syntax = {
              version = "0.6.6";
            };
            thread_local = {
              version = "0.3.6";
            };
            utf8-ranges = {
              version = "1.0.1";
            };
          };
          dev-dependencies = {
            doc-comment = {
              version = "0.3";
            };
            lazy_static = {
              version = "1";
            };
            quickcheck = {
              version = "0.8";
              default-features = false;
            };
            rand = {
              version = "0.6.5";
            };
          };
          features = {
            default = [
              "use_std"
            ];
            pattern = [
            ];
            unstable = [
              "pattern"
            ];
            use_std = [
            ];
          };
          badges = {
            appveyor = {
              repository = "rust-lang-libs/regex";
            };
            travis-ci = {
              repository = "rust-lang/regex";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".cfg-if."0.1.9" = mkRustCrate {
        package-id = "cfg-if 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "cfg-if";
          version = "0.1.9";
          sha256 = "b486ce3ccf7ffd79fdeb678eac06a9e6c09fc88d33836340becb8fffe87c5e33";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "cfg-if";
            version = "0.1.9";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "A macro to ergonomically define an item depending on a large number of #[cfg]\nparameters. Structured like an if-else chain, the first matching branch is the\nitem that gets emitted.\n";
            homepage = "https://github.com/alexcrichton/cfg-if";
            documentation = "https://docs.rs/cfg-if";
            readme = "README.md";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/cfg-if";
          };
          badges = {
            travis-ci = {
              repository = "alexcrichton/cfg-if";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".crates-io."0.24.0" = mkRustCrate {
        package-id = "crates-io 0.24.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "crates-io";
          version = "0.24.0";
          sha256 = "49095fe6e157645809a05d3d4171b9c439bcc2b8aa0bf4322d15d35e05fd26fe";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "curl"
            ];
            extern-name = "curl";
            package-id = "curl 0.4.22 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "failure"
            ];
            extern-name = "failure";
            package-id = "failure 0.1.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "http"
            ];
            extern-name = "http";
            package-id = "http 0.1.17 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "serde"
            ];
            extern-name = "serde";
            package-id = "serde 1.0.92 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "serde_derive"
            ];
            extern-name = "serde_derive";
            package-id = "serde_derive 1.0.92 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "serde_json"
            ];
            extern-name = "serde_json";
            package-id = "serde_json 1.0.39 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "url"
            ];
            extern-name = "url";
            package-id = "url 1.7.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            edition = "2018";
            name = "crates-io";
            version = "0.24.0";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "Helpers for interacting with crates.io\n";
            license = "MIT OR Apache-2.0";
            repository = "https://github.com/rust-lang/cargo";
          };
          lib = {
            name = "crates_io";
            path = "lib.rs";
          };
          dependencies = {
            curl = {
              version = "0.4";
            };
            failure = {
              version = "0.1.1";
            };
            http = {
              version = "0.1";
            };
            serde = {
              version = "1.0";
              features = [
                "derive"
              ];
            };
            serde_derive = {
              version = "1.0";
            };
            serde_json = {
              version = "1.0";
            };
            url = {
              version = "1.0";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".home."0.3.4" = mkRustCrate {
        package-id = "home 0.3.4 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "home";
          version = "0.3.4";
          sha256 = "29302b90cfa76231a757a887d1e3153331a63c7f80b6c75f86366334cbe70708";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "scopeguard"
            ];
            extern-name = "scopeguard";
            package-id = "scopeguard 0.3.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "home";
            version = "0.3.4";
            authors = [
              "Brian Anderson <andersrb@gmail.com>"
            ];
            description = "Shared definitions of home directories";
            documentation = "https://docs.rs/home";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/brson/home";
          };
          target = {
            "cfg(windows)" = {
              dependencies = {
                scopeguard = {
                  version = "0.3";
                };
                winapi = {
                  version = "0.3";
                  features = [
                    "errhandlingapi"
                    "handleapi"
                    "processthreadsapi"
                    "std"
                    "winerror"
                    "winnt"
                    "userenv"
                  ];
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".opener."0.3.2" = mkRustCrate {
        package-id = "opener 0.3.2 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "opener";
          version = "0.3.2";
          sha256 = "04b1d6b086d9b3009550f9b6f81b10ad9428cf14f404b8e1a3a06f6f012c8ec9";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "failure"
            ];
            extern-name = "failure";
            package-id = "failure 0.1.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "failure_derive"
            ];
            extern-name = "failure_derive";
            package-id = "failure_derive 0.1.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "opener";
            version = "0.3.2";
            authors = [
              "Brian Bowman <seeker14491@gmail.com>"
            ];
            description = "Open a file or link using the system default program.";
            readme = "../README.md";
            keywords = [
              "open"
              "default"
              "launcher"
              "browser"
            ];
            license = "MIT OR Apache-2.0";
            repository = "https://github.com/Seeker14491/opener";
          };
          dependencies = {
            failure = {
              version = "0.1.2";
            };
            failure_derive = {
              version = "0.1.2";
            };
          };
          target = {
            "cfg(windows)" = {
              dependencies = {
                winapi = {
                  version = "0.3";
                  features = [
                    "shellapi"
                  ];
                };
              };
            };
          };
          badges = {
            appveyor = {
              branch = "master";
              repository = "Seeker14491/opener";
              service = "github";
            };
            travis-ci = {
              branch = "master";
              repository = "Seeker14491/opener";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".signal-hook."0.1.9" = mkRustCrate {
        package-id = "signal-hook 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "signal-hook";
          version = "0.1.9";
          sha256 = "72ab58f1fda436857e6337dcb6a5aaa34f16c5ddc87b3a8b6ef7a212f90b9c5a";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "signal-hook-registry"
            ];
            extern-name = "signal_hook_registry";
            package-id = "signal-hook-registry 1.0.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "signal-hook";
            version = "0.1.9";
            authors = [
              "Michal 'vorner' Vaner <vorner@vorner.cz>"
            ];
            description = "Unix signal handling";
            documentation = "https://docs.rs/signal-hook";
            readme = "README.md";
            keywords = [
              "signal"
              "unix"
              "daemon"
            ];
            license = "Apache-2.0/MIT";
            repository = "https://github.com/vorner/signal-hook";
            metadata = {
              docs = {
                rs = {
                  features = [
                    "mio-support"
                    "tokio-support"
                  ];
                };
              };
            };
          };
          dependencies = {
            futures = {
              version = "~0.1";
              optional = true;
            };
            libc = {
              version = "~0.2";
            };
            mio = {
              version = "~0.6";
              optional = true;
            };
            mio-uds = {
              version = "~0.6";
              optional = true;
            };
            signal-hook-registry = {
              version = "~1";
            };
            tokio-reactor = {
              version = "~0.1";
              optional = true;
            };
          };
          dev-dependencies = {
            tokio = {
              version = "~0.1";
            };
            version-sync = {
              version = "~0.8";
            };
          };
          features = {
            mio-support = [
              "mio"
              "mio-uds"
            ];
            tokio-support = [
              "futures"
              "mio-support"
              "tokio-reactor"
            ];
          };
          badges = {
            maintenance = {
              status = "actively-developed";
            };
            travis-ci = {
              repository = "vorner/signal-hook";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".remove_dir_all."0.5.2" = mkRustCrate {
        package-id = "remove_dir_all 0.5.2 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "remove_dir_all";
          version = "0.5.2";
          sha256 = "4a83fa3702a688b9359eccba92d153ac33fd2e8462f9e0e3fdf155239ea7792e";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "remove_dir_all";
            version = "0.5.2";
            authors = [
              "Aaronepower <theaaronepower@gmail.com>"
            ];
            include = [
              "Cargo.toml"
              "LICENCE-APACHE"
              "LICENCE-MIT"
              "src/**/*"
            ];
            description = "A safe, reliable implementation of remove_dir_all for Windows";
            readme = "README.md";
            keywords = [
              "utility"
              "filesystem"
              "remove_dir"
              "windows"
            ];
            categories = [
              "filesystem"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/XAMPPRocky/remove_dir_all.git";
          };
          dev-dependencies = {
            doc-comment = {
              version = "0.3";
            };
          };
          target = {
            "cfg(windows)" = {
              dependencies = {
                winapi = {
                  version = "0.3";
                  features = [
                    "std"
                    "errhandlingapi"
                    "winerror"
                    "fileapi"
                    "winbase"
                  ];
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".syn."0.15.36" = mkRustCrate {
        package-id = "syn 0.15.36 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "syn";
          version = "0.15.36";
          sha256 = "8b4f551a91e2e3848aeef8751d0d4eec9489b6474c720fd4c55958d8d31a430c";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "proc-macro2"
              "proc-macro2"
              "proc-macro2"
            ];
            extern-name = "proc_macro2";
            package-id = "proc-macro2 0.4.30 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "quote"
              "quote"
              "quote"
            ];
            extern-name = "quote";
            package-id = "quote 0.6.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "unicode-xid"
              "unicode-xid"
              "unicode-xid"
            ];
            extern-name = "unicode_xid";
            package-id = "unicode-xid 0.1.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "syn";
            version = "0.15.36";
            authors = [
              "David Tolnay <dtolnay@gmail.com>"
            ];
            include = [
              "/build.rs"
              "/Cargo.toml"
              "/LICENSE-APACHE"
              "/LICENSE-MIT"
              "/README.md"
              "/src/**/*.rs"
            ];
            description = "Parser for Rust source code";
            documentation = "https://docs.rs/syn";
            readme = "README.md";
            categories = [
              "development-tools::procedural-macro-helpers"
            ];
            license = "MIT OR Apache-2.0";
            repository = "https://github.com/dtolnay/syn";
            metadata = {
              docs = {
                rs = {
                  all-features = true;
                };
              };
              playground = {
                all-features = true;
              };
            };
          };
          dependencies = {
            proc-macro2 = {
              version = "0.4.4";
              default-features = false;
            };
            quote = {
              version = "0.6";
              optional = true;
              default-features = false;
            };
            unicode-xid = {
              version = "0.1";
            };
          };
          dev-dependencies = {
            insta = {
              version = "0.8";
            };
            rayon = {
              version = "1.0";
            };
            ref-cast = {
              version = "0.2";
            };
            regex = {
              version = "1.0";
            };
            termcolor = {
              version = "1.0";
            };
            walkdir = {
              version = "2.1";
            };
          };
          features = {
            clone-impls = [
            ];
            default = [
              "derive"
              "parsing"
              "printing"
              "clone-impls"
              "proc-macro"
            ];
            derive = [
            ];
            extra-traits = [
            ];
            fold = [
            ];
            full = [
            ];
            parsing = [
            ];
            printing = [
              "quote"
            ];
            proc-macro = [
              "proc-macro2/proc-macro"
              "quote/proc-macro"
            ];
            visit = [
            ];
            visit-mut = [
            ];
          };
          badges = {
            travis-ci = {
              repository = "dtolnay/syn";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".num_cpus."1.10.1" = mkRustCrate {
        package-id = "num_cpus 1.10.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "num_cpus";
          version = "1.10.1";
          sha256 = "bcef43580c035376c0705c42792c294b66974abbfd2789b511784023f71f3273";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "num_cpus";
            version = "1.10.1";
            authors = [
              "Sean McArthur <sean@seanmonstar.com>"
            ];
            description = "Get the number of CPUs on a machine.";
            documentation = "https://docs.rs/num_cpus";
            readme = "README.md";
            keywords = [
              "cpu"
              "cpus"
              "cores"
            ];
            categories = [
              "hardware-support"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/seanmonstar/num_cpus";
          };
          dependencies = {
            libc = {
              version = "0.2.26";
            };
          };
          dev-dependencies = {
            doc-comment = {
              version = "0.3";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".fwdansi."1.0.1" = mkRustCrate {
        package-id = "fwdansi 1.0.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "fwdansi";
          version = "1.0.1";
          sha256 = "34dd4c507af68d37ffef962063dfa1944ce0dd4d5b82043dbab1dabe088610c3";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "memchr"
            ];
            extern-name = "memchr";
            package-id = "memchr 2.2.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "termcolor"
            ];
            extern-name = "termcolor";
            package-id = "termcolor 1.0.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "fwdansi";
            version = "1.0.1";
            authors = [
              "kennytm <kennytm@gmail.com>"
            ];
            description = "Forwards a byte string with ANSI escape code to a termcolor terminal";
            keywords = [
              "ansi"
              "windows"
              "console"
              "terminal"
              "color"
            ];
            categories = [
              "command-line-interface"
            ];
            license = "MIT";
            repository = "https://github.com/kennytm/fwdansi";
          };
          dependencies = {
            memchr = {
              version = "2";
            };
            termcolor = {
              version = "1";
            };
          };
          dev-dependencies = {
            proptest = {
              version = "0.8";
            };
          };
          badges = {
            appveyor = {
              repository = "kennytm/fwdansi";
            };
            maintenance = {
              status = "passively-maintained";
            };
            travis-ci = {
              repository = "kennytm/fwdansi";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".socket2."0.3.9" = mkRustCrate {
        package-id = "socket2 0.3.9 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "socket2";
          version = "0.3.9";
          sha256 = "4e626972d3593207547f14bf5fc9efa4d0e7283deb73fef1dff313dae9ab8878";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "cfg-if"
            ];
            extern-name = "cfg_if";
            package-id = "cfg-if 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "redox_syscall"
            ];
            extern-name = "syscall";
            package-id = "redox_syscall 0.1.54 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "socket2";
            version = "0.3.9";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "Utilities for handling networking sockets with a maximal amount of configuration\npossible intended.\n";
            homepage = "https://github.com/alexcrichton/socket2-rs";
            readme = "README.md";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/socket2-rs";
            metadata = {
              docs = {
                rs = {
                  all-features = true;
                };
              };
            };
          };
          dev-dependencies = {
            tempdir = {
              version = "0.3";
            };
          };
          features = {
            pair = [
            ];
            reuseport = [
            ];
            unix = [
            ];
          };
          target = {
            "cfg(any(unix, target_os = \"redox\"))" = {
              dependencies = {
                cfg-if = {
                  version = "0.1";
                };
                libc = {
                  version = "0.2.42";
                };
              };
            };
            "cfg(target_os = \"redox\")" = {
              dependencies = {
                redox_syscall = {
                  version = "0.1.38";
                };
              };
            };
            "cfg(windows)" = {
              dependencies = {
                winapi = {
                  version = "0.3.3";
                  features = [
                    "handleapi"
                    "ws2def"
                    "ws2ipdef"
                    "ws2tcpip"
                    "minwindef"
                  ];
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".aho-corasick."0.7.3" = mkRustCrate {
        package-id = "aho-corasick 0.7.3 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "aho-corasick";
          version = "0.7.3";
          sha256 = "e6f484ae0c99fec2e858eb6134949117399f222608d84cadb3f58c1f97c2364c";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "memchr"
            ];
            extern-name = "memchr";
            package-id = "memchr 2.2.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "aho-corasick";
            version = "0.7.3";
            authors = [
              "Andrew Gallant <jamslam@gmail.com>"
            ];
            exclude = [
              "/aho-corasick-debug"
              "/bench"
              "/ci/*"
              "/.travis.yml"
            ];
            autotests = false;
            description = "Fast multiple substring searching.";
            homepage = "https://github.com/BurntSushi/aho-corasick";
            readme = "README.md";
            keywords = [
              "string"
              "search"
              "text"
              "aho"
              "multi"
            ];
            categories = [
              "text-processing"
            ];
            license = "Unlicense/MIT";
            repository = "https://github.com/BurntSushi/aho-corasick";
          };
          profile = {
            bench = {
              debug = true;
            };
            release = {
              debug = true;
            };
          };
          lib = {
            name = "aho_corasick";
          };
          dependencies = {
            memchr = {
              version = "2.2.0";
              default-features = false;
            };
          };
          features = {
            default = [
              "std"
            ];
            std = [
              "memchr/use_std"
            ];
          };
          badges = {
            appveyor = {
              repository = "BurntSushi/regex-automata";
            };
            travis-ci = {
              repository = "BurntSushi/aho-corasick";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".miniz-sys."0.1.12" = mkRustCrate {
        package-id = "miniz-sys 0.1.12 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "miniz-sys";
          version = "0.1.12";
          sha256 = "1e9e3ae51cea1576ceba0dde3d484d30e6e5b86dee0b2d412fe3a16a15c98202";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "cc"
            ];
            extern-name = "cc";
            package-id = "cc 1.0.37 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "miniz-sys";
            version = "0.1.12";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            build = "build.rs";
            links = "miniz";
            description = "Bindings to the miniz.c library.\n";
            documentation = "https://docs.rs/miniz-sys";
            categories = [
              "external-ffi-bindings"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/flate2-rs";
          };
          lib = {
            name = "miniz_sys";
            path = "lib.rs";
          };
          dependencies = {
            libc = {
              version = "0.2";
            };
          };
          build-dependencies = {
            cc = {
              version = "1.0";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".regex-syntax."0.6.7" = mkRustCrate {
        package-id = "regex-syntax 0.6.7 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "regex-syntax";
          version = "0.6.7";
          sha256 = "9d76410686f9e3a17f06128962e0ecc5755870bb890c34820c7af7f1db2e1d48";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "ucd-util"
            ];
            extern-name = "ucd_util";
            package-id = "ucd-util 0.1.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "regex-syntax";
            version = "0.6.7";
            authors = [
              "The Rust Project Developers"
            ];
            description = "A regular expression parser.";
            homepage = "https://github.com/rust-lang/regex";
            documentation = "https://docs.rs/regex-syntax";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/rust-lang/regex";
          };
          dependencies = {
            ucd-util = {
              version = "0.1.0";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".serde."1.0.92" = mkRustCrate {
        package-id = "serde 1.0.92 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "serde";
          version = "1.0.92";
          sha256 = "32746bf0f26eab52f06af0d0aa1984f641341d06d8d673c693871da2d188c9be";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "serde_derive"
            ];
            extern-name = "serde_derive";
            package-id = "serde_derive 1.0.92 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "serde";
            version = "1.0.92";
            authors = [
              "Erick Tryzelaar <erick.tryzelaar@gmail.com>"
              "David Tolnay <dtolnay@gmail.com>"
            ];
            build = "build.rs";
            include = [
              "Cargo.toml"
              "build.rs"
              "src/**/*.rs"
              "crates-io.md"
              "README.md"
              "LICENSE-APACHE"
              "LICENSE-MIT"
            ];
            description = "A generic serialization/deserialization framework";
            homepage = "https://serde.rs";
            documentation = "https://docs.serde.rs/serde/";
            readme = "crates-io.md";
            keywords = [
              "serde"
              "serialization"
              "no_std"
            ];
            categories = [
              "encoding"
            ];
            license = "MIT OR Apache-2.0";
            repository = "https://github.com/serde-rs/serde";
            metadata = {
              playground = {
                features = [
                  "derive"
                  "rc"
                ];
              };
            };
          };
          dependencies = {
            serde_derive = {
              version = "1.0";
              optional = true;
            };
          };
          dev-dependencies = {
            serde_derive = {
              version = "1.0";
            };
          };
          features = {
            alloc = [
              "unstable"
            ];
            default = [
              "std"
            ];
            derive = [
              "serde_derive"
            ];
            rc = [
            ];
            std = [
            ];
            unstable = [
            ];
          };
          badges = {
            appveyor = {
              repository = "serde-rs/serde";
            };
            travis-ci = {
              repository = "serde-rs/serde";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".crossbeam-epoch."0.7.1" = mkRustCrate {
        package-id = "crossbeam-epoch 0.7.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "crossbeam-epoch";
          version = "0.7.1";
          sha256 = "04c9e3102cc2d69cd681412141b390abd55a362afc1540965dad0ad4d34280b4";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "arrayvec"
            ];
            extern-name = "arrayvec";
            package-id = "arrayvec 0.4.10 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "cfg-if"
            ];
            extern-name = "cfg_if";
            package-id = "cfg-if 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "crossbeam-utils"
            ];
            extern-name = "crossbeam_utils";
            package-id = "crossbeam-utils 0.6.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "lazy_static"
            ];
            extern-name = "lazy_static";
            package-id = "lazy_static 1.3.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "memoffset"
            ];
            extern-name = "memoffset";
            package-id = "memoffset 0.2.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "scopeguard"
            ];
            extern-name = "scopeguard";
            package-id = "scopeguard 0.3.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "crossbeam-epoch";
            version = "0.7.1";
            authors = [
              "The Crossbeam Project Developers"
            ];
            description = "Epoch-based garbage collection";
            homepage = "https://github.com/crossbeam-rs/crossbeam/tree/master/crossbeam-epoch";
            documentation = "https://docs.rs/crossbeam-epoch";
            readme = "README.md";
            keywords = [
              "lock-free"
              "rcu"
              "atomic"
              "garbage"
            ];
            categories = [
              "concurrency"
              "memory-management"
              "no-std"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/crossbeam-rs/crossbeam";
          };
          dependencies = {
            arrayvec = {
              version = "0.4";
              default-features = false;
            };
            cfg-if = {
              version = "0.1";
            };
            crossbeam-utils = {
              version = "0.6";
              default-features = false;
            };
            lazy_static = {
              version = "1";
              optional = true;
            };
            memoffset = {
              version = "0.2";
            };
            scopeguard = {
              version = "0.3";
              default-features = false;
            };
          };
          dev-dependencies = {
            rand = {
              version = "0.6";
            };
          };
          features = {
            default = [
              "std"
            ];
            nightly = [
              "crossbeam-utils/nightly"
              "arrayvec/use_union"
            ];
            sanitize = [
            ];
            std = [
              "crossbeam-utils/std"
              "lazy_static"
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".failure_derive."0.1.5" = mkRustCrate {
        package-id = "failure_derive 0.1.5 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "failure_derive";
          version = "0.1.5";
          sha256 = "ea1063915fd7ef4309e222a5a07cf9c319fb9c7836b1f89b85458672dbb127e1";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "proc-macro2"
            ];
            extern-name = "proc_macro2";
            package-id = "proc-macro2 0.4.30 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "quote"
            ];
            extern-name = "quote";
            package-id = "quote 0.6.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "syn"
            ];
            extern-name = "syn";
            package-id = "syn 0.15.36 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "synstructure"
            ];
            extern-name = "synstructure";
            package-id = "synstructure 0.10.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "failure_derive";
            version = "0.1.5";
            authors = [
              "Without Boats <woboats@gmail.com>"
            ];
            build = "build.rs";
            description = "derives for the failure crate";
            homepage = "https://rust-lang-nursery.github.io/failure/";
            documentation = "https://docs.rs/failure";
            license = "MIT OR Apache-2.0";
            repository = "https://github.com/withoutboats/failure_derive";
          };
          lib = {
            proc-macro = true;
          };
          dependencies = {
            proc-macro2 = {
              version = "0.4.8";
            };
            quote = {
              version = "0.6.3";
            };
            syn = {
              version = "0.15.0";
            };
            synstructure = {
              version = "0.10.0";
            };
          };
          dev-dependencies = {
            failure = {
              version = "0.1.0";
            };
          };
          features = {
            std = [
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".tokio-sync."0.1.6" = mkRustCrate {
        package-id = "tokio-sync 0.1.6 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "tokio-sync";
          version = "0.1.6";
          sha256 = "2162248ff317e2bc713b261f242b69dbb838b85248ed20bb21df56d60ea4cae7";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "fnv"
            ];
            extern-name = "fnv";
            package-id = "fnv 1.0.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "futures"
            ];
            extern-name = "futures";
            package-id = "futures 0.1.27 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "tokio-sync";
            version = "0.1.6";
            authors = [
              "Carl Lerche <me@carllerche.com>"
            ];
            description = "Synchronization utilities.\n";
            homepage = "https://tokio.rs";
            documentation = "https://docs.rs/tokio-sync/0.1.6/tokio_sync";
            categories = [
              "asynchronous"
            ];
            license = "MIT";
            repository = "https://github.com/tokio-rs/tokio";
          };
          dependencies = {
            fnv = {
              version = "1.0.6";
            };
            futures = {
              version = "0.1.19";
            };
          };
          dev-dependencies = {
            env_logger = {
              version = "0.5";
              default-features = false;
            };
            loom = {
              version = "0.1.1";
              features = [
                "futures"
              ];
            };
            tokio = {
              version = "0.1.15";
            };
            tokio-mock-task = {
              version = "0.1.1";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".rand_core."0.4.0" = mkRustCrate {
        package-id = "rand_core 0.4.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "rand_core";
          version = "0.4.0";
          sha256 = "d0e7a549d590831370895ab7ba4ea0c1b6b011d106b5ff2da6eee112615e6dc0";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "rand_core";
            version = "0.4.0";
            authors = [
              "The Rand Project Developers"
              "The Rust Project Developers"
            ];
            description = "Core random number generator traits and tools for implementation.\n";
            homepage = "https://crates.io/crates/rand_core";
            documentation = "https://rust-random.github.io/rand/rand_core";
            readme = "README.md";
            keywords = [
              "random"
              "rng"
            ];
            categories = [
              "algorithms"
              "no-std"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/rust-random/rand";
          };
          dependencies = {
            serde = {
              version = "1";
              optional = true;
            };
            serde_derive = {
              version = "^1.0.38";
              optional = true;
            };
          };
          features = {
            alloc = [
            ];
            serde1 = [
              "serde"
              "serde_derive"
            ];
            std = [
              "alloc"
            ];
          };
          badges = {
            appveyor = {
              repository = "rust-random/rand";
            };
            travis-ci = {
              repository = "rust-random/rand";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".schannel."0.1.15" = mkRustCrate {
        package-id = "schannel 0.1.15 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "schannel";
          version = "0.1.15";
          sha256 = "f2f6abf258d99c3c1c5c2131d99d064e94b7b3dd5f416483057f308fea253339";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "lazy_static"
            ];
            extern-name = "lazy_static";
            package-id = "lazy_static 1.3.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "schannel";
            version = "0.1.15";
            authors = [
              "Steven Fackler <sfackler@gmail.com>"
              "Steffen Butzer <steffen.butzer@outlook.com>"
            ];
            description = "Schannel bindings for rust, allowing SSL/TLS (e.g. https) without openssl";
            documentation = "https://docs.rs/schannel/0/x86_64-pc-windows-gnu/schannel/";
            readme = "README.md";
            keywords = [
              "windows"
              "schannel"
              "tls"
              "ssl"
              "https"
            ];
            license = "MIT";
            repository = "https://github.com/steffengy/schannel-rs";
          };
          dependencies = {
            lazy_static = {
              version = "1.0";
            };
            winapi = {
              version = "0.3";
              features = [
                "lmcons"
                "minschannel"
                "securitybaseapi"
                "schannel"
                "sspi"
                "sysinfoapi"
                "timezoneapi"
                "winbase"
                "wincrypt"
                "winerror"
              ];
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".curl-sys."0.4.19" = mkRustCrate {
        package-id = "curl-sys 0.4.19 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "curl-sys";
          version = "0.4.19";
          sha256 = "d2427916f870661c5473e41bb7a5ac08d1a01ae1a4db495f724e7b7212e40a73";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "cc"
              "cc"
            ];
            extern-name = "cc";
            package-id = "cc 1.0.37 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libnghttp2-sys"
            ];
            extern-name = "libnghttp2_sys";
            package-id = "libnghttp2-sys 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libz-sys"
              "libz-sys"
            ];
            extern-name = "libz_sys";
            package-id = "libz-sys 1.0.25 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "openssl-sys"
              "openssl-sys"
            ];
            extern-name = "openssl_sys";
            package-id = "openssl-sys 0.9.47 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "pkg-config"
              "pkg-config"
            ];
            extern-name = "pkg_config";
            package-id = "pkg-config 0.3.14 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "vcpkg"
              "vcpkg"
            ];
            extern-name = "vcpkg";
            package-id = "vcpkg 0.2.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "curl-sys";
            version = "0.4.19";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            build = "build.rs";
            links = "curl";
            description = "Native bindings to the libcurl library";
            documentation = "https://docs.rs/curl-sys";
            categories = [
              "external-ffi-bindings"
            ];
            license = "MIT";
            repository = "https://github.com/alexcrichton/curl-rust";
          };
          lib = {
            name = "curl_sys";
            path = "lib.rs";
          };
          dependencies = {
            libc = {
              version = "0.2.2";
            };
            libnghttp2-sys = {
              version = "0.1";
              optional = true;
            };
            libz-sys = {
              version = "1.0.18";
            };
          };
          build-dependencies = {
            cc = {
              version = "1.0";
            };
            pkg-config = {
              version = "0.3.3";
            };
          };
          features = {
            default = [
              "ssl"
            ];
            force-system-lib-on-osx = [
            ];
            http2 = [
              "libnghttp2-sys"
            ];
            spnego = [
            ];
            ssl = [
              "openssl-sys"
            ];
            static-curl = [
            ];
            static-ssl = [
              "openssl-sys/vendored"
            ];
          };
          target = {
            "cfg(all(unix, not(target_os = \"macos\")))" = {
              dependencies = {
                openssl-sys = {
                  version = "0.9";
                  optional = true;
                };
              };
            };
            "cfg(target_env = \"msvc\")" = {
              build-dependencies = {
                vcpkg = {
                  version = "0.2";
                };
              };
            };
            "cfg(windows)" = {
              dependencies = {
                winapi = {
                  version = "0.3";
                  features = [
                    "winsock2"
                    "ws2def"
                  ];
                };
              };
            };
          };
          badges = {
            appveyor = {
              repository = "alexcrichton/curl-rust";
            };
            travis-ci = {
              repository = "alexcrichton/curl-rust";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".ucd-util."0.1.3" = mkRustCrate {
        package-id = "ucd-util 0.1.3 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "ucd-util";
          version = "0.1.3";
          sha256 = "535c204ee4d8434478593480b8f86ab45ec9aae0e83c568ca81abf0fd0e88f86";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "ucd-util";
            version = "0.1.3";
            authors = [
              "Andrew Gallant <jamslam@gmail.com>"
            ];
            description = "A small utility library for working with the Unicode character database.\n";
            homepage = "https://github.com/BurntSushi/ucd-generate";
            documentation = "https://docs.rs/ucd-util";
            readme = "README.md";
            keywords = [
              "unicode"
              "database"
              "character"
              "property"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/BurntSushi/ucd-generate";
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".libz-sys."1.0.25" = mkRustCrate {
        package-id = "libz-sys 1.0.25 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "libz-sys";
          version = "1.0.25";
          sha256 = "2eb5e43362e38e2bca2fd5f5134c4d4564a23a5c28e9b95411652021a8675ebe";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "cc"
            ];
            extern-name = "cc";
            package-id = "cc 1.0.37 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "pkg-config"
            ];
            extern-name = "pkg_config";
            package-id = "pkg-config 0.3.14 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "vcpkg"
            ];
            extern-name = "vcpkg";
            package-id = "vcpkg 0.2.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "libz-sys";
            version = "1.0.25";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            build = "build.rs";
            links = "z";
            description = "Bindings to the system libz library (also known as zlib).\n";
            documentation = "https://docs.rs/libz-sys";
            categories = [
              "external-ffi-bindings"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/libz-sys";
          };
          dependencies = {
            libc = {
              version = "0.2.43";
            };
          };
          build-dependencies = {
            cc = {
              version = "1.0.18";
            };
            pkg-config = {
              version = "0.3.9";
            };
          };
          features = {
            asm = [
            ];
            static = [
            ];
          };
          target = {
            "cfg(target_env = \"msvc\")" = {
              build-dependencies = {
                vcpkg = {
                  version = "0.2";
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".toml."0.5.1" = mkRustCrate {
        package-id = "toml 0.5.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "toml";
          version = "0.5.1";
          sha256 = "b8c96d7873fa7ef8bdeb3a9cda3ac48389b4154f32b9803b4bc26220b677b039";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "serde"
            ];
            extern-name = "serde";
            package-id = "serde 1.0.92 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            edition = "2018";
            name = "toml";
            version = "0.5.1";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "A native Rust encoder and decoder of TOML-formatted files and streams. Provides\nimplementations of the standard Serialize/Deserialize traits for TOML data to\nfacilitate deserializing and serializing Rust structures.\n";
            homepage = "https://github.com/alexcrichton/toml-rs";
            documentation = "https://docs.rs/toml";
            readme = "README.md";
            keywords = [
              "encoding"
            ];
            categories = [
              "config"
              "encoding"
              "parser-implementations"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/toml-rs";
          };
          dependencies = {
            linked-hash-map = {
              version = "0.5";
              optional = true;
            };
            serde = {
              version = "1.0";
            };
          };
          dev-dependencies = {
            serde_derive = {
              version = "1.0";
            };
            serde_json = {
              version = "1.0";
            };
          };
          features = {
            default = [
            ];
            preserve_order = [
              "linked-hash-map"
            ];
          };
          badges = {
            travis-ci = {
              repository = "alexcrichton/toml-rs";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".owning_ref."0.4.0" = mkRustCrate {
        package-id = "owning_ref 0.4.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "owning_ref";
          version = "0.4.0";
          sha256 = "49a4b8ea2179e6a2e27411d3bca09ca6dd630821cf6894c6c7c8467a8ee7ef13";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "stable_deref_trait"
            ];
            extern-name = "stable_deref_trait";
            package-id = "stable_deref_trait 1.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "owning_ref";
            version = "0.4.0";
            authors = [
              "Marvin Löbel <loebel.marvin@gmail.com>"
            ];
            description = "A library for creating references that carry their owner with them.";
            documentation = "http://kimundi.github.io/owning-ref-rs/owning_ref/index.html";
            readme = "README.md";
            keywords = [
              "reference"
              "sibling"
              "field"
              "owning"
            ];
            license = "MIT";
            repository = "https://github.com/Kimundi/owning-ref-rs";
          };
          dependencies = {
            stable_deref_trait = {
              version = "1.0.0";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".miow."0.3.3" = mkRustCrate {
        package-id = "miow 0.3.3 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "miow";
          version = "0.3.3";
          sha256 = "396aa0f2003d7df8395cb93e09871561ccc3e785f0acb369170e8cc74ddf9226";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "socket2"
            ];
            extern-name = "socket2";
            package-id = "socket2 0.3.9 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "miow";
            version = "0.3.3";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "A zero overhead I/O library for Windows, focusing on IOCP and Async I/O\nabstractions.\n";
            homepage = "https://github.com/alexcrichton/miow";
            documentation = "https://docs.rs/miow/0.3/x86_64-pc-windows-msvc/miow/";
            readme = "README.md";
            keywords = [
              "iocp"
              "windows"
              "io"
              "overlapped"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/miow";
          };
          dependencies = {
            socket2 = {
              version = "0.3";
            };
            winapi = {
              version = "0.3.3";
              features = [
                "std"
                "fileapi"
                "handleapi"
                "ioapiset"
                "minwindef"
                "namedpipeapi"
                "ntdef"
                "synchapi"
                "winerror"
                "winsock2"
                "ws2def"
                "ws2ipdef"
              ];
            };
          };
          dev-dependencies = {
            rand = {
              version = "0.4";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".memchr."2.2.0" = mkRustCrate {
        package-id = "memchr 2.2.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "memchr";
          version = "2.2.0";
          sha256 = "2efc7bc57c883d4a4d6e3246905283d8dae951bb3bd32f49d6ef297f546e1c39";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "memchr";
            version = "2.2.0";
            authors = [
              "Andrew Gallant <jamslam@gmail.com>"
              "bluss"
            ];
            exclude = [
              "/ci/*"
              "/.travis.yml"
              "/Makefile"
              "/appveyor.yml"
            ];
            description = "Safe interface to memchr.";
            homepage = "https://github.com/BurntSushi/rust-memchr";
            documentation = "https://docs.rs/memchr/";
            readme = "README.md";
            keywords = [
              "memchr"
              "char"
              "scan"
              "strchr"
              "string"
            ];
            license = "Unlicense/MIT";
            repository = "https://github.com/BurntSushi/rust-memchr";
          };
          profile = {
            test = {
              opt-level = 3;
            };
          };
          lib = {
            name = "memchr";
            bench = false;
          };
          dependencies = {
            libc = {
              version = "0.2.18";
              optional = true;
              default-features = false;
            };
          };
          dev-dependencies = {
            quickcheck = {
              version = "0.8";
              default-features = false;
            };
          };
          features = {
            default = [
              "use_std"
            ];
            use_std = [
            ];
          };
          badges = {
            appveyor = {
              repository = "BurntSushi/rust-memchr";
            };
            travis-ci = {
              repository = "BurntSushi/rust-memchr";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".im-rc."12.3.4" = mkRustCrate {
        package-id = "im-rc 12.3.4 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "im-rc";
          version = "12.3.4";
          sha256 = "e882e6e7cd335baacae574b56aa3ce74844ec82fc6777def7c0ac368837dc3d5";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "rustc_version"
            ];
            extern-name = "rustc_version";
            package-id = "rustc_version 0.2.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "sized-chunks"
            ];
            extern-name = "sized_chunks";
            package-id = "sized-chunks 0.1.3 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "typenum"
            ];
            extern-name = "typenum";
            package-id = "typenum 1.10.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            edition = "2018";
            name = "im-rc";
            version = "12.3.4";
            authors = [
              "Bodil Stokke <bodil@bodil.org>"
            ];
            build = "./build.rs";
            description = "Immutable collection datatypes (the fast but not thread safe version)";
            homepage = "http://immutable.rs/";
            documentation = "http://immutable.rs/";
            readme = "../../README.md";
            keywords = [
              "immutable"
              "persistent"
              "hamt"
              "b-tree"
              "rrb-tree"
            ];
            categories = [
              "data-structures"
            ];
            license = "MPL-2.0+";
            repository = "https://github.com/bodil/im-rs";
          };
          lib = {
            path = "./src/lib.rs";
          };
          dependencies = {
            proptest = {
              version = "0.9";
              optional = true;
            };
            quickcheck = {
              version = "0.8";
              optional = true;
            };
            rayon = {
              version = "1.0";
              optional = true;
            };
            serde = {
              version = "1.0";
              optional = true;
            };
            sized-chunks = {
              version = "0.1.2";
            };
            typenum = {
              version = "1.10";
            };
          };
          dev-dependencies = {
            metrohash = {
              version = "1.0.6";
            };
            pretty_assertions = {
              version = "0.6";
            };
            proptest = {
              version = "0.9";
            };
            proptest-derive = {
              version = "0.1.0";
            };
            rand = {
              version = "0.6";
            };
            rayon = {
              version = "1.0";
            };
            serde = {
              version = "1.0";
            };
            serde_json = {
              version = "1.0";
            };
            syntect = {
              version = "3.1.0";
            };
          };
          build-dependencies = {
            rustc_version = {
              version = "0.2";
            };
          };
          badges = {
            travis-ci = {
              repository = "bodil/im-rs";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".lazy_static."1.3.0" = mkRustCrate {
        package-id = "lazy_static 1.3.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "lazy_static";
          version = "1.3.0";
          sha256 = "bc5729f27f159ddd61f4df6228e827e86643d4d3e7c32183cb30a1c08f604a14";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "lazy_static";
            version = "1.3.0";
            authors = [
              "Marvin Löbel <loebel.marvin@gmail.com>"
            ];
            exclude = [
              "/.travis.yml"
              "/appveyor.yml"
            ];
            description = "A macro for declaring lazily evaluated statics in Rust.";
            documentation = "https://docs.rs/lazy_static";
            readme = "README.md";
            keywords = [
              "macro"
              "lazy"
              "static"
            ];
            categories = [
              "no-std"
              "rust-patterns"
              "memory-management"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/rust-lang-nursery/lazy-static.rs";
          };
          dependencies = {
            spin = {
              version = "0.5.0";
              optional = true;
            };
          };
          features = {
            spin_no_std = [
              "spin"
            ];
          };
          badges = {
            appveyor = {
              repository = "rust-lang-nursery/lazy-static.rs";
            };
            is-it-maintained-issue-resolution = {
              repository = "rust-lang-nursery/lazy-static.rs";
            };
            is-it-maintained-open-issues = {
              repository = "rust-lang-nursery/lazy-static.rs";
            };
            maintenance = {
              status = "passively-maintained";
            };
            travis-ci = {
              repository = "rust-lang-nursery/lazy-static.rs";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".miow."0.2.1" = mkRustCrate {
        package-id = "miow 0.2.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "miow";
          version = "0.2.1";
          sha256 = "8c1f2f3b1cf331de6896aabf6e9d55dca90356cc9960cca7eaaf408a355ae919";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "kernel32-sys"
            ];
            extern-name = "kernel32";
            package-id = "kernel32-sys 0.2.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "net2"
            ];
            extern-name = "net2";
            package-id = "net2 0.2.33 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.2.8 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "ws2_32-sys"
            ];
            extern-name = "ws2_32";
            package-id = "ws2_32-sys 0.2.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "miow";
            version = "0.2.1";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "A zero overhead I/O library for Windows, focusing on IOCP and Async I/O\nabstractions.\n";
            homepage = "https://github.com/alexcrichton/miow";
            documentation = "https://docs.rs/miow/0.1/x86_64-pc-windows-msvc/miow/";
            readme = "README.md";
            keywords = [
              "iocp"
              "windows"
              "io"
              "overlapped"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/miow";
          };
          dependencies = {
            kernel32-sys = "0.2";
            net2 = {
              version = "0.2.5";
              default-features = false;
            };
            winapi = "0.2";
            ws2_32-sys = "0.2";
          };
          dev-dependencies = {
            rand = "0.3";
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".winapi-i686-pc-windows-gnu."0.4.0" = mkRustCrate {
        package-id = "winapi-i686-pc-windows-gnu 0.4.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "winapi-i686-pc-windows-gnu";
          version = "0.4.0";
          sha256 = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "winapi-i686-pc-windows-gnu";
            version = "0.4.0";
            authors = [
              "Peter Atashian <retep998@gmail.com>"
            ];
            build = "build.rs";
            include = [
              "src/*"
              "lib/*"
              "Cargo.toml"
              "build.rs"
            ];
            description = "Import libraries for the i686-pc-windows-gnu target. Please don't use this crate directly, depend on winapi instead.";
            keywords = [
              "windows"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/retep998/winapi-rs";
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".net2."0.2.33" = mkRustCrate {
        package-id = "net2 0.2.33 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "net2";
          version = "0.2.33";
          sha256 = "42550d9fb7b6684a6d404d9fa7250c2eb2646df731d1c06afc06dcee9e1bcf88";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "cfg-if"
            ];
            extern-name = "cfg_if";
            package-id = "cfg-if 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "net2";
            version = "0.2.33";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "Extensions to the standard library's networking types as proposed in RFC 1158.\n";
            homepage = "https://github.com/rust-lang-nursery/net2-rs";
            documentation = "https://doc.rust-lang.org/net2-rs/";
            readme = "README.md";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/rust-lang-nursery/net2-rs";
          };
          dependencies = {
            cfg-if = {
              version = "0.1";
            };
          };
          features = {
            default = [
              "duration"
            ];
            duration = [
            ];
            nightly = [
            ];
          };
          target = {
            "cfg(any(target_os=\"redox\", unix))" = {
              dependencies = {
                libc = {
                  version = "0.2.42";
                };
              };
            };
            "cfg(windows)" = {
              dependencies = {
                winapi = {
                  version = "0.3";
                  features = [
                    "handleapi"
                    "winsock2"
                    "ws2def"
                    "ws2ipdef"
                    "ws2tcpip"
                  ];
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".core-foundation."0.6.4" = mkRustCrate {
        package-id = "core-foundation 0.6.4 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "core-foundation";
          version = "0.6.4";
          sha256 = "25b9e03f145fd4f2bf705e07b900cd41fc636598fe5dc452fd0db1441c3f496d";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "core-foundation-sys"
            ];
            extern-name = "core_foundation_sys";
            package-id = "core-foundation-sys 0.6.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "core-foundation";
            version = "0.6.4";
            authors = [
              "The Servo Project Developers"
            ];
            description = "Bindings to Core Foundation for macOS";
            homepage = "https://github.com/servo/core-foundation-rs";
            keywords = [
              "macos"
              "framework"
              "objc"
            ];
            categories = [
              "os::macos-apis"
            ];
            license = "MIT / Apache-2.0";
            repository = "https://github.com/servo/core-foundation-rs";
          };
          dependencies = {
            chrono = {
              version = "0.4";
              optional = true;
            };
            core-foundation-sys = {
              version = "0.6.1";
            };
            libc = {
              version = "0.2";
            };
            uuid = {
              version = "0.5";
              optional = true;
            };
          };
          features = {
            mac_os_10_7_support = [
              "core-foundation-sys/mac_os_10_7_support"
            ];
            mac_os_10_8_features = [
              "core-foundation-sys/mac_os_10_8_features"
            ];
            with-chrono = [
              "chrono"
            ];
            with-uuid = [
              "uuid"
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".rand_hc."0.1.0" = mkRustCrate {
        package-id = "rand_hc 0.1.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "rand_hc";
          version = "0.1.0";
          sha256 = "7b40677c7be09ae76218dc623efbf7b18e34bced3f38883af07bb75630a21bc4";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "rand_core"
            ];
            extern-name = "rand_core";
            package-id = "rand_core 0.3.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "rand_hc";
            version = "0.1.0";
            authors = [
              "The Rand Project Developers"
            ];
            description = "HC128 random number generator\n";
            homepage = "https://crates.io/crates/rand_hc";
            documentation = "https://docs.rs/rand_hc";
            readme = "README.md";
            keywords = [
              "random"
              "rng"
              "hc128"
            ];
            categories = [
              "algorithms"
              "no-std"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/rust-random/rand";
          };
          dependencies = {
            rand_core = {
              version = ">=0.2, <0.4";
              default-features = false;
            };
          };
          badges = {
            appveyor = {
              repository = "rust-random/rand";
            };
            travis-ci = {
              repository = "rust-random/rand";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".semver-parser."0.7.0" = mkRustCrate {
        package-id = "semver-parser 0.7.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "semver-parser";
          version = "0.7.0";
          sha256 = "388a1df253eca08550bef6c72392cfe7c30914bf41df5269b68cbd6ff8f570a3";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "semver-parser";
            version = "0.7.0";
            authors = [
              "Steve Klabnik <steve@steveklabnik.com>"
            ];
            description = "Parsing of the semver spec.\n";
            homepage = "https://github.com/steveklabnik/semver-parser";
            documentation = "https://docs.rs/semver-parser";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/steveklabnik/semver-parser";
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".tokio-trace-core."0.2.0" = mkRustCrate {
        package-id = "tokio-trace-core 0.2.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "tokio-trace-core";
          version = "0.2.0";
          sha256 = "a9c8a256d6956f7cb5e2bdfe8b1e8022f1a09206c6c2b1ba00f3b746b260c613";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "lazy_static"
            ];
            extern-name = "lazy_static";
            package-id = "lazy_static 1.3.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "tokio-trace-core";
            version = "0.2.0";
            authors = [
              "Tokio Contributors <team@tokio.rs>"
            ];
            description = "Core primitives for tokio-trace.\n";
            homepage = "https://tokio.rs";
            documentation = "https://docs.rs/tokio-trace-core/0.2.0/tokio_trace_core";
            keywords = [
              "logging"
              "tracing"
            ];
            categories = [
              "development-tools::debugging"
            ];
            license = "MIT";
            repository = "https://github.com/tokio-rs/tokio";
          };
          dependencies = {
            lazy_static = {
              version = "1.0.0";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".quote."0.6.12" = mkRustCrate {
        package-id = "quote 0.6.12 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "quote";
          version = "0.6.12";
          sha256 = "faf4799c5d274f3868a4aae320a0a182cbd2baee377b378f080e16a23e9d80db";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "proc-macro2"
            ];
            extern-name = "proc_macro2";
            package-id = "proc-macro2 0.4.30 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "quote";
            version = "0.6.12";
            authors = [
              "David Tolnay <dtolnay@gmail.com>"
            ];
            include = [
              "Cargo.toml"
              "src/**/*.rs"
              "tests/**/*.rs"
              "README.md"
              "LICENSE-APACHE"
              "LICENSE-MIT"
            ];
            description = "Quasi-quoting macro quote!(...)";
            documentation = "https://docs.rs/quote/";
            readme = "README.md";
            keywords = [
              "syn"
            ];
            categories = [
              "development-tools::procedural-macro-helpers"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/dtolnay/quote";
          };
          dependencies = {
            proc-macro2 = {
              version = "0.4.21";
              default-features = false;
            };
          };
          features = {
            default = [
              "proc-macro"
            ];
            proc-macro = [
              "proc-macro2/proc-macro"
            ];
          };
          badges = {
            travis-ci = {
              repository = "dtolnay/quote";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".parking_lot."0.7.1" = mkRustCrate {
        package-id = "parking_lot 0.7.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "parking_lot";
          version = "0.7.1";
          sha256 = "ab41b4aed082705d1056416ae4468b6ea99d52599ecf3169b00088d43113e337";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "lock_api"
            ];
            extern-name = "lock_api";
            package-id = "lock_api 0.1.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "parking_lot_core"
            ];
            extern-name = "parking_lot_core";
            package-id = "parking_lot_core 0.4.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "parking_lot";
            version = "0.7.1";
            authors = [
              "Amanieu d'Antras <amanieu@gmail.com>"
            ];
            description = "More compact and efficient implementations of the standard synchronization primitives.";
            readme = "README.md";
            keywords = [
              "mutex"
              "condvar"
              "rwlock"
              "once"
              "thread"
            ];
            categories = [
              "concurrency"
            ];
            license = "Apache-2.0/MIT";
            repository = "https://github.com/Amanieu/parking_lot";
          };
          dependencies = {
            lock_api = {
              version = "0.1";
            };
            parking_lot_core = {
              version = "0.4";
            };
          };
          dev-dependencies = {
            rand = {
              version = "0.6";
            };
          };
          features = {
            deadlock_detection = [
              "parking_lot_core/deadlock_detection"
            ];
            default = [
              "owning_ref"
            ];
            nightly = [
              "parking_lot_core/nightly"
              "lock_api/nightly"
            ];
            owning_ref = [
              "lock_api/owning_ref"
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".rand_chacha."0.1.1" = mkRustCrate {
        package-id = "rand_chacha 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "rand_chacha";
          version = "0.1.1";
          sha256 = "556d3a1ca6600bfcbab7c7c91ccb085ac7fbbcd70e008a98742e7847f4f7bcef";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "autocfg"
            ];
            extern-name = "autocfg";
            package-id = "autocfg 0.1.4 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rand_core"
            ];
            extern-name = "rand_core";
            package-id = "rand_core 0.3.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "rand_chacha";
            version = "0.1.1";
            authors = [
              "The Rand Project Developers"
              "The Rust Project Developers"
            ];
            build = "build.rs";
            description = "ChaCha random number generator\n";
            homepage = "https://crates.io/crates/rand_chacha";
            documentation = "https://rust-random.github.io/rand/rand_chacha";
            readme = "README.md";
            keywords = [
              "random"
              "rng"
              "chacha"
            ];
            categories = [
              "algorithms"
              "no-std"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/rust-random/rand";
          };
          dependencies = {
            rand_core = {
              version = ">=0.2, <0.4";
              default-features = false;
            };
          };
          build-dependencies = {
            autocfg = {
              version = "0.1";
            };
          };
          badges = {
            appveyor = {
              repository = "rust-random/rand";
            };
            travis-ci = {
              repository = "rust-random/rand";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".humantime."1.2.0" = mkRustCrate {
        package-id = "humantime 1.2.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "humantime";
          version = "1.2.0";
          sha256 = "3ca7e5f2e110db35f93b837c81797f3714500b81d517bf20c431b16d3ca4f114";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "quick-error"
            ];
            extern-name = "quick_error";
            package-id = "quick-error 1.2.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "humantime";
            version = "1.2.0";
            authors = [
              "Paul Colomiets <paul@colomiets.name>"
            ];
            description = "    A parser and formatter for std::time::{Duration, SystemTime}\n";
            homepage = "https://github.com/tailhook/humantime";
            documentation = "https://docs.rs/humantime";
            readme = "README.md";
            keywords = [
              "time"
              "human"
              "human-friendly"
              "parser"
              "duration"
            ];
            categories = [
              "date-and-time"
            ];
            license = "MIT/Apache-2.0";
          };
          lib = {
            name = "humantime";
            path = "src/lib.rs";
          };
          dependencies = {
            quick-error = {
              version = "1.0.0";
            };
          };
          dev-dependencies = {
            chrono = {
              version = "0.4.0";
            };
            rand = {
              version = "0.4.2";
            };
            time = {
              version = "0.1.39";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".same-file."1.0.4" = mkRustCrate {
        package-id = "same-file 1.0.4 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "same-file";
          version = "1.0.4";
          sha256 = "8f20c4be53a8a1ff4c1f1b2bd14570d2f634628709752f0702ecdd2b3f9a5267";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "winapi-util"
            ];
            extern-name = "winapi_util";
            package-id = "winapi-util 0.1.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "same-file";
            version = "1.0.4";
            authors = [
              "Andrew Gallant <jamslam@gmail.com>"
            ];
            exclude = [
              "/.travis.yml"
              "/appveyor.yml"
            ];
            description = "A simple crate for determining whether two file paths point to the same file.\n";
            homepage = "https://github.com/BurntSushi/same-file";
            documentation = "https://docs.rs/same-file";
            readme = "README.md";
            keywords = [
              "same"
              "file"
              "equal"
              "inode"
            ];
            license = "Unlicense/MIT";
            repository = "https://github.com/BurntSushi/same-file";
          };
          dev-dependencies = {
            rand = {
              version = "0.4";
            };
          };
          target = {
            "cfg(windows)" = {
              dependencies = {
                winapi-util = {
                  version = "0.1.1";
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".fnv."1.0.6" = mkRustCrate {
        package-id = "fnv 1.0.6 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "fnv";
          version = "1.0.6";
          sha256 = "2fad85553e09a6f881f739c29f0b00b0f01357c743266d478b68951ce23285f3";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "fnv";
            version = "1.0.6";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "Fowler–Noll–Vo hash function";
            documentation = "https://doc.servo.org/fnv/";
            readme = "README.md";
            license = "Apache-2.0 / MIT";
            repository = "https://github.com/servo/rust-fnv";
          };
          lib = {
            name = "fnv";
            path = "lib.rs";
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".semver."0.9.0" = mkRustCrate {
        package-id = "semver 0.9.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "semver";
          version = "0.9.0";
          sha256 = "1d7eb9ef2c18661902cc47e535f9bc51b78acd254da71d375c2f6720d9a40403";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "semver-parser"
            ];
            extern-name = "semver_parser";
            package-id = "semver-parser 0.7.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "serde"
            ];
            extern-name = "serde";
            package-id = "serde 1.0.92 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "semver";
            version = "0.9.0";
            authors = [
              "Steve Klabnik <steve@steveklabnik.com>"
              "The Rust Project Developers"
            ];
            description = "Semantic version parsing and comparison.\n";
            homepage = "https://docs.rs/crate/semver/";
            documentation = "https://docs.rs/crate/semver/";
            readme = "README.md";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/steveklabnik/semver";
          };
          dependencies = {
            semver-parser = {
              version = "0.7.0";
            };
            serde = {
              version = "1.0";
              optional = true;
            };
          };
          dev-dependencies = {
            crates-index = {
              version = "0.5.0";
            };
            serde_derive = {
              version = "1.0";
            };
            serde_json = {
              version = "1.0";
            };
            tempdir = {
              version = "0.3.4";
            };
          };
          features = {
            ci = [
              "serde"
            ];
            default = [
            ];
          };
          badges = {
            travis-ci = {
              repository = "steveklabnik/semver";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".unicode-xid."0.1.0" = mkRustCrate {
        package-id = "unicode-xid 0.1.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "unicode-xid";
          version = "0.1.0";
          sha256 = "fc72304796d0818e357ead4e000d19c9c174ab23dc11093ac919054d20a6a7fc";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "unicode-xid";
            version = "0.1.0";
            authors = [
              "erick.tryzelaar <erick.tryzelaar@gmail.com>"
              "kwantam <kwantam@gmail.com>"
            ];
            exclude = [
              "target/*"
              "Cargo.lock"
            ];
            description = "Determine whether characters have the XID_Start\nor XID_Continue properties according to\nUnicode Standard Annex #31.\n";
            homepage = "https://github.com/unicode-rs/unicode-xid";
            documentation = "https://unicode-rs.github.io/unicode-xid";
            readme = "README.md";
            keywords = [
              "text"
              "unicode"
              "xid"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/unicode-rs/unicode-xid";
          };
          features = {
            bench = [
            ];
            default = [
            ];
            no_std = [
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".tokio-signal."0.2.7" = mkRustCrate {
        package-id = "tokio-signal 0.2.7 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "tokio-signal";
          version = "0.2.7";
          sha256 = "dd6dc5276ea05ce379a16de90083ec80836440d5ef8a6a39545a3207373b8296";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "futures"
            ];
            extern-name = "futures";
            package-id = "futures 0.1.27 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "mio"
            ];
            extern-name = "mio";
            package-id = "mio 0.6.19 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "mio-uds"
            ];
            extern-name = "mio_uds";
            package-id = "mio-uds 0.6.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "signal-hook"
            ];
            extern-name = "signal_hook";
            package-id = "signal-hook 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-executor"
            ];
            extern-name = "tokio_executor";
            package-id = "tokio-executor 0.1.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-io"
            ];
            extern-name = "tokio_io";
            package-id = "tokio-io 0.1.12 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "tokio-reactor"
            ];
            extern-name = "tokio_reactor";
            package-id = "tokio-reactor 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.3.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "tokio-signal";
            version = "0.2.7";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            description = "An implementation of an asynchronous Unix signal handling backed futures.\n";
            homepage = "https://github.com/tokio-rs/tokio";
            documentation = "https://docs.rs/tokio-signal/0.2.7/tokio_signal";
            categories = [
              "asynchronous"
            ];
            license = "MIT";
            repository = "https://github.com/tokio-rs/tokio";
          };
          dependencies = {
            futures = {
              version = "0.1.11";
            };
            mio = {
              version = "0.6.14";
            };
            tokio-executor = {
              version = "0.1.0";
            };
            tokio-io = {
              version = "0.1";
            };
            tokio-reactor = {
              version = "0.1.0";
            };
          };
          dev-dependencies = {
            tokio = {
              version = "0.1.8";
            };
          };
          target = {
            "cfg(unix)" = {
              dependencies = {
                libc = {
                  version = "0.2";
                };
                mio-uds = {
                  version = "0.6";
                };
                signal-hook = {
                  version = "0.1";
                };
              };
            };
            "cfg(windows)" = {
              dependencies = {
                winapi = {
                  version = "0.3";
                  features = [
                    "minwindef"
                    "wincon"
                  ];
                };
              };
            };
          };
          badges = {
            appveyor = {
              id = "s83yxhy9qeb58va7";
              repository = "carllerche/tokio";
            };
            travis-ci = {
              repository = "tokio-rs/tokio";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".openssl."0.10.23" = mkRustCrate {
        package-id = "openssl 0.10.23 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "openssl";
          version = "0.10.23";
          sha256 = "97c140cbb82f3b3468193dd14c1b88def39f341f68257f8a7fe8ed9ed3f628a5";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "bitflags"
            ];
            extern-name = "bitflags";
            package-id = "bitflags 1.1.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "cfg-if"
            ];
            extern-name = "cfg_if";
            package-id = "cfg-if 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "foreign-types"
            ];
            extern-name = "foreign_types";
            package-id = "foreign-types 0.3.2 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "lazy_static"
            ];
            extern-name = "lazy_static";
            package-id = "lazy_static 1.3.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "openssl-sys"
            ];
            extern-name = "openssl_sys";
            package-id = "openssl-sys 0.9.47 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "openssl";
            version = "0.10.23";
            authors = [
              "Steven Fackler <sfackler@gmail.com>"
            ];
            description = "OpenSSL bindings";
            readme = "README.md";
            keywords = [
              "crypto"
              "tls"
              "ssl"
              "dtls"
            ];
            categories = [
              "cryptography"
              "api-bindings"
            ];
            license = "Apache-2.0";
            repository = "https://github.com/sfackler/rust-openssl";
          };
          dependencies = {
            bitflags = {
              version = "1.0";
            };
            cfg-if = {
              version = "0.1";
            };
            foreign-types = {
              version = "0.3.1";
            };
            lazy_static = {
              version = "1";
            };
            libc = {
              version = "0.2";
            };
            openssl-sys = {
              version = "0.9.47";
            };
          };
          dev-dependencies = {
            hex = {
              version = "0.3";
            };
            tempdir = {
              version = "0.3";
            };
          };
          features = {
            v101 = [
            ];
            v102 = [
            ];
            v110 = [
            ];
            v111 = [
            ];
            vendored = [
              "openssl-sys/vendored"
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".winapi."0.2.8" = mkRustCrate {
        package-id = "winapi 0.2.8 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "winapi";
          version = "0.2.8";
          sha256 = "167dc9d6949a9b857f3451275e911c3f44255842c1f7a76f33c55103a909087a";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "winapi";
            version = "0.2.8";
            authors = [
              "Peter Atashian <retep998@gmail.com>"
            ];
            include = [
              "src/**/*"
              "Cargo.toml"
              "LICENSE.md"
            ];
            description = "Types and constants for WinAPI bindings. See README for list of crates providing function bindings.";
            documentation = "https://retep998.github.io/doc/winapi/";
            readme = "README.md";
            keywords = [
              "windows"
              "ffi"
              "win32"
              "com"
              "directx"
            ];
            license = "MIT";
            repository = "https://github.com/retep998/winapi-rs";
          };
          dev-dependencies = {
            advapi32-sys = {
              version = "0";
              path = "lib/advapi32";
            };
            bcrypt-sys = {
              version = "0";
              path = "lib/bcrypt";
            };
            comctl32-sys = {
              version = "0";
              path = "lib/comctl32";
            };
            comdlg32-sys = {
              version = "0";
              path = "lib/comdlg32";
            };
            credui-sys = {
              version = "0";
              path = "lib/credui";
            };
            crypt32-sys = {
              version = "0";
              path = "lib/crypt32";
            };
            d2d1-sys = {
              version = "0";
              path = "lib/d2d1";
            };
            d3d11-sys = {
              version = "0";
              path = "lib/d3d11";
            };
            d3d12-sys = {
              version = "0";
              path = "lib/d3d12";
            };
            d3d9-sys = {
              version = "0";
              path = "lib/d3d9";
            };
            d3dcompiler-sys = {
              version = "0";
              path = "lib/d3dcompiler";
            };
            dbghelp-sys = {
              version = "0";
              path = "lib/dbghelp";
            };
            dsound-sys = {
              version = "0";
              path = "lib/dsound";
            };
            dwmapi-sys = {
              version = "0";
              path = "lib/dwmapi";
            };
            dwrite-sys = {
              version = "0";
              path = "lib/dwrite";
            };
            dxgi-sys = {
              version = "0";
              path = "lib/dxgi";
            };
            dxguid-sys = {
              version = "0";
              path = "lib/dxguid";
            };
            gdi32-sys = {
              version = "0";
              path = "lib/gdi32";
            };
            hid-sys = {
              version = "0";
              path = "lib/hid";
            };
            httpapi-sys = {
              version = "0";
              path = "lib/httpapi";
            };
            kernel32-sys = {
              version = "0";
              path = "lib/kernel32";
            };
            ktmw32-sys = {
              version = "0";
              path = "lib/ktmw32";
            };
            mpr-sys = {
              version = "0";
              path = "lib/mpr";
            };
            netapi32-sys = {
              version = "0";
              path = "lib/netapi32";
            };
            odbc32-sys = {
              version = "0";
              path = "lib/odbc32";
            };
            ole32-sys = {
              version = "0";
              path = "lib/ole32";
            };
            oleaut32-sys = {
              version = "0";
              path = "lib/oleaut32";
            };
            opengl32-sys = {
              version = "0";
              path = "lib/opengl32";
            };
            pdh-sys = {
              version = "0";
              path = "lib/pdh";
            };
            psapi-sys = {
              version = "0";
              path = "lib/psapi";
            };
            runtimeobject-sys = {
              version = "0";
              path = "lib/runtimeobject";
            };
            secur32-sys = {
              version = "0";
              path = "lib/secur32";
            };
            setupapi-sys = {
              version = "0";
              path = "lib/setupapi";
            };
            shell32-sys = {
              version = "0";
              path = "lib/shell32";
            };
            shlwapi-sys = {
              version = "0";
              path = "lib/shlwapi";
            };
            user32-sys = {
              version = "0";
              path = "lib/user32";
            };
            userenv-sys = {
              version = "0";
              path = "lib/userenv";
            };
            usp10-sys = {
              version = "0";
              path = "lib/usp10";
            };
            uuid-sys = {
              version = "0";
              path = "lib/uuid";
            };
            vssapi-sys = {
              version = "0";
              path = "lib/vssapi";
            };
            wevtapi-sys = {
              version = "0";
              path = "lib/wevtapi";
            };
            winhttp-sys = {
              version = "0";
              path = "lib/winhttp";
            };
            winmm-sys = {
              version = "0";
              path = "lib/winmm";
            };
            winscard-sys = {
              version = "0";
              path = "lib/winscard";
            };
            winspool-sys = {
              version = "0";
              path = "lib/winspool";
            };
            winusb-sys = {
              version = "0";
              path = "lib/winusb";
            };
            ws2_32-sys = {
              version = "0";
              path = "lib/ws2_32";
            };
            xinput-sys = {
              version = "0";
              path = "lib/xinput";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".miniz_oxide_c_api."0.2.1" = mkRustCrate {
        package-id = "miniz_oxide_c_api 0.2.1 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "miniz_oxide_c_api";
          version = "0.2.1";
          sha256 = "b7fe927a42e3807ef71defb191dc87d4e24479b221e67015fe38ae2b7b447bab";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "cc"
            ];
            extern-name = "cc";
            package-id = "cc 1.0.37 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "crc"
            ];
            extern-name = "crc";
            package-id = "crc 1.8.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "miniz_oxide"
            ];
            extern-name = "miniz_oxide";
            package-id = "miniz_oxide 0.2.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "miniz_oxide_c_api";
            version = "0.2.1";
            authors = [
              "Frommi <daniil.liferenko@gmail.com>"
            ];
            build = "src/build.rs";
            exclude = [
              "benches/data/*"
              "/*.sh"
              "/redefine.txt"
            ];
            description = "DEFLATE compression and decompression API designed to be Rust drop-in replacement for miniz";
            homepage = "https://github.com/Frommi/miniz_oxide/";
            documentation = "https://docs.rs/miniz_oxide_c_api";
            readme = "README.md";
            keywords = [
              "zlib"
              "miniz"
              "deflate"
              "encoding"
            ];
            categories = [
              "compression"
            ];
            license = "MIT";
            repository = "https://github.com/Frommi/miniz_oxide";
          };
          profile = {
            dev = {
              panic = "abort";
            };
            release = {
              panic = "abort";
            };
          };
          lib = {
            name = "miniz_oxide_c_api";
          };
          dependencies = {
            crc = {
              version = "1.0.0";
            };
            libc = {
              version = "0.2.22";
            };
            miniz_oxide = {
              version = "0.2.1";
            };
          };
          build-dependencies = {
            cc = {
              version = "1.0";
            };
          };
          features = {
            benching = [
              "build_orig_miniz"
              "no_c_export"
            ];
            build_orig_miniz = [
            ];
            build_stub_miniz = [
            ];
            default = [
            ];
            fuzzing = [
              "build_orig_miniz"
              "no_c_export"
            ];
            libc_stub = [
            ];
            miniz_zip = [
              "build_stub_miniz"
            ];
            no_c_export = [
            ];
          };
          badges = {
            travis-ci = {
              repository = "Frommi/miniz_oxide";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".crossbeam-channel."0.3.8" = mkRustCrate {
        package-id = "crossbeam-channel 0.3.8 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "crossbeam-channel";
          version = "0.3.8";
          sha256 = "0f0ed1a4de2235cabda8558ff5840bffb97fcb64c97827f354a451307df5f72b";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "crossbeam-utils"
            ];
            extern-name = "crossbeam_utils";
            package-id = "crossbeam-utils 0.6.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "smallvec"
            ];
            extern-name = "smallvec";
            package-id = "smallvec 0.6.10 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "crossbeam-channel";
            version = "0.3.8";
            authors = [
              "The Crossbeam Project Developers"
            ];
            description = "Multi-producer multi-consumer channels for message passing";
            homepage = "https://github.com/crossbeam-rs/crossbeam/tree/master/crossbeam-channel";
            documentation = "https://docs.rs/crossbeam-channel";
            readme = "README.md";
            keywords = [
              "channel"
              "mpmc"
              "select"
              "golang"
              "message"
            ];
            categories = [
              "algorithms"
              "concurrency"
              "data-structures"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/crossbeam-rs/crossbeam";
          };
          dependencies = {
            crossbeam-utils = {
              version = "0.6.5";
            };
            smallvec = {
              version = "0.6.2";
            };
          };
          dev-dependencies = {
            rand = {
              version = "0.6";
            };
            signal-hook = {
              version = "0.1.5";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".log."0.4.6" = mkRustCrate {
        package-id = "log 0.4.6 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "log";
          version = "0.4.6";
          sha256 = "c84ec4b527950aa83a329754b01dbe3f58361d1c5efacd1f6d68c494d08a17c6";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "cfg-if"
              "cfg-if"
            ];
            extern-name = "cfg_if";
            package-id = "cfg-if 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "log";
            version = "0.4.6";
            authors = [
              "The Rust Project Developers"
            ];
            description = "A lightweight logging facade for Rust\n";
            homepage = "https://github.com/rust-lang/log";
            documentation = "https://docs.rs/log";
            readme = "README.md";
            keywords = [
              "logging"
            ];
            categories = [
              "development-tools::debugging"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/rust-lang/log";
            metadata = {
              docs = {
                rs = {
                  features = [
                    "std"
                    "serde"
                  ];
                };
              };
            };
          };
          test = [
            {
              name = "filters";
              harness = false;
            }
          ];
          dependencies = {
            cfg-if = {
              version = "0.1.2";
            };
            serde = {
              version = "1.0";
              optional = true;
              default-features = false;
            };
          };
          dev-dependencies = {
            serde_test = {
              version = "1.0";
            };
          };
          features = {
            max_level_debug = [
            ];
            max_level_error = [
            ];
            max_level_info = [
            ];
            max_level_off = [
            ];
            max_level_trace = [
            ];
            max_level_warn = [
            ];
            release_max_level_debug = [
            ];
            release_max_level_error = [
            ];
            release_max_level_info = [
            ];
            release_max_level_off = [
            ];
            release_max_level_trace = [
            ];
            release_max_level_warn = [
            ];
            std = [
            ];
          };
          badges = {
            appveyor = {
              repository = "alexcrichton/log";
            };
            travis-ci = {
              repository = "rust-lang-nursery/log";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".commoncrypto-sys."0.2.0" = mkRustCrate {
        package-id = "commoncrypto-sys 0.2.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "commoncrypto-sys";
          version = "0.2.0";
          sha256 = "1fed34f46747aa73dfaa578069fd8279d2818ade2b55f38f22a9401c7f4083e2";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "commoncrypto-sys";
            version = "0.2.0";
            authors = [
              "Mark Lee"
            ];
            description = "FFI bindings to Mac OS X's CommonCrypto library";
            documentation = "https://docs.rs/commoncrypto-sys";
            keywords = [
              "crypto"
              "hash"
              "digest"
              "osx"
              "commoncrypto"
            ];
            license = "MIT";
            repository = "https://github.com/malept/rust-commoncrypto";
          };
          dependencies = {
            clippy = {
              version = "0.0";
              optional = true;
            };
            libc = "0.2";
          };
          dev-dependencies = {
            hex = "0.2";
          };
          features = {
            lint = [
              "clippy"
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".libssh2-sys."0.2.11" = mkRustCrate {
        package-id = "libssh2-sys 0.2.11 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "libssh2-sys";
          version = "0.2.11";
          sha256 = "126a1f4078368b163bfdee65fbab072af08a1b374a5551b21e87ade27b1fbf9d";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "cc"
            ];
            extern-name = "cc";
            package-id = "cc 1.0.37 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libz-sys"
            ];
            extern-name = "libz_sys";
            package-id = "libz-sys 1.0.25 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "openssl-sys"
            ];
            extern-name = "openssl_sys";
            package-id = "openssl-sys 0.9.47 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "pkg-config"
            ];
            extern-name = "pkg_config";
            package-id = "pkg-config 0.3.14 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "vcpkg"
            ];
            extern-name = "vcpkg";
            package-id = "vcpkg 0.2.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "libssh2-sys";
            version = "0.2.11";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            build = "build.rs";
            links = "ssh2";
            description = "Native bindings to the libssh2 library";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/ssh2-rs";
          };
          lib = {
            name = "libssh2_sys";
            path = "lib.rs";
          };
          dependencies = {
            libc = {
              version = "0.2";
            };
            libz-sys = {
              version = "1.0.21";
            };
          };
          build-dependencies = {
            cc = {
              version = "1.0.25";
            };
            pkg-config = {
              version = "0.3.11";
            };
          };
          target = {
            "cfg(target_env = \"msvc\")" = {
              build-dependencies = {
                vcpkg = {
                  version = "0.2";
                };
              };
            };
            "cfg(unix)" = {
              dependencies = {
                openssl-sys = {
                  version = "0.9.35";
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".env_logger."0.6.2" = mkRustCrate {
        package-id = "env_logger 0.6.2 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "env_logger";
          version = "0.6.2";
          sha256 = "aafcde04e90a5226a6443b7aabdb016ba2f8307c847d524724bd9b346dd1a2d3";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "atty"
            ];
            extern-name = "atty";
            package-id = "atty 0.2.11 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "humantime"
            ];
            extern-name = "humantime";
            package-id = "humantime 1.2.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "log"
            ];
            extern-name = "log";
            package-id = "log 0.4.6 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "regex"
            ];
            extern-name = "regex";
            package-id = "regex 1.1.7 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "termcolor"
            ];
            extern-name = "termcolor";
            package-id = "termcolor 1.0.5 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "env_logger";
            version = "0.6.2";
            authors = [
              "The Rust Project Developers"
            ];
            description = "A logging implementation for `log` which is configured via an environment\nvariable.\n";
            documentation = "https://docs.rs/env_logger";
            readme = "README.md";
            keywords = [
              "logging"
              "log"
              "logger"
            ];
            categories = [
              "development-tools::debugging"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/sebasmagri/env_logger/";
          };
          test = [
            {
              name = "regexp_filter";
              harness = false;
            }
            {
              name = "log-in-log";
              harness = false;
            }
            {
              name = "init-twice-retains-filter";
              harness = false;
            }
          ];
          dependencies = {
            atty = {
              version = "0.2.5";
              optional = true;
            };
            humantime = {
              version = "1.1";
              optional = true;
            };
            log = {
              version = "0.4";
              features = [
                "std"
              ];
            };
            regex = {
              version = "1.0.3";
              optional = true;
            };
            termcolor = {
              version = "1.0.2";
              optional = true;
            };
          };
          features = {
            default = [
              "termcolor"
              "atty"
              "humantime"
              "regex"
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".backtrace."0.3.30" = mkRustCrate {
        package-id = "backtrace 0.3.30 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "backtrace";
          version = "0.3.30";
          sha256 = "ada4c783bb7e7443c14e0480f429ae2cc99da95065aeab7ee1b81ada0419404f";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "autocfg"
            ];
            extern-name = "autocfg";
            package-id = "autocfg 0.1.4 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "backtrace-sys"
            ];
            extern-name = "backtrace_sys";
            package-id = "backtrace-sys 0.1.28 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "cfg-if"
            ];
            extern-name = "cfg_if";
            package-id = "cfg-if 0.1.9 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "libc"
            ];
            extern-name = "libc";
            package-id = "libc 0.2.58 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "rustc-demangle"
            ];
            extern-name = "rustc_demangle";
            package-id = "rustc-demangle 0.1.15 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "backtrace";
            version = "0.3.30";
            authors = [
              "The Rust Project Developers"
            ];
            autoexamples = true;
            autotests = true;
            description = "A library to acquire a stack trace (backtrace) at runtime in a Rust program.\n";
            homepage = "https://github.com/rust-lang/backtrace-rs";
            documentation = "https://docs.rs/backtrace";
            readme = "README.md";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/rust-lang/backtrace-rs";
          };
          example = [
            {
              name = "backtrace";
              required-features = [
                "std"
              ];
            }
            {
              name = "raw";
              required-features = [
                "std"
              ];
            }
          ];
          test = [
            {
              name = "skip_inner_frames";
              required-features = [
                "std"
              ];
            }
            {
              name = "long_fn_name";
              required-features = [
                "std"
              ];
            }
            {
              name = "smoke";
              required-features = [
                "std"
              ];
              edition = "2018";
            }
            {
              name = "accuracy";
              required-features = [
                "std"
                "dbghelp"
                "libbacktrace"
                "libunwind"
              ];
              edition = "2018";
            }
          ];
          dependencies = {
            addr2line = {
              version = "0.9.0";
              optional = true;
            };
            backtrace-sys = {
              version = "0.1.17";
              optional = true;
            };
            cfg-if = {
              version = "0.1.6";
            };
            cpp_demangle = {
              version = "0.2.3";
              optional = true;
              default-features = false;
            };
            findshlibs = {
              version = "0.4.1";
              optional = true;
            };
            libc = {
              version = "0.2.45";
              default-features = false;
            };
            memmap = {
              version = "0.7.0";
              optional = true;
            };
            rustc-demangle = {
              version = "0.1.4";
            };
            rustc-serialize = {
              version = "0.3";
              optional = true;
            };
            serde = {
              version = "1.0";
              optional = true;
            };
            serde_derive = {
              version = "1.0";
              optional = true;
            };
          };
          build-dependencies = {
            autocfg = {
              version = "0.1";
            };
          };
          features = {
            coresymbolication = [
            ];
            dbghelp = [
            ];
            default = [
              "std"
              "libunwind"
              "libbacktrace"
              "coresymbolication"
              "dladdr"
              "dbghelp"
            ];
            dladdr = [
            ];
            gimli-symbolize = [
              "addr2line"
              "findshlibs"
              "memmap"
            ];
            kernel32 = [
            ];
            libbacktrace = [
              "backtrace-sys"
            ];
            libunwind = [
            ];
            serialize-rustc = [
              "rustc-serialize"
            ];
            serialize-serde = [
              "serde"
              "serde_derive"
            ];
            std = [
            ];
            unix-backtrace = [
            ];
            verify-winapi = [
              "winapi/dbghelp"
              "winapi/handleapi"
              "winapi/libloaderapi"
              "winapi/minwindef"
              "winapi/processthreadsapi"
              "winapi/winbase"
              "winapi/winnt"
            ];
          };
          target = {
            "cfg(windows)" = {
              dependencies = {
                winapi = {
                  version = "0.3.3";
                  optional = true;
                };
              };
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".cc."1.0.37" = mkRustCrate {
        package-id = "cc 1.0.37 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "cc";
          version = "1.0.37";
          sha256 = "39f75544d7bbaf57560d2168f28fd649ff9c76153874db88bdbdfd839b1a7e7d";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
        ];
        cargo-manifest = {
          package = {
            name = "cc";
            version = "1.0.37";
            authors = [
              "Alex Crichton <alex@alexcrichton.com>"
            ];
            exclude = [
              "/.travis.yml"
              "/appveyor.yml"
            ];
            description = "A build-time dependency for Cargo build scripts to assist in invoking the native\nC compiler to compile native C code into a static archive to be linked into Rust\ncode.\n";
            homepage = "https://github.com/alexcrichton/cc-rs";
            documentation = "https://docs.rs/cc";
            readme = "README.md";
            keywords = [
              "build-dependencies"
            ];
            categories = [
              "development-tools::build-utils"
            ];
            license = "MIT/Apache-2.0";
            repository = "https://github.com/alexcrichton/cc-rs";
          };
          dependencies = {
            rayon = {
              version = "1.0";
              optional = true;
            };
          };
          dev-dependencies = {
            tempdir = {
              version = "0.3";
            };
          };
          features = {
            parallel = [
              "rayon"
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".foreign-types."0.3.2" = mkRustCrate {
        package-id = "foreign-types 0.3.2 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "foreign-types";
          version = "0.3.2";
          sha256 = "f6f339eb8adc052cd2ca78910fda869aefa38d22d5cb648e6485e4d3fc06f3b1";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "foreign-types-shared"
            ];
            extern-name = "foreign_types_shared";
            package-id = "foreign-types-shared 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "foreign-types";
            version = "0.3.2";
            authors = [
              "Steven Fackler <sfackler@gmail.com>"
            ];
            description = "A framework for Rust wrappers over C APIs";
            readme = "README.md";
            license = "MIT/Apache-2.0";
            repository = "https://github.com/sfackler/foreign-types";
          };
          dependencies = {
            foreign-types-shared = {
              version = "0.1";
            };
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".commoncrypto."0.2.0" = mkRustCrate {
        package-id = "commoncrypto 0.2.0 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "commoncrypto";
          version = "0.2.0";
          sha256 = "d056a8586ba25a1e4d61cb090900e495952c7886786fc55f909ab2f819b69007";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "commoncrypto-sys"
            ];
            extern-name = "commoncrypto_sys";
            package-id = "commoncrypto-sys 0.2.0 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "commoncrypto";
            version = "0.2.0";
            authors = [
              "Mark Lee"
            ];
            description = "Idiomatic Rust wrappers for Mac OS X's CommonCrypto library";
            documentation = "https://docs.rs/commoncrypto";
            keywords = [
              "crypto"
              "hash"
              "digest"
              "osx"
              "commoncrypto"
            ];
            license = "MIT";
            repository = "https://github.com/malept/rust-commoncrypto";
          };
          dependencies = {
            clippy = {
              version = "0.0";
              optional = true;
            };
            commoncrypto-sys = {
              version = "0.2.0";
              path = "../commoncrypto-sys";
            };
          };
          dev-dependencies = {
            hex = "0.2";
          };
          features = {
            lint = [
              "clippy"
            ];
          };
        };
      };
      "registry+https://github.com/rust-lang/crates.io-index".kernel32-sys."0.2.2" = mkRustCrate {
        package-id = "kernel32-sys 0.2.2 (registry+https://github.com/rust-lang/crates.io-index)";
        src = config.resolver {
          source = "registry+https://github.com/rust-lang/crates.io-index";
          name = "kernel32-sys";
          version = "0.2.2";
          sha256 = "7507624b29483431c0ba2d82aece8ca6cdba9382bff4ddd0f7490560c056098d";
          source-info = {
            index = "registry+https://github.com/rust-lang/crates.io-index";
          };
        };
        dependencies = [
          {
            toml-names = [
              "winapi"
            ];
            extern-name = "winapi";
            package-id = "winapi 0.2.8 (registry+https://github.com/rust-lang/crates.io-index)";
          }
          {
            toml-names = [
              "winapi-build"
            ];
            extern-name = "build";
            package-id = "winapi-build 0.1.1 (registry+https://github.com/rust-lang/crates.io-index)";
          }
        ];
        cargo-manifest = {
          package = {
            name = "kernel32-sys";
            version = "0.2.2";
            authors = [
              "Peter Atashian <retep998@gmail.com>"
            ];
            build = "build.rs";
            description = "Contains function definitions for the Windows API library kernel32. See winapi for types and constants.";
            documentation = "https://retep998.github.io/doc/kernel32/";
            readme = "README.md";
            keywords = [
              "windows"
              "ffi"
              "win32"
            ];
            license = "MIT";
            repository = "https://github.com/retep998/winapi-rs";
          };
          lib = {
            name = "kernel32";
          };
          dependencies = {
            winapi = {
              version = "0.2.5";
              path = "../..";
            };
          };
          build-dependencies = {
            winapi-build = {
              version = "0.1.1";
              path = "../../build";
            };
          };
        };
      };
    }))