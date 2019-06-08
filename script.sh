#!/bin/bash

create_output () {
	dataset_file=""
	dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"	#Gets path of script
	if [[ "$1" != "SConstruct" && "$1" != "Makefile" ]];then
		echo "$1 is not a valid parameter. Please pass in either 'Makefile' or 'SConstruct'"
		return 1
	else
		dataset_file="$dir/$1-project-list.txt"
	fi
	mkdir -p "results"
	mkdir -p "repos/$1"

	output_filename="results/$1.csv"

	#Download the projects
	cd "repos/$1"
	counter=1
	cat $dataset_file | while read x;do
		echo -e "$1 project number \"$counter\":"
		let counter=counter+1	#This won't persist outside the loop, but thats fine
		git clone $x
		# echo $x
	done

	#Explore each project
	ls "$PWD" | while read x;do
		project_name=$x
		cd "$x"
		find . -name "$1" | while read y;do
			echo "$y"
		done
		cd "../"
	done
	error_code=$?	#If an error occurs in the while loop, this will detect it
	if [[ $error_code != 0 ]];then
		exit "$error_code"
	fi
	cd $dir
}

create_output "SConstruct"
echo "Done SConstruct"
create_output "Makefile"
echo "Done Makefile"
# create_output "DERP"
