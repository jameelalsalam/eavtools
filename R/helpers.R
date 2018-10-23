
#' Helper to replace empty lists
#'
`%|||%` <- function (x, y)
{
	if (is_empty(x)) {
		y
	}
	else {
		x
	}
}


#' Return the scalar of a vector
#'
#' @export
one <- function(x) {
	if (length(x) == 1) x else
		if (length(x) == 0) dplyr:::default_missing(x) else
			stop("Input `x` to `one` function must not have length > 1")

}

#' Return a single value from a vector, for which a different condition holds
#'
#' Intended to help with EAV calculations that potentially have length 0, ruining data frame operations.
#' @param x a vector from which to return results
#' @param p a vector of booleans (or other `[` indices?) length of x
#' @export
`%forwhich%` <- function(x, p) {
	one(x[p])
}
