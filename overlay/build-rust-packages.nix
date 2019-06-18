{ lib }:
lib.fix' (self: { buildRustPackages = self; })
