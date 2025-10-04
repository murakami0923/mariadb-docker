#!/bin/bash
if [ $# -ne 1 ]; then
	echo DB名を指定してください
	exit
fi

source ~/maintenance/db-conf.sh

export MYSQL_PWD=${dbpw}
mariadb -h ${dbh} -P ${dbport} -u ${dbuser} $1 -e "show tables;"
