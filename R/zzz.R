## quiets concerns of R CMD check
if(getRversion() >= "2.15.1")  utils::globalVariables(c("config_default", "docker_postgres"))
