# connectr

<!--  http://jtleek.com/protocols/travis_bioc_devel/ -->
<!-- badges: start -->
  [![Travis build status](https://travis-ci.org/fdrennan/connectr.svg?branch=master)](https://travis-ci.org/fdrennan/connectr)
  [![codecov](https://codecov.io/gh/fdrennan/connectr/branch/master/graph/badge.svg)](https://codecov.io/gh/fdrennan/connectr)
<!-- badges: end -->
  

# About `connectr`

This package uses the configr package to read a configuration file and manage passwords and connection parameters to various database resources, APIS, etc.

`connectr` has a default configuration file. The configuration file is below and I have bundled functions to launch postgres with minimal effort which both allows you to use postgres as well as demo the package. 

```
[localhost_postgres]
dbname = postgres
host = localhost
port = 5432
user = postgres
password = docker
```

This file contains sensitive information that you would not want in your code. Database parameters, API keys etc., are best kept in a separate location. This is the problem that this package solves. 

You can add multiple different types of parameters within one configuration file. For example, we can add to the configuration file other types of keys.

```
[localhost_postgres]
dbname = postgres
host = localhost
port = 5432
user = postgres
password = docker

[aws]
user=freddy
password=password
region=us-east-2
```

In the configuration file above, we can grab parameters by choosing either `localhost_postgres` or `aws` and use the list of information in our files. Some of the code from the function `con_postgres` in this package is sampled below as a demonstration of this concept. Not only do they get separation of sensitive information from the code, but we also can reproduce code and use the same connection structure simply by swapping out `localhost_postgres` with say, `production_postgres`.
```
 connection <- dbConnect(
    Postgres(),
    dbname   = configuration_file[[configuration_header]][["dbname"]],
    host     = configuration_file[[configuration_header]][["host"]],
    port     = configuration_file[[configuration_header]][["port"]],
    user     = configuration_file[[configuration_header]][["user"]],
    password = configuration_file[[configuration_header]][["password"]]
  )
```


Get started by running the `generate_files` function. This function takes a base directory as an argument. This directory is where all of the configuration files will be stored. The default directory is `~` and it is recommended that you do not pass arguments to the function. However if you would like project specific configuration files, you can pass `generate_files(getwd())`. This will create all of the configuration files within your current working directory.

# Getting Started

First run the code below.
```
# To install the package
devtools::install_github('fdrennan/connectr')
library(connectr)

# To create the default files
generate_files()

# To view the default configuration file
system('cat ~/.connectr/config.ini')
system('cat .connectr.ini')
```

This creates a folder called `.connectr` in the directory passed. By default, this is `~/.connectr`. This also creates a default `config.ini` file at `~/.connectr/config.ini`. As well, in your working directory a file called `.connectr.ini` is created to tell the project where to find the configuration files required for the project. `~/.connectr` is a good choice because it creates a uniform location for all projects the share the same configuration files. 

Running `generate_files` will not overwrite any existing configurations, Instead, call it for each project so that the project directory has `.connectr.ini` specifying what directory to locate configuration files in. 

As an example, you can pass `generate_files(getwd())` and a folder and file under the path `file.path(getwd(), '.connectr/config.ini')` will be created as well as a file called `.connectr.ini` which specifies that functions should write and read from this file. 

# Adding configurations

To add configurations, use the function `config_add`. For example,


```
'aws' %>% 
    config_add(user = freddy, 
               password = password, 
               region = 'us-east-2')
```

appends 

```
[aws2]
user=freddy
password=password
region=us-east-2
```

to the existing configuration file. If you're using the default parameters for `generate_files`, this configuration will be available to you in any project. 

# Retrieving configurations
Call the configuration with the function `config_get('aws')`.

```
> config_get('aws')
$user
[1] "freddy"

$password
[1] "password"

$region
[1] "us-east-2"
```

Out-of-the-box, if you have a docker installed, you can use the following commands to launch a docker container containing postgres with persistent storage. You can use the default configuration file to connect to the box. I've already created the dockerfile and it exists within the package. 

You can use `con_postgres` as follows.

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



  
  

