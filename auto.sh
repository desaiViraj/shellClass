#!/bin/bash
# This script will take input in the form of text file.
# This script requires two files: 1. OLD URLS 2. NEW URLS
# USAGE: <script-name> FILE1 FILE2

if [[ "${#}" -lt 1 ]]
then
	echo "USAGE: $0 OLD_URL_FILE  NEW_URL_FILE"
	exit 1
fi 

FILE1=`cat $1`
FILE2=`cat $2`

#echo "${file1}"

echo "Cloning repo..."
#git clone $file1 2>/dev/null
if [[ "${?}" -ne 0 ]]
then
	echo "Could not clone repo.."
	exit 1
fi

old_repo=`echo $file1 | cut -d '/' -f 5 | cut -d '.' -f 1`
cd $old_repo
ls
echo "checking... git remote -v"
git remote -v

echo "Replacing old repo URL to new repo URL"
git remote set-url origin "$file2"

echo "checking... git remote -v"
git remote -v

echo "Pushing code to NEW-URL"
git push

if [[ "${?}" -ne 0 ]]
then
	echo "git push failed, please check manually."
	exit 1
fi

echo "git push: success.."

