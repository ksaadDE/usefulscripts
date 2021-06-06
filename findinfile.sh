#!/bin/bash
# Written by Karim S. // SAAD-IT // 06/06/2021
# Level 1 search for string in files (in the current Dir)
# Returns the Filename which contains the string
# HINT: you can move it to /bin/ to have it globally available, but please consider the right file permissions!

if [ -z $1 ]; then
	echo "Usage: $0 <string to search for>";
	echo "It will return the Filename, if any match occurs!";
	exit;
fi

searchFor=$1
files=$(ls -p | grep -v /);

for file in $files; do
	found=$(cat $file | grep $searchFor);
	if [ "$found" != "" ]; then
		echo $file;
	fi
done
