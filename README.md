
<!-- README.md is generated from README.Rmd. Please edit that file -->

# eavtools

The goal of eavtools is to provide utility functions for working with
data in Entity-Attribute-Value format *as if* it were tidy.

## Installation

You can install the development version of this package from github
with:

``` r
# install.packages("devtools")
devtools::install_github("jameelalsalam/eavtools")
```

## Example

Entity-attribute value can be a convenient format for storing many
different variables about model aspect. Using the key-value pair of
columns `variable` and `value` is the marker for entity-attribute-value
formatted data:

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

eav_emissions
#> # A tibble: 8 x 4
#>   model  year variable  value
#> * <chr> <int> <chr>     <int>
#> 1 m1     2015 emissions   100
#> 2 m1     2015 energy       80
#> 3 m1     2030 emissions   120
#> 4 m1     2030 energy      100
#> 5 m2     2015 emissions    90
#> 6 m2     2030 emissions   130
#> 7 m3     2015 emissions   105
#> 8 m3     2015 energy      100
```

One common need for data in this format is to perform calculations
across a group of rows. For example, what does each model project for
the change in emissions from 2015 to 2030?

``` r
eav_emissions %>%
    filter(model!= "m3") %>%
    group_by(model) %>%
    summarize(emissions_change = value[variable == "emissions" & year == 2030] / value[variable == "emissions" & year == 2015])
#> # A tibble: 2 x 2
#>   model emissions_change
#>   <chr>            <dbl>
#> 1 m1                1.2 
#> 2 m2                1.44
```

There are a couple of problems here:

  - I don’t find it easy to read.
  - This type of code doesn’t handle missing or duplicate values well.
    If a value is *implicitly* missing (e.g., there is no row
    corresponding to the selected years/variables) then the code will
    throw an error. Summarize needs something length 1, not length 0.

<!-- end list -->

``` r
eav_emissions %>%
    filter(model== "m3") %>%
    group_by(model) %>%
    summarize(emissions_change = value[variable == "emissions" & year == 2030] / value[variable == "emissions" & year == 2015])
#> Error in summarise_impl(.data, dots): Column `emissions_change` must be length 1 (a summary value), not 0
```

``` r
eav_emissions %>%
    group_by(model) %>%
    summarize(emissions_change = 
                            value %forwhich% (variable == "emissions" & year == 2030) /
                            value %forwhich% (variable == "emissions" & year == 2015))
#> # A tibble: 3 x 2
#>   model emissions_change
#>   <chr>            <dbl>
#> 1 m1                1.2 
#> 2 m2                1.44
#> 3 m3               NA
```

Using the `%forwhich%` function in this package solves the error
behavior, but it does not solve the readability issue. This type of code
scales up:

``` r
eav_emissions %>%
    group_by(model, variable) %>%
    summarize(change_2015_to_2030 = 
                            value %forwhich% (year == 2030) /
                            value %forwhich% (year == 2015))
#> # A tibble: 5 x 3
#> # Groups:   model [?]
#>   model variable  change_2015_to_2030
#>   <chr> <chr>                   <dbl>
#> 1 m1    emissions                1.2 
#> 2 m1    energy                   1.25
#> 3 m2    emissions                1.44
#> 4 m3    emissions               NA   
#> 5 m3    energy                  NA
```
