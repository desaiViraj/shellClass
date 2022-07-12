#!/bin/bash

echo "Input filename:"
read -r file
#echo $file
ls -ld $file
if [[ -d "$file" ]]
then
	echo "$file is directory"
elif [[ -f "$file" ]]
then
	echo "$file is regular file"
else
	echo "$file - Nither directory nor regular file."
	exit 1
fi

