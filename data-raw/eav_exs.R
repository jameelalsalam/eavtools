#put example data in package

library(tidyverse)

eav_tiny <- readr::read_csv("data-raw/tiny.csv") %>%
	rlang::set_attrs("spec" = NULL)
usethis::use_data(eav_tiny, overwrite = TRUE)

eav_emissions <- readr::read_csv("data-raw/emissions.csv") %>%
	rlang::set_attrs("spec" = NULL)
usethis::use_data(eav_emissions, overwrite = TRUE)

