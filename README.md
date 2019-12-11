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

When running the function `map()`, `map_safe()` helps determine where the error occurs. It takes in the same arguments as `map()`, splits the vector recursively until it finds the error line, and returns `FALSE` right where the error occurs. 


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

# a list of dataframes, with myfiles[[1]], myfiles[[2]], myfiles[[4]] being empty dataframes
map_safe(myfiles, select, pO2)
[1] FALSE FALSE TRUE FALSE TRUE  TRUE  TRUE  TRUE   TRUE  TRUE  TRUE
```
## Getting Help
This is a very brief explanation of the msafer package, for more instruction please visit the vignette for this package (in progress). 
