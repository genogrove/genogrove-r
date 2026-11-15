\name{grove}
\alias{grove}
\alias{genomic_coordinate}
\alias{get_strand}
\alias{insert_data}
\alias{intersect}
\alias{get_keys}
\alias{get_query}
\alias{get_value}
\alias{get_data}
\alias{get_order}
\alias{get_start}
\alias{get_end}
\title{Native genogrove interval bindings}
\description{Direct bindings to upstream interval groves with string payloads.
Coordinates are 0-based closed. Algorithms and defaults are supplied by upstream.}
\usage{
grove(order = 3L)
genomic_coordinate(strand, start, end)
insert_data(grove, index, value, data)
intersect(grove, query, index = NULL)
get_keys(result)
get_query(result)
get_value(key)
get_data(key)
get_order(grove)
get_start(interval)
get_end(interval)
get_strand(coordinate)
}
\arguments{
\item{strand}{One of +, -, ., or *. Wildcard * matches every strand; . matches only . or *.}
\item{coordinate}{A native genomic coordinate object.}
\item{order}{Upstream tree order, an integer at least 3.}
\item{start, end}{Non-negative integer coordinates exactly representable in R and native size_t.}
\item{grove}{A native grove object.}
\item{index}{One non-missing string; NULL searches all indices in intersect.}
\item{value, query, interval}{A native genomic coordinate object.}
\item{data}{One non-missing string payload.}
\item{result}{A query result.}
\item{key}{A key returned by insertion or query.}
}
\value{Constructors return native external pointers. Insertion returns a key;
intersection returns a query result. get_keys returns a list of key handles.
get_query and get_value return genomic coordinate copies. Other getters return scalar values.}
\details{Key and result handles retain their owners. Native objects cannot be
restored using R serialization; upstream serialization is not yet exposed.}
