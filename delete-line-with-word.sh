#!/bin/bash

file=$1

if [[ $# -eq 0 ]]
then
	echo "USGAE: $0 filename"
	exit 1
fi

for i in `cat $file`
do
	j=`expr length $i`
	if [[ ( "$j" == 5 || "$j" == 7 ) ]]
	then
		v=`echo $i | grep dd`
		if [ "$v" != "" ]
		then
			echo $v
			sed -i "s/$v/lalat/g" $file
		fi
	fi
done
