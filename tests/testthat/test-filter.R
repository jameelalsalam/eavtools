
library(tidyverse)
library(eavtools)

test_that("filter works", {

	n_Smith <- eav_tiny %>%
		group_by(empid) %>%
		filter_eav(lu("last") == "Smith") %>%
		pull(empid) %>% n_distinct()

	expect_equal(n_Smith, 1)

})
