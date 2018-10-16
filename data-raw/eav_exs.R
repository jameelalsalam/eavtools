#put example data in package

tiny <- readr::read_csv("data-raw/tiny.csv") %>%
	rlang::set_attrs("spec" = NULL)
usethis::use_data(tiny, overwrite = TRUE)
