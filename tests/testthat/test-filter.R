
library(tidyverse)
library(eavtools)

test_that("filter works on std and tbl_eav versions of eav_tiny", {

	n_Smith <- eav_tiny %>%
		group_by(empid) %>%
		filter_eav(lu("last") == "Smith") %>%
		pull(empid) %>% n_distinct()

	expect_equal(n_Smith, 1)

	eav <- tbl_eav(eav_tiny)

	n_Smith_2 <- eav %>%
		group_by(empid) %>%
		filter_eav(lu("last") == "Smith") %>%
		pull(empid) %>% n_distinct()

	expect_equal(n_Smith_2, 1)

})
