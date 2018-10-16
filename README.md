
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
#> -- Attaching packages --------------------------------------- tidyverse 1.2.1 --
#> v ggplot2 3.0.0     v purrr   0.2.5
#> v tibble  1.4.2     v dplyr   0.7.6
#> v tidyr   0.8.1     v stringr 1.3.1
#> v readr   1.1.1     v forcats 0.3.0
#> -- Conflicts ------------------------------------------ tidyverse_conflicts() --
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
library(eavtools)

tinyeav <- tiny %>%
    new_tbl_eav("empid", "var", "value")

tinyeav
#> # A tibble: 4 x 3
#>   empid var   value
#>   <int> <chr> <chr>
#> 1   100 first John 
#> 2   100 last  Smith
#> 3   101 first Jane 
#> 4   101 last  Doe
```

``` r
str(tinyeav)
#> Classes 'tbl_eav', 'tbl_df', 'tbl' and 'data.frame': 4 obs. of  3 variables:
#>  $ empid: int  100 100 101 101
#>  $ var  : chr  "first" "last" "first" "last"
#>  $ value: chr  "John" "Smith" "Jane" "Doe"
#>  - attr(*, "entity_cols")= chr "empid"
#>  - attr(*, "attr_cols")= chr "var"
#>  - attr(*, "val_cols")= chr "value"
```
