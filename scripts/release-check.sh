#!/bin/sh
# Build/check only; never tag, upload or publish. Retain reports for inspection.
set -eu
repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
upstream_dir=${GENOGROVE_DIR:-"$repo_dir/../genogrove"}
GENOGROVE_DIR=$(CDPATH= cd -- "$upstream_dir" && pwd)
export GENOGROVE_DIR
check_dir=$(mktemp -d "${TMPDIR:-/tmp}/genogrove-r-release.XXXXXX")
echo "Build artifacts and check reports: $check_dir"
cd "$check_dir"
R CMD build "$repo_dir"
set -- genogrove_*.tar.gz
if [ "$#" -ne 1 ] || [ ! -f "$1" ]; then
    echo "Expected exactly one source archive" >&2
    exit 1
fi
R CMD check --no-manual "$1"
