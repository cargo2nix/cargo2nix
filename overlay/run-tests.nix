# Run all tests for a crate.
{ runCommand }:
crate: env:
let
  testBins = crate { compileMode = "test"; };
in
  runCommand
    "test-${testBins.name}"
    ({
      inherit (testBins) src;
      CARGO_MANIFEST_DIR = testBins.src;
    } // env)
    ''
        for f in ${testBins}/bin/*; do
          # HACK: cargo produces the crate's main binary in the bin directory if the crate contains example tests.
          # The `grep` filters out the main binary, which doesn't contain the help string found in test binaries.
          if [[ -x "$f" ]] && grep "By default, all tests are run in parallel" "$f"; then
            $f
          fi
        done
        touch $out
    ''
