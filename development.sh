#!/bin/bash
# This script will take input in the form of text file.
# This script requires two files: 1. OLD URLS 2. NEW URLS
# USAGE: <script-name> FILE1 FILE2

if [[ "${#}" -lt 1 ]]
then
        echo "USAGE: $0 OLD_URL_FILE  NEW_URL_FILE"
        exit 1
fi

count=1
FILE1=$1
FILE2=$2

while read line1
        do
                #echo $line1
                echo "cloning repo... $line1"
                #git clone $file1 2>/dev/null
                if [[ "${?}" -ne 0 ]]
                then
                        echo "Could not clone repo.."
                        exit 1
                fi

                old_repo=`echo $FILE1 | cut -d '/' -f 5 | cut -d '.' -f 1`
                #cd $old_repo
                #ls
                echo "checking... git remote -v"
                #git remote -v


                line2=`sed -n "$count"p $FILE2`


                echo "Replacing old repo URL to new repo URL"
                #git remote set-url origin "$FILE2"

                echo "checking... git remote -v"
                #git remote -v

                echo "Pushing code to NEW-URL"
                #git push

                if [[ "${?}" -ne 0 ]]
                then
                        echo "git push failed, please check manually."
                        exit 1
                fi
		echo "Migrated to NEW URL $line2"
		echo
                count=`expr $count + 1`
done < $FILE1

echo "success.."

