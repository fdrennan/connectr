#' Create a connection to Postgres
#'
#' docker pull postgres
#' mkdir -p $HOME/docker/volumes/postgres
#' docker run --rm  --name pg-docker -e POSTGRES_PASSWORD=docker -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data  postgres
#' psql -h localhost -U postgres -d postgres
#'
#' @param configuration_header A header within the configuration file
#' @importFrom DBI dbConnect
#' @importFrom RPostgres Postgres
#' @importFrom ini read.ini
#' @importFrom glue glue
#'
#' @return  A database connection to postgres
#' @examples
#'
#'\dontrun{
#' con <-
#'   postgres_connect(configuration_header = "postgres", configuration_location = 'config.ini')
#'}
#' @export con_postgres
con_postgres <- function(configuration_header   = "postgres_docker") {

  configuration_location <- file.path(read.ini('.connectr.ini')$CONNECTR$CONNECTR_DIR, 'config.ini')
  configuration_file <- read.ini(configuration_location)

  if (!configuration_header %in% names(configuration_file)) {
    stop(glue('Configuration {configuration_header} not found in file {configuration_location}'))
  }

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
