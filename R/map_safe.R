# another function: if map_safe_merge returns all TRUE, else different behaviors: only return good results
#' Determine if you can apply a function to a vector without errors.
#' @param .x Vector of paths to csvs
#' @param f Function that's being applied to the dataset
#' @param ... Arguments passed to \code{\link{map}}
#' @return A logical vector
#' @importFrom dplyr bind_rows
#' @importFrom tibble tibble
#' @export
#' @examples
#' if (require(dplyr)){
#' map_safe_merge(list(starwars, sample_n(mtcars, 1:20), sample_n(mtcars, 1:20)), select, height)
#' }

map_safe_merge <- function(.x, f, ...) {
  if (length(.x) == 1) {
    #if there is one row in .x: get and return the row number
    a <- tryCatch(
      {
        #This is the try part
        purrr::map(.x, f, ...)
        tibble(result=TRUE, error_message= "NA")
      },
      error = function(e) {
        message("Something went wrong")
        message("Here's the original error message")
        e <- as.character(e)
        return(tibble(result=FALSE, error_message= e))
      },
      warning=function(w) {
        message("Here's the original warning message:")
        # Choose a return value in case of warning
        w <- as.character(w)
        return(tibble(result=TRUE, error_message= w))
      }
    )
    return(a)
  }
  else {
    a <- .x[1:floor(length(.x)/2)] #first half of .x
    b <- .x[(floor(length(.x)/2)+1):length(.x)] #second half of .x
    return(bind_rows(map_safe_merge(a, f, ...), map_safe_merge(b, f, ...)))
  }
}

#' identified whether the user’s requirement existed within the dataset.
#' @param .data a dataframe
#' @param ... Arguments passed to \code{\link[dplyr]{filter}}
#' @return A logical vector
#' @importFrom dplyr %>%
#' @export
#' @examples
#' if (require(dplyr)){
#' check_match(starwars, height == 172)
#' }
check_match <- function(.data, ...){
  # Using `dplyr::filter()` to get the rows that matches the user's need and store them into row.
  row <- .data %>%
    dplyr::filter(...)%>%
    # Count the number of rows that matches the user's need.
    nrow()
  # Return TRUE if the rows that matches the need is greater than 0, else return FALSE
  isTRUE(row > 0)
}

#' Return a tibble that contains the message generated from map_safe_merge
#' @param .x a vector
#' @param f Function that's being applied to the dataset
#' @param ... Arguments passed to \code{\link{map_safe_merge}}
#' @return A tibble
#' @importFrom dplyr %>%
#' @importFrom dplyr mutate
#' @importFrom dplyr row_number
#' @importFrom tidyr nest
#' @export
#' @examples
#' if (require(dplyr)){
#' map_safe(list(starwars, sample_n(mtcars, 1:20), sample_n(mtcars, 1:20)), select, height)
#' }
map_safe <- function(.x, f, ...) {
  # put the result of map_safe_merge into a tibble called original
  original<-map_safe_merge(.x, f, ...) %>%
    #generate the row index for tibble original
    mutate(id = row_number())
  # order tibble original based on error_message and result
  nest(original, which_id = id)
}



