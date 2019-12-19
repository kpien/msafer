
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
the location of an error when using the function `map()`. When `map()`
returns an error, it’s unclear where this error occurs. The function
`map_safe()` takes in a vector, function and requirements, and spits out
`TRUE` or `FALSE` based on whether an error occurs when running the
function over the vector. `map_safe()` will return a list of logical
returns where it will be easy to identify the place of the error.

## Installation

You can install the development version of msafer from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("kpien/msafer")
#> Skipping install of 'msafer' from a github remote, the SHA1 (1cc53879) has not changed since last install.
#>   Use `force = TRUE` to force installation
```

## Example

For demonstration purposes, let’s create a sample list of dataframes
from the `starwars` and `mtcars` datasets.

``` r
sample_a <- dplyr::sample_n(dplyr::starwars, 34)
sample_a <- subset(sample_a, select = -c(height,hair_color))
sample_b <- dplyr::sample_n(dplyr::starwars, 35)
sample_c <- dplyr::sample_n(mtcars, 20)
sample_c <- subset(sample_c, select = -c(hp))
sample_d <- tibble::tibble()
list_sample <- list(dplyr::starwars, sample_a, sample_b, sample_c, mtcars, sample_d)
```

Pass `map_safe_merge()` the same arguments as `map()`. These would be
the list of dataframes, the function to map over all the dataframes, and
any arguments that the function needs. `map_safe_merge()` will return a
tibble with the file numbers and any errors that may have occurred while
trying to apply `map()`, grouping repeat errors together.

``` r
library(msafer)
map_safe_merge(list_sample, dplyr::select, height)
#> # A tibble: 6 x 2
#>   result error_message                                           
#>   <lgl>  <chr>                                                   
#> 1 TRUE   NA                                                      
#> 2 FALSE  "Error in .f(.x[[i]], ...): object 'height' not found\n"
#> 3 TRUE   NA                                                      
#> 4 FALSE  "Error in .f(.x[[i]], ...): object 'height' not found\n"
#> 5 FALSE  "Error in .f(.x[[i]], ...): object 'height' not found\n"
#> 6 FALSE  "Error in .f(.x[[i]], ...): object 'height' not found\n"
```

However, if the vector is huge, then the result would be messy and hard
to grab information from the tibble. Thus, we can use `map_safe()` which
nests the error message, and returns a tibble that contains only the
unique error message and the index locating where the error occurs
within the vector.

``` r
sample_df <- map_safe(list_sample, dplyr::select, height)
sample_df
#> # A tibble: 2 x 3
#>   result error_message                                                  which_id
#>   <lgl>  <chr>                                                    <list<df[,1]>>
#> 1 TRUE   NA                                                              [2 × 1]
#> 2 FALSE  "Error in .f(.x[[i]], ...): object 'height' not found\n"        [4 × 1]
```

`check_match()` identified whether the user’s requirement existed within
the dataset/list of dataframes, if yes, then the function will return
TRUE, if not, it returns FALSE.

``` r
check_match(dplyr::starwars, height == 172)
#> [1] TRUE
```

`check_match()` and also be used under `map_safe()` when applying
check\_match() to a vector which could contain multiple elements

``` r
d <- map_safe(list_sample, check_match,  height == 172)
d
#> # A tibble: 2 x 3
#>   result error_message                                                 which_id
#>   <lgl>  <chr>                                                   <list<df[,1]>>
#> 1 TRUE   NA                                                             [3 × 1]
#> 2 FALSE  "Error: Evaluation error: object 'height' not found.\n"        [3 × 1]
```

## Developed By

  - [Sifan(Carol) Liu](https://github.com/CarolLiuSifan)
  - [Kelly Pien](https://github.com/kpien)
  - [Huiqing(Lily) Jin](https://github.com/Lilyyyy54)
