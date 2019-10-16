
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
tbl_eav <- function(.data, id_cols, variable_col, value_col) {
	stop("not impl")
}
