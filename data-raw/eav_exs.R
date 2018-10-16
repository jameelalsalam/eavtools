#put example data in package

library(tidyverse)

tiny <- readr::read_csv("data-raw/tiny.csv") %>%
	rlang::set_attrs("spec" = NULL)
usethis::use_data(tiny, overwrite = TRUE)

tinyeav <- tiny %>%
	eavtools::new_tbl_eav("empid", "var", "value")
usethis::use_data(tinyeav, overwrite = TRUE)
