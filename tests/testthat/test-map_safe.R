#' @importFrom testthat test_that
#' @importFrom base integer
#' @importFrom dplyr starwars
#' @importFrom dplyr sample_n
context("map_safe")
test_that("checks numeric and factor vectors in dataframe,
           & checks input with odd length", {
             out <- map_safe(starwars[1:5], log)
             expect_equal(out$result, c(FALSE, TRUE))
             expect_equal(out$error_message, c("Error in .Primitive(\"log\")(x, base): non-numeric argument to mathematical function\n", "NA"))
             expect_true(check_match(out[[3]][[1]], id == 1))
             expect_false(check_match(out[[3]][[2]], id == 1))
           }
)
check_sample_a <- sample_n(starwars, 34)
check_sample_a <- subset(check_sample_a, elect = -c(height,hair_color))
check_sample_b <- sample_n(starwars, 35)
check_sample_c <- sample_n(mtcars, 20)
check_sample_c <- subset(check_sample_c, select = -c(hp))
check_sample_d <- tibble::tibble()
check_list_sample <- list(starwars, check_sample_a, check_sample_b, check_sample_c, mtcars, check_sample_d)
test_that("checks vectors that exists in few dataframes in a list of dataframe,
           & checks input with even length", {
             out <- map_safe(check_list_sample, select, height)
             expect_equal(out$result, c(TRUE,FALSE))
             expect_equal(out$error_message, c("NA","Error in .f(.x[[i]], ...): object 'height' not found\n"))
             expect_true(check_match(out[[3]][[1]], id == 3))
             expect_false(check_match(out[[3]][[2]], id == 3))
           }
)
check_character <- "a"
check_double <- 1
test_that("checks log function on a character or double,
           & checks input with length == 1", {
             out_character <- map_safe(check_character, log)
             out_double <- map_safe(check_double, log)
             expect_equal(out_character$result, FALSE)
             expect_equal(out_double$result, TRUE)
             expect_equal(out_character$error_message, "Error in .Primitive(\"log\")(x, base): non-numeric argument to mathematical function\n")
             expect_equal(out_double$error_message, "NA")
             expect_true(check_match(out_character[[3]][[1]], id == 1))
             expect_true(check_match(out[[3]][[1]], id == 1))
           }
)
test_that("checks warning created", {
  out <- map_safe(check_list_sample, abbreviate)
  expect_equal(out$result, c(TRUE,TRUE))
  expect_equal(out$error_message, c("simpleWarning in .f(.x[[i]], ...): abbreviate used with non-ASCII chars\n","NA"))
  expect_true(check_match(out[[3]][[1]], id == 1))
  expect_false(check_match(out[[3]][[2]], id == 2))
}
)
test_that("checks error message for incorrect input type", {
  out <- map_safe(log,mtcars)
  expect_equal(out$result, c(FALSE))
  expect_equal(out$error_message, "Can't convert a `data.frame` object to function")
  expect_equal(nrow(out[[3]][[1]]), 1L)
}
)
