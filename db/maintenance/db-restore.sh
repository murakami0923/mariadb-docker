#!/bin/bash

# source ~/.bashrc

if [ $# -ne 1 ]; then
        echo "作成するDB名を指定してください"
        exit
fi

db=$1

source ~/maintenance/db-conf.sh

echo "[`date '+%Y/%m/%d %H:%M:%S'`] リストアを開始します。"

for file in *.dmp
do
    echo "[`date '+%Y/%m/%d %H:%M:%S'`] ${file} restore start"
    mariadb -h ${dbh} -P ${dbport} -u ${dbuser} $db < ${file}
    echo "[`date '+%Y/%m/%d %H:%M:%S'`] ${file} restore end"
done

echo "[`date '+%Y/%m/%d %H:%M:%S'`] リストアが完了しました。"

