
#' Filter an EAV tibble
#'
#' @param .data a tbl_eav
#' @param .c a single condition (to be replaced by dots...)
#' @param ... filter conditions
#' @export
#'
#' - Needs to recognize attribute column values as columns
#' - Needs to reorganize conditions based on attribute/value columns
#'
#' @examples
#' tinyeav %>% filter_eav(first == "John")
#'
#' tinyeav %>%
#'   filter(var == "first", value == "John") %>% {
#'   semi_join(tinyeav, ., by = "empid")
#'   }
#'
#' tinyeav %>% filter_eav(is.na(last))
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
#'
filter_eav <- function(.data, ...) {

	dots <- quos(...)

	cond <- enquo(.c)

	# need to recognize not just

}

