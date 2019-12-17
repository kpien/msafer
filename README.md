
<!-- README.md is generated from README.Rmd. Please edit that file -->

# msafer

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/msafer)](https://CRAN.R-project.org/package=msafer)
[![Build
Status](https://travis-ci.com/kpien/msafer.svg?branch=master)](https://travis-ci.com/kpien/msafer)
<!-- badges: end -->

**msafer** is a package that frees users from having to manually find
the location of an error when using the function `map()`. When there’s
something wrong with `map()`, the function only returns the error, but
where this error occurs is not provided. The function `map_safe()` takes
in a vector, function and requirements, and spits out `TRUE` or `FALSE`
based on whether an error occurs when running the function over the
vector. `map_safe()` will return a list of logical returns where it will
be easy to identify the place of the error.

## Installation

You can install the development version of msafer from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("kpien/msafer")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(msafer)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub\!
