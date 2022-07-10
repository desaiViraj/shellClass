#!/bin/bash
DATE=$(date +%Y-%m-%d)

for i in *.jpg
do
	mv $i $DATE.$i 2>/dev/null
done
if [ "$?" -eq 0 ]
then
	echo "renamed to $DATE.$i"
else
	echo "No .jpg file found in current directory"
fi
