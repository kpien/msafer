# another function: if map_safe returns all TRUE, else different behaviors: only return good results
#' Determine if you can apply a function to a vector without errors.
#' @param .x Vector of paths to csvs
#' @param f Function that's being applied to the dataset
#' @param ... Arguments
#' @return A logical vector
#' @example map_safe(iris$Sepal.Length, log)

map_safe <- function(.x, f, ...) {

  if (length(.x) == 1) {
    # if there is one row in .x: get and return the row number
    tryCatch(
      # if this does not return an error, return TRUE:
      error = function(e) {
        FALSE
      }, {
        walk(.x, f, ...)
        TRUE
      }
    )
  }
  else {
    # else, slice and run map_safe on each half
    a <- split(.x, c(1, 2))$`1` #first half of .x
    b <- split(.x, c(1, 2))$`2` #second half of .x
    return(c(map_safe(a, f, ...), map_safe(b, f, ...)))
  }
}
