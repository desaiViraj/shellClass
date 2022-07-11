#!/bin/bash

file=$1

if [[ $# -eq 0 ]]
then
	echo "USGAE: $0 <filename>"
	exit 1
fi

if [[ -f $file ]]
then
	count=`wc -c $file | cut -d ' ' -f 1`
	echo "Number of characters in $file file is $count"
else
	echo "File not found"
fi


