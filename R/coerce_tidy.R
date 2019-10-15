
#' assumes `value` and `variable` columns
#' eav_to_tidy(eav_tiny)
#' @import rlang
eav_to_tidy <- function(data, id_cols = NULL) {

	id_cols <- enquo(id_cols)

	tidyr::pivot_wider(data,
										 id_cols = !!id_cols,
										 names_from = var,
										 values_from = value)

}

#' tidy_to_eav(eav_to_tidy(eav_tiny), eav_tiny)
#' @import dplyr
tidy_to_eav <- function(data, orig = NULL, id_cols = NULL) {

	col_names <- unique(orig$var)

	res <- tidyr::pivot_longer(data,
											cols = col_names,
											names_to = "var",
											values_to = "value")

	orig <- dplyr::select(orig, -value)

	semi_join(res, orig)

}
