#!/bin/bash

source ~/maintenance/db-conf.sh

mkdir $db1

cd $db1
~/maintenance/db-dump.all.sh $db1
cd ~/maintenance/

