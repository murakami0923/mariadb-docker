#!/bin/bash
dbuser=appuser
dbpw=password
db1=appdb
dbh=127.0.0.1
dbport=3306

export MYSQL_PWD=$dbpw

set | grep -E "^db.+=.+"
set | grep -E "^MYSQL_PWD=.+"
