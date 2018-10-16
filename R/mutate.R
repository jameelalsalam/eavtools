
#' Mutate an EAV table (e.g., add/modify rows)
#'
#' @param .data
#' @param ...
#'
#' @export
#' @examples
#' tinyeav %>%
#'   mutate_eav(middle = "Ramsey")
#'
#' tinyeav %>%
#'   group_by(empid) %>%
#'   summarize(var = "middle",
#'             value = "Ramsey") %>% {
#'     bind_rows(tinyeav, .)}
#'
#' tinyeav %>%
#'   mutate_eav(middle = if_else(first == "John", "Ramsey", middle))
#'
#' tinyeav %>%
#'   group_by(empid) %>%
#'   summarize(middle = if_else(any(var == "first" & value == "John"), "Ramsey", lookup(value, var == "middle") ))
#'
mutate_eav <- function(.data, ...) {
	dots <- quos(...)

}
