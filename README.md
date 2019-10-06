# connectr

<!-- badges: start -->
  [![Travis build status](https://travis-ci.org/fdrennan/connectr.svg?branch=master)](https://travis-ci.org/fdrennan/connectr)
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
