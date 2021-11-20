{ pkgs, noBuild, rustChannel }:
{}:

pkgs.mkShell {
  # `noBuild` is a special crate set used to create a development shell
  # containing all native dependencies provided by the overrides above.
  # `cargo build` within the shell should just work.
  inputsFrom = pkgs.lib.mapAttrsToList (_: pkg: pkg { }) noBuild.workspace;
  nativeBuildInputs = [ rustChannel ] ++ (with pkgs; [cacert]);
  RUST_SRC_PATH = "${rustChannel}/lib/rustlib/src/rust/library";
}
