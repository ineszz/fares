#' @keywords internal
"_PACKAGE"
# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
#' @title filename
#' @description Function to read files for fars
#' @param filename  A string with the name of the csv to be loaded
#' @return This function returns a tibble corresponding to the csv
#' @importFrom tibble as_tibble
#' @importFrom readr read_csv
#'
#' @examples
#' acc13 <- fars_read("accident_2013.csv.bz2")
#' @export
#'
fars_read <- function(filename) {
  if(!grepl("/",filename)){
    filename <- system.file("data", filename, package="fars")
  }
  if(!file.exists(filename))
    stop("file '", filename, "' does not exist")
  data <- suppressMessages({
    readr::read_csv(filename, progress = FALSE)
  })
  #dplyr::tbl_df(data)
  tibble::as_tibble(data)
}

#' @title make_filename
#' @description Function to build file names readable
#' @param year An integer year (2013-2015)
#' @return This function returns a string that is
#'  the file name of a csv
#' @examples
#' make_filename(2013)
#' @export
#'
make_filename <- function(year) {
  year <- as.integer(year)
  file<-sprintf("accident_%d.csv.bz2", year)
  #system.file("data", file, package="fars")
}

#' @title fars_read_years
#' @description Read in csv for eah year in \code{years} and returns the
#' months and year in that csv
#' @param years Is an integer values needed to build the file in accordance with affiliate year
#' @importFrom dplyr mutate select
#'
#' @return This function returns a list of tibbles
#'
#' @examples
#' fars_read_years(c(2013,2014,2015))
#' @export
fars_read_years <- function(years) {
  lapply(years, function(year) {
    file <- make_filename(year)
    tryCatch({
      dat <- fars_read(file)
      dplyr::mutate(dat, year = year) %>%
        dplyr::select_(MONTH,year)
    }, error = function(e) {
      warning("invalid year: ", year)
      return(NULL)
    })
  })
}

#' @title fars_summarize_years
#' @description summarises the number of entries in the csv files for each
#' year and month in \code{years}

#' @param years an integer
#'
#' @importFrom dplyr bind_rows
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom tidyr spread
#' @importFrom magrittr "%>%"
#'
#' @return This function returns a tibble that summarises each of the csv
#' iles corresponding to the \code{years}
#'
#' @examples
#' fars_summarize_years(c(2013,2014,2015))
#' @export
#'
fars_summarize_years <- function(years) {
  dat_list <- fars_read_years(years)
  dplyr::bind_rows(dat_list) %>%
    dplyr::group_by_(year, MONTH) %>%
    dplyr::summarize_(n = ~n()) %>%
    tidyr::spread_(year, n)
}

#' @title fars_summarize_years
#' @description  Read in csv for  \code{year} and plot all the accidents
#' in \code{state} on a map.
#' @param year an integer
#' @param state.num An integer state.num number
#' @importFrom dplyr filter
#' @importFrom maps map
#'
#' @return This function returns a list of tibbles
#'
#' @examples
#' fars_map_state(1, 2013)
#' @export
#'
#'
fars_map_state <- function(state.num, year) {
  filename <- make_filename(year)
  data <- fars_read(filename)
  state.num <- as.integer(state.num)

  if(!(state.num %in% unique(STATE)))
    stop("invalid STATE number: ", state.num)
  data.sub <- dplyr::filter_(data, ~STATE == state.num)
  if(nrow(data.sub) == 0L) {
    message("no accidents to plot")
    return(invisible(NULL))
  }
  is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
  is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
  with(data.sub, {
    maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
              xlim = range(LONGITUD, na.rm = TRUE))
    graphics::points(LONGITUD, LATITUDE, pch = 46)
  })
}
