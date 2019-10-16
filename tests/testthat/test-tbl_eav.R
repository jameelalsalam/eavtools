library(tidyverse)


test_that("convenience contructor correctly guesses columns for example data", {
  eav_tiny <- tbl_eav(eav_tiny)
  expect_equal(attr(eav_tiny, "id_cols"), "empid")
  expect_equal(attr(eav_tiny, "variable_col"), "var")
  expect_equal(attr(eav_tiny, "value_col"), "value")
})
