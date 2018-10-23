
<!-- README.md is generated from README.Rmd. Please edit that file -->

# eavtools

The goal of eavtools is to provide shims to dplyr functions to work with
data in Entity-Attribute-Value format *as if* it were tidy.

## Installation

You can (cannot) install the released version of eavtools from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("eavtools")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
## basic example code
library(tidyverse)
#> -- Attaching packages ---------------------------------------- tidyverse 1.2.1 --
#> v ggplot2 3.0.0     v purrr   0.2.5
#> v tibble  1.4.2     v dplyr   0.7.7
#> v tidyr   0.8.1     v stringr 1.3.1
#> v readr   1.1.1     v forcats 0.3.0
#> -- Conflicts ------------------------------------------- tidyverse_conflicts() --
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
library(eavtools)

tinyeav <- tiny %>%
    new_tbl_eav("empid", "var", "value")

tinyeav
#> # A tibble: 5 x 3
#>   empid var   value  
#>   <int> <chr> <chr>  
#> 1   100 first John   
#> 2   100 last  Smith  
#> 3   101 first Jane   
#> 4   101 last  <NA>   
#> 5   102 first Madonna
```

``` r
str(tinyeav)
#> Classes 'tbl_eav', 'tbl_df', 'tbl' and 'data.frame': 5 obs. of  3 variables:
#>  $ empid: int  100 100 101 101 102
#>  $ var  : chr  "first" "last" "first" "last" ...
#>  $ value: chr  "John" "Smith" "Jane" NA ...
#>  - attr(*, "entity_cols")= chr "empid"
#>  - attr(*, "attr_cols")= chr "var"
#>  - attr(*, "val_cols")= chr "value"
```

``` r
tiny %>%
    dplyr::group_by(empid) %>%
    dplyr::summarize(
        first  = value %forwhich% (var == "first"),
        middle = value %forwhich% (var == "middle"),
        last   = value %forwhich% (var == "last")
    )
#> # A tibble: 3 x 4
#>   empid first   middle last 
#>   <int> <chr>   <chr>  <chr>
#> 1   100 John    <NA>   Smith
#> 2   101 Jane    <NA>   <NA> 
#> 3   102 Madonna <NA>   <NA>
```
