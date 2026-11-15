---
name: bindings-audit
description: Audit Rcpp bindings against upstream genogrove without modifying files.
---

Read-only: scope to requested files/category, otherwise inspect src/, R/,
NAMESPACE, DESCRIPTION, configure, generated exports, man/, README and tests/.
Cross-reference native signatures and invalidation in GENOGROVE_DIR or ../genogrove.

Prioritize dangling pointers, double finalization, missing owner retention,
R GC protection, unsafe casts, null restored pointers, mutation of inserted keys,
exception translation, exact numeric conversion, NA and strand/coordinate/default
parity. Check registration, copies and toolchain/dependency assumptions. R API
calls stay on R's main thread; Python GIL advice does not apply.
Map public behavior to tests, especially lifetime and negative cases. Respect
the current genomic_coordinate/string specialization and explicitly unbound APIs.
Report deduplicated severity, file/line, evidence, risk and fix, plus scope,
upstream revision, test gaps and positive patterns. Do not edit, post or build.
