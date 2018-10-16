

new_tbl_eav <- function(.data, entity_cols, attr_cols, val_cols) {
	# check types of inputs? Or not even?

	tibble::new_tibble(.data,
										 entity_cols = entity_cols,
										 attr_cols = attr_cols,
										 val_cols = val_cols,

										 subclass = "tbl_eav")

}

#' Make an EAV tibble out of a regular tibble
#'
#' @param .data starting tibble in EAV format
#' @param entity_cols specification of columns which represent entities
#' @param attr_cols spec of columns which represent attributes
#' @param val_cols spec of columns which represent values
#'
#' Columns may be specified using character vectors or tidyselect semantics.
#' @export
tbl_eav <- function(.data, entity_cols, attr_cols, val_cols) {
	stop("not impl")
}
