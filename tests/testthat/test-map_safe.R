context("map_safe")

#Create a list of dataframes
check_sample_a <- data.frame("SN" = 1:8, "Age" = c(2,8,85,100,15,60,55,68),
                             "Name" = c("John","Dora","Alice", "Kate", "Steve", "Amy", "Julia", "Yuliya"))
check_sample_b <- subset(check_sample_a, select = -c(SN))
check_sample_c <- data.frame()
check_list_sample <- list(check_sample_a, check_sample_b, mtcars, check_sample_c)

test_that("checks numeric and factor vectors in dataframe,
           & checks input with odd length", {
             out <- map_safe(check_sample_a, log)
             expect_equal(out$result, c(TRUE,FALSE))
             expect_equal(out$error_message, c("NA",
                                               "Error in Math.factor(x, base): ‘log’ not meaningful for factors\n"))
             expect_true(check_match(out[[3]][[1]], id == 2))
             expect_false(check_match(out[[3]][[2]], id == 2))
           }
)

test_that("checks dataframes with numeric variables,
           & checks input with even length", {
             out <- map_safe(check_list_sample, range)
             expect_equal(out$result, c(FALSE,TRUE))
             expect_equal(out$error_message, c("Error in FUN(X[[i]], ...): only defined on a data frame with all numeric variables\n",
                                               "NA"))
             expect_true(check_match(out[[3]][[1]], id == 2))
             expect_false(check_match(out[[3]][[2]], id == 1))
             expect_equal(nrow(out[[3]][[1]]), 3L)
           }
)

check_character <- "a"
check_double <- 1
test_that("checks input with length == 1 (character and double) using log transformation", {
  out_character <- map_safe(check_character, log)
  out_double <- map_safe(check_double, log)
  expect_equal(out_character$result, FALSE)
  expect_equal(out_double$result, TRUE)
  expect_equal(out_character$error_message, "Error in .Primitive(\"log\")(x, base): non-numeric argument to mathematical function\n")
  expect_equal(out_double$error_message, "NA")
  expect_true(check_match(out_character[[3]][[1]], id == 1))
  expect_false(check_match(out_double[[3]][[1]], id == 2))
}
)

test_that("checks different error message generating,
           & checks warning output", {
             out <- map_safe(check_list_sample,sapply,time_zone)
             expect_equal(out$result, c(FALSE,TRUE))
             expect_equal(out$error_message, c("Error in match.fun(FUN): object 'time_zone' not found\n",
                                               "simpleWarning in match.fun(FUN): restarting interrupted promise evaluation\n"))
             expect_true(check_match(out[[3]][[1]], id == 1))
             expect_true(check_match(out[[3]][[2]], id == 4))
           }
)

test_that("checks error message for incorrect input type", {
  out <- map_safe(log,mtcars)
  expect_equal(out$result, c(FALSE))
  expect_equal(out$error_message, "Error: Can't convert a `data.frame` object to function\n")
  expect_equal(nrow(out[[3]][[1]]), 1L)
}
)
