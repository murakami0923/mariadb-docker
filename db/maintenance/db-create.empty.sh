#!/bin/bash

# source ~/.bashrc

export MAINTE_SH_DB_USER="appuser"
export MYSQL_PWD="password"  # パスワードの入力を省略するため環境変数に入れる

if [ $# -ne 1 ]; then
	echo "作成するDB名を指定してください"
	exit
fi

db=$1

export MYSQL_PWD=${dbpw}

mariadb -h ${dbh} -P ${dbport} -u ${dbuser} -e "drop database $db"
mariadb -h ${dbh} -P ${dbport} -u ${dbuser} -e "create database $db"
