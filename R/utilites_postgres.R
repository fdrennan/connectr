#' Create a connection to Postgres
#' @importFrom glue glue
#' @importFrom readr write_file
#' @export start_postgres
start_postgres <- function() {

  docker_root <- '~/.connectr/docker/postgres'

  if (!dir.exists(docker_root)) {
    message(glue('Creating dockerfile directory at {docker_root}'))
    dir.create(docker_root, recursive = TRUE)
  }

  docker_path <- file.path(docker_root, 'docker-compose.yaml')
  write_file(docker_postgres, docker_path)

  system(
    command = glue('cd {docker_root} && docker-compose up -d')
  )
}

#' Create a connection to Postgres
#' @importFrom glue glue
#' @export stop_postgres
stop_postgres <- function() {

  docker_root <- '~/.connectr/docker/postgres'

  system(
    command = glue('cd {docker_root} && docker-compose down')
  )

}


