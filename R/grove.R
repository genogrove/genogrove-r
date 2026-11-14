# All coordinates are upstream 0-based closed intervals.
genomic_coordinate <- function(strand, start, end) {
    .Call(`_genogrove_genomic_coordinate_new`, strand, start, end)
}

# The upstream default constructor uses order 3.
grove <- function(order = 3L) {
    .Call(`_genogrove_grove_new`, order)
}

insert_data <- function(grove, index, value, data) {
    .Call(`_genogrove_insert`, grove, index, value, data)
}

intersect <- function(grove, query, index = NULL) {
    .Call(`_genogrove_query_intersect`, grove, query, index)
}

get_keys <- function(result) .Call(`_genogrove_keys`, result)
get_query <- function(result) .Call(`_genogrove_query`, result)
get_value <- function(key) .Call(`_genogrove_value`, key)
get_data <- function(key) .Call(`_genogrove_data`, key)
get_order <- function(grove) .Call(`_genogrove_order`, grove)
get_start <- function(interval) .Call(`_genogrove_start`, interval)
get_end <- function(interval) .Call(`_genogrove_end`, interval)

get_strand <- function(coordinate) .Call(`_genogrove_coordinate_strand`, coordinate)
