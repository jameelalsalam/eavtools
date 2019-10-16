# lookup

#' Lookup a an EAV value-variable pair when inside a tidyeval context
#'
#' @export
#' @examples
#' eav_tiny %>% group_by(empid) %>% mutate(last = lu("last"))
#' eav_tiny %>% group_by(empid) %>% filter_eav(lu("last") == "Smith")
lu <- function(varname) {
	e <- expr((value[var == !!varname] %0% vctrs::vec_init(value)))
}

lu_eval <- function(varname) {
	e <- expr(value %forwhich% (var == !!varname))
	eval_tidy(e, env = caller_env())
}
