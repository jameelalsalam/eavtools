
#' Filter an EAV tibble
#'
#' @param .data a tbl_eav
#' @param .c a single condition (to be replaced by dots...)
#' @param ... filter conditions
#' @export
#'
#' 1) First strategy: pivot to a 'tidy' df, then filter, then go back.
#' 2) Operate on the groups, using summarize to find groups to keep
#'
#'
#'
#' @examples
#' eav_tiny %>% group_by(empid) %>% filter_eav(lu("first") == "John")
#'
#' eav_tiny %>% filter_eav(is.na(last))
#'
#' # only gets explicit NA
#' tinyeav %>%
#'   filter(var == "last", is.na(value)) %>% {
#'   semi_join(tinyeav, ., by = "empid")
#'   }
#'
#' # reversing the condition specially for NA
#' tinyeav %>%
#'   filter(var == "last", !is.na(value)) %>% {
#'   anti_join(tinyeav, ., by = "empid")}
#'
#' # or first make missing data explicit
#' tinyeav %>%
#'   complete(nesting(empid), nesting(var)) %>%
#'   filter(var == "last", is.na(value)) %>% {
#'   semi_join(tinyeav, ., by = "empid")}
#'
#' # or tidy first (this version makes it explicit)
#' tinyeav %>%
#'   spread(var, value) %>%
#'   filter(is.na(last)) %>%
#'   gather("var", "value", -empid) %>%
#'   arrange(empid)
#'
#' # multiple conditions
#' tinyeav %>%
#'   filter_eav(first == "John" & last == "Smith")
#'
#' tinyeav %>%
#'   group_by(empid) %>%
#'   summarize(include_row =
#'   						any(var == "first" & value == "John") &
#'   						any(var == "last" & value == "Smith")) %>%
#'   filter(include_row) %>% {
#'   semi_join(tinyeav, ., by = "empid")}
#'
#'
#' @export
filter_eav <- function(.data, ...) {
	UseMethod("filter_eav")
}

#' @export
filter_eav.default <- function(.data, ...) {
	dots <- enexprs(...)

	dots <- map(dots, ~recurse_rewrite(.x))

	res <- dplyr::filter(.data, !!!dots)

	res
}

#' @export
filter_eav.tbl_eav <- function(.data, ...) {

	newdata <- NextMethod()

	res <- reconstruct(newdata, .data)

	res
}

# old strategy: transform to tidy, then eval
# problem with old strategy: not clear *what* tidy is necessary. That's part of why we are in EAV format.
filter_eav2 <- function(.data, ...) {

	t_data <- eav_to_tidy(.data)

	t_data_filtered <- dplyr::filter(t_data, ...)

	res <- tidy_to_eav(t_data_filtered, orig = .data)

	res
}



