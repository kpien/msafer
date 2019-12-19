#' @importFrom testthat test_that
#' @importFrom dplyr starwars
context("check_match")

test_that("checks import that exists in dataframe", {
  out <- check_match(mtcars, hp == 110)
  expect_equal(out, TRUE)
})

test_that("checks import that does not exist in dataframe", {
  out <- check_match(mtcars, carb == 0)
  expect_equal(out, FALSE)
})

