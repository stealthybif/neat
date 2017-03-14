#!/bin/bash

fd=$1
rp=$2
file=$3
out=$4

if [ ! $# == 4 ]; then
echo "Usage is:"
echo "findreplaceFSF.sh <string to find> <string to replace> <template file> <output file>"
exit
fi

if [ ! -e ${file} ]; then
echo "Cannot find ${file} please check path"
exit
fi

sed "s/${fd}/${rp}/g" ${file} > ${out}


