#!/bin/bash

# source ~/.bashrc

if [ $# -ne 2 ]; then
	echo "作成するDB名と、スクリプト名を指定してください"
	exit
fi

source ~/maintenance/db-conf.sh

db=$1
file=$2

mariadb -h ${dbh} -P ${dbport} -u ${dbuser} -e "drop database $db"
mariadb -h ${dbh} -P ${dbport} -u ${dbuser} -e "create database $db"
mariadb -h ${dbh} -P ${dbport} -u ${dbuser} $db < $file
