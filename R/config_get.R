#' Gets a configuration
#' @param  header A header in the config.ini file
#' @importFrom ini read.ini
#' @export config_get
config_get <- function(header = NULL) {
  if(is.null(header)) {
    stop("Must supply a header")
  }
  connectr_config <- file.path(read.ini('.connectr.ini')$CONNECTR$CONNECTR_DIR, 'config.ini')
  read.ini(connectr_config)[[header]]
}
