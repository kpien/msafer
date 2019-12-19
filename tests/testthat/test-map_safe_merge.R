context("map_safe_merge")

#Create a list of dataframes
check_sample_a <- data.frame("SN" = 1:8, "Age" = c(2,8,85,100,15,60,55,68),
                             "Name" = c("John","Dora","Alice", "Kate", "Steve", "Amy", "Julia", "Yuliya"))
check_sample_b <- subset(check_sample_a, select = -c(SN))
check_sample_c <- data.frame()
check_list_sample <- list(check_sample_a, check_sample_b, mtcars, check_sample_c)

test_that("checks numeric and factor vectors in dataframe,
           & checks input with odd length", {
             out <- map_safe_merge(check_sample_a, log)
             expect_equal(out$result, c(TRUE, TRUE, FALSE))
             expect_equal(out$error_message[[1]],out$error_message[[2]])
             expect_false(out$error_message[[1]] == out$error_message[[3]])
           }
)

test_that("checks dataframes with numeric variables,
           & checks input with even length",{
             out <- map_safe_merge(check_list_sample, range)
             expect_equal(out$result, c(FALSE,FALSE,TRUE,FALSE))
             expect_equal(out$error_message[[1]],out$error_message[[2]],out$error_message[[4]])
             expect_false(out$error_message[[1]] == out$error_message[[3]])
             }
)

check_character <- "a"
check_double <- 1
test_that("checks input with length == 1 (character and double)", {
  out_character <- map_safe_merge(check_character, log)
  out_double <- map_safe_merge(check_double, log)
  expect_equal(out_character$result, FALSE)
  expect_equal(out_double$result, TRUE)
  expect_false(out_character$error_message == out_double$error_message)
}
)

test_that("checks different error message generating,
           & checks warning output",{
             out <- map_safe_merge(check_list_sample,sapply,time_zone)
             expect_equal(out[[1]][[2]],TRUE)
             expect_false(out[[2]][[2]] == "NA")
             expect_equal(out$error_message[[3]],out$error_message[[4]])
             expect_false(out$error_message[[1]] == out$error_message[[2]])
             }
          )

test_that("checks error message for incorrect input type", {
  out <- map_safe_merge(log,mtcars)
  expect_equal(out$result, FALSE)
  expect_false(out$error_message == "NA")
}
)
