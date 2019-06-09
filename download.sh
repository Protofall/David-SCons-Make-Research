#!/bin/bash

download () {
	dataset_file=""
	dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"	#Gets path of script
	if [[ "$1" != "SConstruct" && "$1" != "Makefile" ]];then
		echo "$1 is not a valid parameter. Please pass in either 'Makefile' or 'SConstruct'"
		return 1
	else
		dataset_file="$dir/$1-project-list.txt"
	fi
	mkdir -p "repos/$1"

	#Download the projects
	cd "repos/$1"
	counter=1
	cat $dataset_file | while read x;do
		echo -e "$1 project number \"$counter\":"
		let counter=counter+1	#This won't persist outside the loop, but thats fine
		git clone $x
	done

	cd $dir
}

download "SConstruct"
echo "Done SConstruct"
download "Makefile"
echo "Done Makefile"
# download "DERP"
