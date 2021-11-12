library(datateachr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(tibble)

test_that("Test function for type/class of output", {
  expect_type((summarize_stats(vancouver_trees, root_barrier, diameter)), "list")
  expect_s3_class((summarize_stats(vancouver_trees, root_barrier, diameter)[[1]]), "tbl_df")
  expect_s3_class((summarize_stats(vancouver_trees, root_barrier, diameter)[[2]]), "ggplot")
})

test_that("Test for dimensions and column names of summary tibble item", {
  expect_equal(dim(summarize_stats(vancouver_trees, root_barrier, diameter)[[1]]), c(2,6))
  expect_named((summarize_stats(vancouver_trees, root_barrier, diameter)[[1]][,2:6]),
               c("minimum", "maximum", "mean", "quantile_1", "quantile_2"))
})

test_that("Test for expected error messages for invalid arguments", {
  expect_error(summarize_stats(vancouver_trees, root_barrier, genus_name),
               "The parameter numeric_var requires a numerical variable.\nYou have input a variable of class: character")
  expect_error(summarize_stats(vancouver_trees, height_range_id, diameter),
               "The parameter categoric_var requires a character or factor variable.\nYou have input a variable of class: numeric")
})

van_trees_3 <- vancouver_trees %>%
  mutate(dbh = na_if(diameter, 0))

test_that("Test that NA handling works", {
  expect_error(summarize_stats(van_trees_3, root_barrier, dbh, na.rm = FALSE))
})

rm(van_trees_3)
