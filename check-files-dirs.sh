#!/bin/bash

FILE=$@

if [ $# -eq 0 ]
then
	echo "USAGE : $0 <file1 file1 file3 ... fileN>"
	exit 1
fi

for i in $FILE
do
	if [ -f "$i" ]
	then
		echo "regular file"
	elif [ -d "$i" ]
	then
		echo "Directory"
	else
		echo "Not known"
		exit 1
	fi
done
