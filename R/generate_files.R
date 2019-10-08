#' Creates default files for connectr
#'
#' @param connectr_base_dir Where the connectr file should be located
#' @importFrom readr write_file
#' @importFrom glue glue
#' @importFrom ini write.ini
#' @export generate_files
generate_files <- function(connectr_base_dir = '~') {

  connectr_environment <- '.connectr.ini'
  connectr_directory <- file.path(connectr_base_dir, '.connectr')
  connectr_ini <- list()
  connectr_ini[[ "CONNECTR" ]] <- list(CONNECTR_DIR = connectr_directory)
  ## Write structure to file
  write.ini(connectr_ini, connectr_environment)

  if(!file.exists('.gitignore')) {
    file.create('.gitignore')
  }

  if(!'.connectr' %in% readr::read_lines('.gitignore')) {
    write('.connectr', '.gitignore', append = TRUE)
    write('.connectr.ini', '.gitignore', append = TRUE)
  }

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
