#' Displays current configuration file
#' @param header The refrence to the config parameters within config.ini
#' @importFrom readr read_file
#' @importFrom glue glue
#' @importFrom lazyeval lazy_dots
#' @importFrom ini read.ini
#' @export config_add
config_add <- function(header = NULL, ...) {

  config_file_path <- file.path(read.ini('.connectr.ini')$CONNECTR$CONNECTR_DIR, 'config.ini')

  config_file <- read.ini(config_file_path)
  if (header %in% names(config_file)) {
    stop(glue('Header {header} already exists in {config_file_path}'))
  }

  ## Create a new list holding our INI
  if (is.null(header)) {
    stop('Must supply header name')
  }

  # Create Headers List
  headers <- list()
  arglist <- list(lazy_dots(...))
  parameters <- names(arglist[[1]])
  values <- vector(mode = 'character', length = length(parameters))
  for (i in seq_along(parameters)) {
    values[i] = as.character(arglist[[1]][[i]][[1]])
  }
  headers <- as.list(as.character(values))
  names(headers) <-  names(arglist[[1]])


  ini_file <- list()
  ini_file[[ header]] <- headers


  temp_path <- tempfile()
  write.ini(ini_file, temp_path)
  temp_config <- read_file(temp_path)
  write(
    x = temp_config,
    file = config_file_path,
    append = TRUE
  )
}
