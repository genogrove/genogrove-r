---
name: api-docs-update
description: Synchronize R exports, help and examples with the actual native-backed binding surface.
---

Inventory R wrappers, NAMESPACE, Rcpp attributes/registered calls and concrete
native types. Verify signatures, defaults, ownership and coordinate/strand
semantics against upstream. Compare with man/, README, DESCRIPTION and examples.
This adapts Python api-stubs-update to R; do not add Python type stubs.

Correct stale aliases, usage, arguments, returns, examples and limitations.
Do not expose new APIs merely to complete documentation. Preserve immutable
access to inserted keys. Regenerate wrappers with
`Rscript -e 'Rcpp::compileAttributes()'` when exports change; never hand-edit them.
Check examples against the installed package and relevant behavior with
scripts/test.sh. Distinguish R version from upstream revision; do not imply a
fixed dependency pin where none exists. Report edits and validation through a PR.
