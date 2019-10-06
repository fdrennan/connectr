#' Disconnect from a connection to Postgres
#'
#' @param connection An active connection
#' @importFrom DBI dbDisconnect
#'
#' @examples
#'\dontrun{
#' con <-
#'   postgres_connect(configuration_header = "postgres", configuration_location = 'config.ini')
#'
#'  db_disconnect(connection = con)
#'}
#' @export db_disconnect
db_disconnect <- function(connection = NULL) {
  message('Disconnecting from database.')
  dbDisconnect(conn = connection)
}
