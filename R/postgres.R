#' @param configuration_header A header within the configuration file
#' @param configuration_file Pathway to the configuration file
#' @importFrom DBI dbConnect
#' @importFrom RPostgres Postgres
#' @importFrom configr read.config
#' @returns A database connection to postgres
#' @export postgres_connection
postgres_connection <- function(configuration_header = "postgres",
                                configuration_file = "config.ini") {

  configuration_file <- read.config(configuration_file)
  connection <- dbConnect(
    Postgres(),
    dbname   = config_file[["postgres"]][["dbname"]],
    host     = config_file[["postgres"]][["host"]],
    port     = config_file[["postgres"]][["port"]],
    user     = config_file[["postgres"]][["user"]],
    password = config_file[["postgres"]][["password"]]
  )
}
