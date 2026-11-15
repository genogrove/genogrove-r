#!/bin/sh
set -eu
repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$repo_dir"
check_dir=$(mktemp -d "${TMPDIR:-/tmp}/genogrove-r-test.XXXXXX")
trap 'rm -rf "$check_dir"' EXIT HUP INT TERM
mkdir "$check_dir/library"
R CMD INSTALL --preclean --library="$check_dir/library" .
R_LIBS="$check_dir/library${R_LIBS:+:$R_LIBS}" Rscript tests/binding.R
