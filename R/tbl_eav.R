
#' @export
new_tbl_eav <- function(.data, id_cols, variable_col, value_col) {
	# check types of inputs? Or not even?

	tibble::new_tibble(.data,
										 id_cols = id_cols,
										 variable_col = variable_col,
										 value_col = value_col,

										 subclass = "tbl_eav")

}

#' Make an EAV tibble out of a regular tibble
#'
#' @param .data starting tibble in EAV format
#' @param id_cols specification of columns which represent entities
#' @param variable_col spec of column which represent variable names
#' @param value_col spec of column which represent values
#'
#' Columns may be specified using character vectors or (hopefully) tidyselect semantics.
#' @export
tbl_eav <- function(.data,
										id_cols = NULL,
										variable_col = c("variable", "var"),
										value_col = "value") {
	id_cols <- as.character(id_cols)
	variable_col <- as.character(variable_col)
	value_col <- as.character(value_col)

	variable_col <- intersect(names(.data), variable_col)
	value_col <- intersect(names(.data), value_col)

	if(is_empty(variable_col)) stop("No variable column found in EAV data.")
	if(is_empty(value_col)) stop("No variable column found in EAV data.")

	if(is_empty(id_cols)) {
		id_cols <- setdiff(names(.data), c(variable_col, value_col))
	}

	new_tbl_eav(
		.data = .data,
		id_cols = id_cols,
		variable_col = variable_col,
		value_col = value_col
	)
}
