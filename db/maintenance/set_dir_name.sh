#!/bin/bash

dir_right=現時点DB

if [ $# -eq 1 ]; then
	dir_right=$1
fi

d=`date '+%Y%m%d-%H%M%S'`.appdb.${dir_right}

mkdir $d/
cd $d/

