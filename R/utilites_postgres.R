#' Create a connection to Postgres
#' @importFrom glue glue
#' @importFrom readr write_file
#' @importFrom glue glue
#' @export postgres_start
postgres_start <- function() {

  docker_root <- file.path(read.ini('.connectr.ini')$CONNECTR$CONNECTR_DIR, 'docker/postgres')

  if (!dir.exists(docker_root)) {
    message(glue('Creating dockerfile directory at {docker_root}'))
    dir.create(docker_root, recursive = TRUE)
  }

  docker_path <- file.path(docker_root, 'docker-compose.yaml')
  write_file(docker_postgres, docker_path)

  message(
    glue('Starting postgres at {docker_root}')
  )


  system(
    command = glue('cd {docker_root} && docker-compose up -d')
  )
}

#' Create a connection to Postgres
#' @importFrom glue glue
#' @export postgres_stop
postgres_stop <- function() {

  docker_root <- file.path(read.ini('.connectr.ini')$CONNECTR$CONNECTR_DIR, 'docker/postgres')

  message(
    glue('Stopping postgres at {docker_root}')
  )

  system(
    command = glue('cd {docker_root} && docker-compose down')
  )

}


