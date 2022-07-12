#!/bin/bash
function file_count()
{
	local file=$1
	count=$(ls $file | wc -l)
	echo "Number of files in $file = $count"
}

file_count /var
