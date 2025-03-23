#!/usr/bin/env nix-shell
#! nix-shell -i bash -p bash jq rustc

# Extract the target info we need for cargo2nix

set -euo pipefail

export RUSTC_BOOTSTRAP=1 # needed to extract this data from stable

info_json='{}'

for target in $(rustc --print target-list); do
    target_info=$(rustc -Z unstable-options --print target-spec-json --target $target | jq '{"max-atomic-width": ."max-atomic-width", "target-pointer-width": ."target-pointer-width"|tonumber}') || continue
    info_json=$(echo "$info_json" | jq ".\"$target\" = $target_info")
done

echo "$info_json" > $(dirname $(realpath $0))/target-info.json

echo "Done. The errors above are not fatal."