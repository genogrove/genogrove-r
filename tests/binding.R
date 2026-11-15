library(genogrove)

g <- grove()
stopifnot(get_order(g) == 3L)
k <- insert_data(g, "chr1", genomic_coordinate("*", 0, 10), "first")
insert_data(g, "chr1", genomic_coordinate("*", 11, 20), "second")
insert_data(g, "chr2", genomic_coordinate("*", 10, 10), "other")
r <- intersect(g, genomic_coordinate("*", 10, 10), "chr1")
stopifnot(identical(vapply(get_keys(r), get_data, ""), "first"))
stopifnot(length(get_keys(intersect(g, genomic_coordinate("*", 10, 10)))) == 2L)
stopifnot(length(get_keys(intersect(g, genomic_coordinate("*", 0, 20), "missing"))) == 0L)
stopifnot(get_start(get_query(r)) == 10, get_end(get_value(k)) == 10)

# Query keys retain result -> grove; insertion keys retain grove directly.
hit <- get_keys(r)[[1]]
rm(g, r)
gc()
stopifnot(get_data(hit) == "first", get_data(k) == "first")

fails <- function(expr) inherits(tryCatch(force(expr), error = identity), "error")
stopifnot(fails(genomic_coordinate("*", 10, 0)), fails(genomic_coordinate("*", -1, 0)),
          fails(genomic_coordinate("*", NA_real_, 0)), fails(genomic_coordinate("*", 0.5, 1)),
          fails(grove(2)), fails(get_data(genomic_coordinate("*", 0, 0))))

# Exercise upstream strand compatibility, including wildcard on either side.
g <- grove()
for (strand in c("+", "-", ".", "*"))
    insert_data(g, "chr1", genomic_coordinate(strand, 10, 20), strand)
for (strand in c("+", "-", ".", "*")) {
    r <- intersect(g, genomic_coordinate(strand, 20, 30), "chr1")
    expected <- if (strand == "*") c("+", "-", ".", "*") else c(strand, "*")
    stopifnot(identical(sort(vapply(get_keys(r), get_data, "")), sort(expected)),
              get_strand(get_query(r)) == strand)
    for (key in get_keys(r)) stopifnot(get_strand(get_value(key)) == get_data(key))
}
stopifnot(fails(genomic_coordinate("x", 0, 1)),
          fails(genomic_coordinate("++", 0, 1)),
          fails(genomic_coordinate(NA_character_, 0, 1)))

# Compare results against closed-interval arithmetic over many tree splits.
set.seed(42)
g <- grove(3)
starts <- sample(0:1000, 250, replace = TRUE)
ends <- starts + sample(0:100, 250, replace = TRUE)
for (i in seq_along(starts))
    insert_data(g, "chr1", genomic_coordinate("*", starts[i], ends[i]), as.character(i))
for (i in seq_len(50)) {
    a <- sample(0:1000, 1)
    b <- a + sample(0:100, 1)
    actual <- as.integer(vapply(get_keys(intersect(g, genomic_coordinate("*", a, b), "chr1")), get_data, ""))
    stopifnot(identical(sort(actual), which(starts <= b & ends >= a)))
}
