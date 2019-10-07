# connectr

<!--  http://jtleek.com/protocols/travis_bioc_devel/ -->
<!-- badges: start -->
  [![Travis build status](https://travis-ci.org/fdrennan/connectr.svg?branch=master)](https://travis-ci.org/fdrennan/connectr)
  [![codecov](https://codecov.io/gh/fdrennan/connectr/branch/master/graph/badge.svg)](https://codecov.io/gh/fdrennan/connectr)
<!-- badges: end -->
  
  
This package uses the configr package to read a configuration file and manage connections to various database resources.

For example, in your working directory, create the file below with the appropriate parameters. Name it `~/.config.ini`.

You can use the `postgres_connection` as follows.

```
[postgres]
dbname   = public
host     = 127.0.0.1
port     = 5432
user     = username
password = password
```

```
con <- postgres_connection()
db_disconnect(con)
```


Using Docker with default values
```
library(connectr)

postgres_start()

con <-
  con_postgres(
    configuration_header = 'localhost_postgres'
  )

DBI::dbWriteTable(con, 'mtcars', mtcars)
DBI::dbReadTable(con, 'mtcars')

db_disconnect(connection = con)

postgres_stop()
```
