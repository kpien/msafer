# map_safe
By Lily Jin, Carol Liu, Kelly Pien

msafer is a package designed to help user free themselves from manually check the location of error when using the function `Map()`. When there's something wrong with`map()`, it only returns the error, but where this error occurs are not provided. msafer takes your vector, function and requirements, and spit out `TURE` or `FALSE` based on whether an error occurs when running the function over the vector. msafer will return a list of logical returns where it will be easy to identify the place of the error. 

## Installation

[Install](https://github.com/kpien/msafer) the package using:

``` r
# install.packages("devtools")
devtools::install_github("kpien/msafer")
```

## Usage

`map_safe()` helps to distinguish where the error occurs when we are running the function `map()`, thus it takes in all the arguments that `map()` takes in, split the vector recursively until it find the error line, and returns false right where the error occurs. 

``` r
library(msafer)

```






