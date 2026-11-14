# Agent instructions

## Project

This package binds the C++ genogrove library to R using Rcpp and C++20.
The upstream checkout is normally at `../genogrove`. This repository is
`genogrove-r`; the R package name is `genogrove` (`library(genogrove)`).

## Architecture

- Upstream defines data structures, algorithms, defaults and semantics.
- Bind `grove<genomic_coordinate, std::string>` in the current development slice.
- Keep coordinates 0-based closed and preserve upstream strand matching.
- Limit binding code to ownership, conversions, R access and error translation.
- Propose missing library functionality upstream instead of duplicating it here.
- Defer interoperability with other R packages until the native binding works.
- Keys and query results must retain their owning native objects.

## Commands

Install prerequisites: R, Rcpp, a C++20 compiler and zlib.

```sh
# Regenerate wrappers after changing Rcpp exports.
Rscript -e 'Rcpp::compileAttributes()'

# Build and install against the sibling upstream checkout.
R CMD INSTALL .

# Test the installed package.
Rscript tests/binding.R

# Check whitespace before committing.
git diff --check
```

Set `GENOGROVE_DIR` to an absolute upstream checkout path when using a different
location. Use `R CMD INSTALL --preclean .` after changing upstream headers to
force recompilation. Do not edit generated `R/RcppExports.R` or
`src/RcppExports.cpp` by hand.

## Change workflow

All changes go through a pull request. Create a feature branch before editing;
do not commit or push changes directly to `main`. Keep each PR focused and
include the relevant build and test results. Do not merge without instruction.

```sh
git switch -c feat/descriptive-name
git add <changed-files>
git commit -m "Describe the change"
git push -u origin feat/descriptive-name
gh pr create --base main --head feat/descriptive-name --title "Describe the change" --body-file /tmp/pr-body.md
```

Use pygenogrove's shared `AGENTS.md` and workflow structure as a reference,
adapting language-specific commands to R. Verify its implementation when its
documentation and code disagree.
