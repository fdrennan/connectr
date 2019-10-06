#' Displays current configuration file
#'
#' @importFrom readr read_file
#' @export config_read
config_read <- function() {
  connectr_config <- '~/.connectr/config.ini'
  config <- read_file(connectr_config)
  message(config)
  config
}
