# genogrove-r

R bindings for upstream genogrove. Data structures and algorithms remain in
genogrove; this package handles R objects, native ownership and conversions.
No Bioconductor interoperability is implemented yet.

The repository is named `genogrove-r`; the R package is named `genogrove`
and is loaded with `library(genogrove)`.

This first development slice binds `grove<genomic_coordinate, std::string>`: construction,
insertion, intersection, query/key access and interval endpoints. Coordinates
are upstream **0-based closed** coordinates. The default tree order is upstream's
3. Other key/payload types, graph operations, removal, flanking and serialization
are not yet bound. Native pointers cannot be persisted with `saveRDS()`.

`genomic_coordinate(strand, start, end)` follows upstream's constructor order.
Strands `+`, `-` and `.` match themselves; `*` matches any strand on either
side of a query. No coordinate or strand semantics are changed by the binding.

## Local installation

Requires R, Rcpp, a C++20 compiler, zlib and an upstream genogrove checkout.
By default the checkout is read from `../genogrove`. To select another checkout,
set `GENOGROVE_DIR` to its absolute path before installation.

```sh
R CMD INSTALL .
```

```r
library(genogrove)
g <- grove()
key <- insert_data(g, "chr1", genomic_coordinate("*", 100, 200), "gene1")
result <- intersect(g, genomic_coordinate("*", 200, 300), "chr1")
get_data(get_keys(result)[[1]]) # "gene1": position 200 is shared
get_start(get_value(key))      # 100
get_end(get_query(result))     # 300
```

Omitting `index` from `intersect()` searches all indices, matching upstream.
Keys and results keep their owning grove alive through garbage collection.
This development build uses the selected checkout's headers directly; it does
not copy or modify upstream sources. Distribution packaging remains future work.

Run the binding checks against an installed package with:

```sh
Rscript tests/binding.R
```
