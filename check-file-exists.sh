#!/bin/bash

LOCATION="/home/ansadm/shellBasics"
FILE="/home/ansadm/shellBasics/Hostname.sh"
if [ -e "$LOCATION" ]
then
	echo "$LOCATION exits.."
else
	echo "$LOCATION does not exits!!"
	exit 1
fi

FILENAME=`echo $FILE | cut -d '/' -f 5`
#echo $FILENAME

if [ -x "$FILE" ]
then
	echo "$FILENAME has write permission"
else
	echo "No write permission"
	exit 1
fi

