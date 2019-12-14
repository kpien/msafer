# another function: if map_safe returns all TRUE, else different behaviors: only return good results
#' Determine if you can apply a function to a vector without errors.
#' @param .x Vector of paths to csvs
#' @param f Function that's being applied to the dataset
#' @param ... Arguments passed to \code{\link{map}}
#' @return A logical vector
#' @example map_safe(iris$Sepal.Length, log)

map_safe <- function(.x, f, ...) {
  #.x: vector of paths to csvs
  #f: function that's being applied to the dataset
  #... arguments
  if (length(.x) == 1) {
    #if there is one row in .x: get and return the row number
    a <- tryCatch(
      {
        #This is the try part
        purrr::map(.x, f, ...)
        TRUE
      },
      error = function(e) {
        message("Something went wrong")
        message("Here's the original error message")
        message(e)
        return(FALSE)
      },
      warning=function(w) {
        message("Here's the original warning message:")
        message(w)
        # Choose a return value in case of warning
        return(TRUE)
      }
    )
    return(a)
  }
  else {
    #else, slice and run map_safe on each half
    a <- .x[1] # Take the first element in the vector
    b <- .x[2:length(.x)] # the remaining elements went through the recursion again
    return(c(map_safe(a, f, ...), map_safe(b, f, ...)))
  }
}

#' identified whether the user’s requirement existed within the dataset.
#' if yes, then the function will return true, if not, it returns false.
#' @param .data a dataframe
#' @param ... Arguments passed to \code{\link{map}}
#' @return A logical vector
#' @example check_match(starwars, height == 172)
check_match <- function(.data, ...){
  # Using `dplyr::filter()` to get the rows that matches the user's need and store them into row.
  row <- .data %>%
    dplyr::filter(...)%>%
    # Count the number of rows that matches the user's need.
    nrow()
  # Return TRUE if the rows that matches the need is greater than 0, else return FALSE
  isTRUE(row > 0)
}

