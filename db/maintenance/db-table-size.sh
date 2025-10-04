#!/bin/bash
if [ $# -ne 1 ]; then
	echo DB名を指定してください
	exit
fi

source ~/maintenance/db-conf.sh

export MYSQL_PWD=${dbpw}
mariadb -h ${dbh} -P ${dbport} -u ${dbuser} -e "select table_name, format(round(data_length/1024/1024, 2), 2) as 'data_size(MB)', format(round(index_length/1024/1024, 2), 2) as 'index_size(MB)' from information_schema.tables where table_schema='$1';" -t
