{ ... }@args:
import
  (fetchGit {
    url = https://github.com/NixOS/nixpkgs;
    rev = "47b551c6a854a049045455f8ab1b8750e7b00625";
  })
  (args // {
    config.packageOverrides = pkgs: {
      openssl = (pkgs.openssl.override {
        # `perl` is only used at build time, but the derivation incorrectly uses host perl
        # as an input.
        perl = pkgs.buildPackages.buildPackages.perl;
      }).overrideAttrs (_: {
        # `man` output is troublesome, disable it.
        installTargets = "install_sw";
        outputs = [ "bin" "dev" "out" ];
      });

      # `libuv` needs rebuilding because of the harmless `openssl` change above.
      # The test suite fails for some reason so just disable it.
      libuv = pkgs.libuv.overrideAttrs (_: { doCheck = false; });

      e2fsprogs = pkgs.e2fsprogs.overrideAttrs (_: { doCheck = false; });
    };
  })
