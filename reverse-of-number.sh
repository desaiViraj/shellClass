#!/bin/bash

if [ $# -eq 0 ]
then
	echo "USGAE: $0 <1234...>"
	echo "This script will reverse the given number"
	echo "Eg. 12345 will output 54321"
	exit 1
fi

n=$1
rev=0
sd=0

while [ $n -gt 0 ]
do
	sd=`expr $n % 10`
	rev=`expr $rev \* 10 + $sd`
	n=`expr $n / 10`
done
echo "Reverse of $n = $rev"
