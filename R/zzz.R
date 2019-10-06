#' @importFrom readr write_file
#' @importFrom glue glue
.onLoad <- function(libname, pkgname){
  connectr_dir <- '~/.connectr'
  if (!dir.exists(connectr_dir)) {
    packageStartupMessage('Creating base directory for connectr at ~/.connectr')
    dir.create(connectr_dir)
  } else {
    packageStartupMessage('Using base directory for connectr at ~/.connectr')
  }

  config_name <-  'config.ini'
  config_path <- file.path(connectr_dir, config_name)

  if (!file.exists(config_path)) {
    packageStartupMessage(glue('Creating default config.ini file at {config_path}'))
    starting_configuration <- "[localhost_postgres]\ndbname = postgres\nhost = localhost\nport = 5432\nuser = postgres\npassword = docker\n"
    write_file(config_default, config_path)
  }
}

