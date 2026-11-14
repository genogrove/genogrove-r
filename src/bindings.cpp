#include <Rcpp.h>
#include <cmath>
#include <genogrove/data_type/genomic_coordinate.hpp>
#include <genogrove/structure/grove/grove.hpp>

using Coordinate = genogrove::data_type::genomic_coordinate;
using Grove = genogrove::structure::grove<Coordinate, std::string>;
using Key = genogrove::data_type::key<Coordinate, std::string>;
using Result = genogrove::data_type::query_result<Coordinate, std::string>;

template<class T> T* checked(SEXP x, const char* cls) {
    if (TYPEOF(x) != EXTPTRSXP || !Rf_inherits(x, cls) ||
        R_ExternalPtrAddr(x) == nullptr)
        Rcpp::stop("Expected a live %s object", cls);
    return static_cast<T*>(R_ExternalPtrAddr(x));
}

template<class T> SEXP owned(T* value, const char* cls, SEXP owner = R_NilValue) {
    Rcpp::XPtr<T> ptr(value, true, R_NilValue, owner);
    ptr.attr("class") = cls;
    return ptr;
}

SEXP key_handle(Key* key, SEXP owner) {
    Rcpp::XPtr<Key> ptr(key, false, R_NilValue, owner);
    ptr.attr("class") = "genogrove_key";
    return ptr;
}

std::string scalar_string(SEXP x) {
    if (TYPEOF(x) != STRSXP || Rf_xlength(x) != 1 || STRING_ELT(x, 0) == NA_STRING)
        Rcpp::stop("Expected one non-missing string");
    return Rcpp::as<std::string>(x);
}

size_t position(SEXP x) {
    if (!Rf_isNumeric(x) || Rf_xlength(x) != 1) Rcpp::stop("Expected one numeric coordinate");
    double n = Rcpp::as<double>(x);
    // R doubles cannot represent every integer beyond 2^53 - 1.
    if (!std::isfinite(n) || n < 0 || n > 9007199254740991.0 || std::floor(n) != n ||
        static_cast<long double>(n) > static_cast<long double>(SIZE_MAX))
        Rcpp::stop("Coordinate must be an exact non-negative integer representable by R and size_t");
    return static_cast<size_t>(n);
}

// [[Rcpp::export(name = "genomic_coordinate_new")]]
SEXP genomic_coordinate_new(SEXP strand, SEXP start, SEXP end) {
    auto s = scalar_string(strand);
    if (s.size() != 1) Rcpp::stop("Strand must be one character");
    return owned(new Coordinate(s[0], position(start), position(end)), "genogrove_genomic_coordinate");
}

// [[Rcpp::export(name = "grove_new")]]
SEXP grove_new(SEXP order) {
    auto n = position(order);
    if (n > INT_MAX) Rcpp::stop("Order exceeds the upstream integer range");
    return owned(new Grove(static_cast<int>(n)), "genogrove_grove");
}

// [[Rcpp::export(name = "insert")]]
SEXP insert(SEXP grove, SEXP index, SEXP value, SEXP data) {
    auto* g = checked<Grove>(grove, "genogrove_grove");
    auto* v = checked<Coordinate>(value, "genogrove_genomic_coordinate");
    auto* k = g->insert_data(scalar_string(index), *v, scalar_string(data));
    return key_handle(k, grove);
}

// [[Rcpp::export]]
SEXP query_intersect(SEXP grove, SEXP query, SEXP index) {
    auto* g = checked<Grove>(grove, "genogrove_grove");
    auto* q = checked<Coordinate>(query, "genogrove_genomic_coordinate");
    auto result = index == R_NilValue ? g->intersect(*q) : g->intersect(*q, scalar_string(index));
    return owned(new Result(std::move(result)), "genogrove_query_result", grove);
}

// [[Rcpp::export(name = "keys")]]
SEXP keys(SEXP result) {
    auto* r = checked<Result>(result, "genogrove_query_result");
    Rcpp::List out(r->get_keys().size());
    for (size_t i = 0; i < r->get_keys().size(); ++i)
        out[i] = key_handle(r->get_keys()[i], result);
    return out;
}

// [[Rcpp::export(name = "query")]]
SEXP query(SEXP result) {
    return owned(new Coordinate(checked<Result>(result, "genogrove_query_result")->get_query()), "genogrove_genomic_coordinate");
}

// [[Rcpp::export(name = "value")]]
SEXP value(SEXP key) {
    return owned(new Coordinate(checked<Key>(key, "genogrove_key")->get_value()), "genogrove_genomic_coordinate");
}

// [[Rcpp::export(name = "data")]]
std::string data(SEXP key) { return checked<Key>(key, "genogrove_key")->get_data(); }

// [[Rcpp::export(name = "order")]]
int order(SEXP grove) { return checked<Grove>(grove, "genogrove_grove")->get_order(); }

// [[Rcpp::export(name = "start")]]
double start(SEXP interval) { return checked<Coordinate>(interval, "genogrove_genomic_coordinate")->get_start(); }

// [[Rcpp::export(name = "end")]]
double end(SEXP interval) { return checked<Coordinate>(interval, "genogrove_genomic_coordinate")->get_end(); }

// [[Rcpp::export]]
std::string coordinate_strand(SEXP coordinate) {
    return std::string(1, checked<Coordinate>(coordinate, "genogrove_genomic_coordinate")->get_strand());
}
