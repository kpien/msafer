% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/map_safe.R
\name{check_match}
\alias{check_match}
\title{identified whether the user’s requirement existed within the dataset.}
\usage{
check_match(.data, ...)
}
\arguments{
\item{.data}{a dataframe}

\item{...}{Arguments passed to \code{\link[dplyr]{filter}}}
}
\value{
A logical vector
}
\description{
identified whether the user’s requirement existed within the dataset.
}
\examples{
if (require(dplyr)){
check_match(starwars, height == 172)
}
}
