{ pkgs, noBuild, rustChannel }:
args@{
  inputsFrom ? [],
  nativeBuildInputs ? [],
  ...
}:

pkgs.mkShell (args // {
  # `noBuild` is a special crate set used to create a development shell
  # containing all native dependencies provided by the overrides above.
  # `cargo build` within the shell should just work.
  inputsFrom = (pkgs.lib.mapAttrsToList (_: pkg: pkg { }) noBuild.workspace) ++ inputsFrom;
  nativeBuildInputs = [ rustChannel ] ++ (with pkgs; [cacert]) ++ nativeBuildInputs;
  # Configures tools like Rust Analyzer to locate the correct rust-src
  RUST_SRC_PATH = "${rustChannel}/lib/rustlib/src/rust/library";
})
