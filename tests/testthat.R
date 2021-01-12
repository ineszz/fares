library(testthat)
library(fars)
# test make_filename
testthat::expect_identical(make_filename(2013),
                 'accident_2013.csv.bz2')

# test fars_read

testthat::test_that('test fars_read', {
  # error when file does not exist
  testthat::expect_error(fars_read('accident_1900.csv.bz2'),
               "file 'accident_1900.csv.bz2' does not exist")})
