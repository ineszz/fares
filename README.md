
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fars package built for JH course

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/ineszz/fars.svg?branch=main)](https://travis-ci.com/ineszz/fars)
<!-- badges: end -->

The goal of fars is to test building R packages knowedge.

This vinette is writen for the package `fars` as part of week 4
assignment of the coursera course “R packages”. The aim of this is to
describe the functions in the package and their use cases. The packages
consists of 5 main functions:

## Installation

\[TBD\] You can install the released version of fars from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("fars")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ineszz/fars")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(fars)
#> Warning: replacing previous import 'vctrs::data_frame' by 'tibble::data_frame'
#> when loading 'dplyr'
## basic example code
```

make\_filename(year)  
e.g. make\_filename(2013)

fars\_read(filename) e.g. fars\_read(“accident\_2013.csv.bz2”)

fars\_read\_years(years)  
e.g. fars\_read\_years(c(2013,2014,2015))

fars\_summarize\_years(years)
e.g. fars\_summarize\_years(c(2013,2014,2015))

fars\_map\_state(state.num, year) e.g. fars\_map\_state(1,2013)

Peer-graded Assignment

# Review Criteria

For this assignment you’ll submit a link to the GitHub repository which
contains your package. This assessment will ask reviewers the following
questions:

  - Does this package contain the correct R file(s) under the R/
    directory?
  - Does this package contain a man/ with directory corresponding
    documentation files?
  - Does this package contain a vignette which provides a meaningful
    description of the package and how it should be used?
  - Does this package have at least one test included in the tests/
    directory?
  - Does this package have a NAMESPACE file?
  - Does the README.md file for this directory have a Travis badge?
  - Is the build of this package passing on Travis badge?
  - Are the build logs for this package on Travis badge free of any
    errors, warnings, or notes?

Please, follow the links on Review Criteria.
