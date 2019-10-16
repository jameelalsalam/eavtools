# reconstruct from tibbletime... until sloop is on CRAN?

#' @importFrom tibbletime reconstruct
#' @export
reconstruct.tbl_eav <- function(new, old) {

	# maybe check if subclassed/grouped?
	subclass <- NULL
	if(inherits(new, "grouped_df")) {
		subclass <- "grouped_tbl_eav"
	}

	new_tbl_eav(
		new,
		id_cols = attr(old, "id_cols"),
		variable_col = attr(old, "variable_col"),
		value_col = attr(old, "value_col")
	)
}
