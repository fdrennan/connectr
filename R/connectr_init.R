#' Creates default paramters for connectr
#' @importFrom readr write_file
#' @importFrom glue glue
#' @importFrom ini write.ini
#' @export connectr_init
connectr_init <- function(connectr_base_dir = '~') {

  connectr_environment <- '.connectr.ini'
  connectr_directory <- file.path(connectr_base_dir, '.connectr')
  connectr_ini <- list()
  connectr_ini[[ "CONNECTR" ]] <- list(CONNECTR_DIR = connectr_directory)
  ## Write structure to file
  write.ini(connectr_ini, connectr_environment)


  if (!dir.exists(connectr_directory)) {
    message(glue('Creating base directory for connectr at {connectr_directory}'))
    dir.create(connectr_directory)
    # Create default config file.
    config_name <-  'config.ini'
    config_path <- file.path(connectr_directory, config_name)
    message(glue('Creating default config.ini file at {config_path}'))
    write_file(config_default, config_path)
  } else {
    message(glue('Using base directory for connectr at {connectr_directory}'))
    message('Nothing changed')
  }

}
