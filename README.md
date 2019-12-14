[![Build Status](https://travis-ci.com/kpien/msafer.svg?branch=master)](https://travis-ci.com/kpien/msafer)

# msafer
By Lily Jin, Carol Liu, Kelly Pien

msafer is a package that frees users from having to manually find the location of an error when using the function `map()`. When there’s something wrong with `map()`, the function only returns the error, but where this error occurs is not provided. The function `msafer()` takes in a vector, function and requirements, and spits out `TRUE` or `FALSE` based on whether an error occurs when running the function over the vector. `msafer()` will return a list of logical returns where it will be easy to identify the place of the error. 

## Installation

[Install](https://github.com/kpien/msafer) the package using:

``` r
# install.packages("devtools")
devtools::install_github("kpien/msafer")
```

## Usage

When running the function `map()`, `map_safe()` helps determine where the error occurs. It takes in the same arguments as `map()`, splits the vector recursively until it finds the error line, and returns `FALSE` right where the error occurs. `file_good()` identified whether the user’s requirement existed within the dataset/list of dataframes, if yes, then the function will return `TRUE`, if not, it returns `FALSE`.


## Example

``` r
library(msafer)
map_safe(starwars$height, log)
[1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
[14] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
[27] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
[40] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
[53] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
[66] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
[79] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE

map_safe(starwars$names, log)
[1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[12] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[23] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[34] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[45] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[56] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[67] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[78] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE

check_match(starwars, height == 172)
[1] TRUE

sample_a <- sample_n(starwars, 34)
sample_b <- sample_n(mtcars, 1:20)
a <- list(starwars, sample_a, sample_b)
map_safe(a, select, height)
[1]  TRUE  TRUE FALSE

# a list of 11 dataframes, with myfiles[[1]], myfiles[[2]], myfiles[[4]] being empty dataframes
map_safe(myfiles, select, pO2)
[1] FALSE FALSE TRUE FALSE TRUE  TRUE  TRUE  TRUE   TRUE  TRUE  TRUE

# the same list of dataframes, but I took off pO2 from the 8th dataframe
map_safe(myfiles, select, pO2)
[1] FALSE FALSE TRUE FALSE  TRUE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE

map_safe(myfiles, check_match, height==0)
[1] TRUE TRUE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE

sample_a <- sample_n(starwars, 34)
sample_b <- sample_n(starwars, 35:87)
sample <- list(starwars, sample_a, sample_b)

map_lgl(sample, check_match,  height == 172)
[1]  TRUE FALSE FALSE
```
## Getting Help
This is a very brief explanation of the msafer package, for more instruction please visit the vignette for this package (in progress). 
