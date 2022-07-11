#!/bin/bash

file=$1
if [[ $# -eq 0 ]]
then
	echo "USAGE: $0 <filename>"
	exit 1
fi

#count=`wc -c $file | cut -d ' ' -f 1`

echo "Printing charaters from $file:"
for i in `cat $file`
do	
	j=1
	count=`echo $i | wc -c`
	while [[ $j -le $count ]]
	do
		x=`echo "$i" | cut -c $j`
		echo "$x"
		j=`expr "$j" + 1`
	done
done
