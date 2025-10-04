#!/bin/bash
# source ~/.bashrc

if [ $# -lt 1 ]; then
        echo "dumpするDB名を指定してください"
        echo "データ（タブ区切り）をファイルに出力する場合、dataを第2引数で指定してください"
        exit
fi

source ~/maintenance/db-conf.sh

db=$1

data='nodata'
if [ $# -eq 2 ]; then
	data=$2
fi

echo "dataオプション"
echo $data

mkdir count
if [ $data = 'data' ];then
	mkdir data
fi
mkdir dump

# DBのスキーマをdump
mariadb-dump -h ${dbh} -P ${dbport} -u ${dbuser} --no-data $db > $db.schema.sql
mv ${db}.schema.sql ${db}.schema.sql.org
sed -r "s/ DATA DIRECTORY=.+;$/;/g" ${db}.schema.sql.org > ${db}.schema.sql

# 各テーブルごとにデータをdump（ロックをしない、また、dumpファイルでもロックの記述を入れない）
for t in `mariadb -h ${dbh} -P ${dbport} -u ${dbuser} $db -N -e "show tables" | cat`;
do
	echo "${table} dump start"
	
	mariadb-dump -h ${dbh} -P ${dbport} -u ${dbuser} --complete-insert --skip-lock-tables --no-create-info --lock-tables=false --add-locks=false $db $t > dump/$t.data.dmp
	sql="select count(*) from $t;"
	echo $sql > count/$t.txt
	mariadb -h ${dbh} -P ${dbport} -u ${dbuser} $db -t -e "$sql" >> count/$t.txt
	if [ $data = 'data' ];then
 		mariadb -h ${dbh} -P ${dbport} -u ${dbuser} $db -t -e "select * from $t" > data/$t.txt
	fi

	echo "${table} dump end"
done

echo "create count.tar.gz start"
tar zcf count.tar.gz count
rm -Rf count
echo "create count.tar.gz end"
if [ $data = 'data' ];then
	echo "create data.tar.gz start"
	tar zcf data.tar.gz data
	rm -Rf data
	echo "create data.tar.gz end"
fi
echo "create dump.tar.gz start"
tar zcf dump.tar.gz dump
rm -Rf dump
echo "create dump.tar.gz end"

