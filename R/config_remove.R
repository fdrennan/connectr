#' Removes value from ini
#' @importFrom ini read.ini
#' @importFrom ini write.ini
#' @importFrom glue glue
#' @export config_remove
config_remove <- function(header = NULL) {

  config_file_path <- '~/.connectr/config.ini'
  config_file <- read.ini(config_file_path)

  if (! header %in% names(config_file)) {
    stop(glue('Header {header} not in {config_file_path}'))
  }

  config_file[[header]] = NULL

  write.ini(
    x = config_file,
    filepath = config_file_path
  )
}


