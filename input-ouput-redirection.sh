#!/bin/bash

# Redirect STDOUT to a file
FILE="/tmp/data"
head -n1 /etc/passwd > ${FILE}

# Redirect STDIN to a program
read LINE < ${FILE}
echo "LINE contains: ${LINE}"

#
head -n3 /etc/passwd > ${FILE}
echo "Contents of ${FILE}:"
cat ${FILE}
