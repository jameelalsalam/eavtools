


expr_type <- function(x) {
	if (rlang::is_syntactic_literal(x)) {
		"constant"
	} else if (is.symbol(x)) {
		"symbol"
	} else if (is.call(x)) {
		"call"
	} else if (is.pairlist(x)) {
		"pairlist"
	} else {
		typeof(x)
	}
}

switch_expr <- function(x, ...) {
	switch(expr_type(x),
				 ...,
				 stop("Don't know how to handle type ", typeof(x), call. = FALSE)
	)
}

# recurse_rewrite(expr(lu("hello")))
recurse_rewrite <- function(x) {
	switch_expr(x,
							# Base cases
							symbol = x,
							constant = x,

							# Recursive cases
							call = call_rewrite(x),
							pairlist = x
	)
}

# call_rewrite(expr(lu("hello")))
call_rewrite <- function(x) {
	switch(call_name(x),
				 "lu" = eval(x),
				 call2(call_name(x), !!! map(call_args(x), ~recurse_rewrite(.x))))
}

rewrite <- function(x) {
	x <- enexpr(x)

	recurse_rewrite(x)
}


