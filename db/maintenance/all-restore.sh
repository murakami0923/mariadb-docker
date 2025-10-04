#!/bin/bash

# db1=swsys
# db2=examinee_name
# db3=log

source ~/maintenance/db-conf.sh

cd $db1
tar zxf dump.tar.gz
~/maintenance/db-create.sh $db1 $db1.schema.sql
cd dump/
~/maintenance/db-restore.sh $db1

cd ~/maintenance/~/maintenance/

