#' Create a connection to Postgres
#'
#' @param configuration_header A header within the configuration file
#' @param configuration_location Pathway to the configuration file
#' @importFrom DBI dbConnect
#' @importFrom RPostgres Postgres
#' @importFrom configr read.config
#' @importFrom glue glue
#'
#' @return  A database connection to postgres
#' @examples
#'
#'\dontrun{
#' con <-
#'   postgres_connect(configuration_header = "postgres", configuration_location = 'config.ini')
#'}
#' @export postgres_connection
postgres_connection <- function(configuration_header   = "postgres",
                                configuration_location = "~/.config.ini") {

  config_exists <- file.exists(configuration_location)

  if (config_exists) {
    message(glue('Using file found at: {configuration_location}'))
  } else {
    stop(glue('File not found at {configuration_location}'))
  }

  configuration_file <- read.config(configuration_location)
  connection <- dbConnect(
    Postgres(),
    dbname   = configuration_file[[configuration_header]][["dbname"]],
    host     = configuration_file[[configuration_header]][["host"]],
    port     = configuration_file[[configuration_header]][["port"]],
    user     = configuration_file[[configuration_header]][["user"]],
    password = configuration_file[[configuration_header]][["password"]]
  )

  return(connection)
}
