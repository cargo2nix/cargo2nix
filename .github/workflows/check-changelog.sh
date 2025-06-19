#!/usr/bin/env bash

set -uo pipefail

CHANGELOG_FILE="${1:-CHANGES.md}"

if [ "${NO_CHANGELOG_LABEL}" = "true" ]; then
    # 'no changelog' set, so finish successfully
    exit 0
else
    # a changelog check is required
    # fail if the diff is empty
    if git diff --exit-code "origin/${BASE_REF}" -- "${CHANGELOG_FILE}"; then
        echo >&2 "User-visible changes should come with an entry in the changelog.

Update this PR with an entry in ${CHANGELOG_FILE}, or add the \"no changelog\" label to the PR to suppress this check."
        exit 1
    fi
fi
