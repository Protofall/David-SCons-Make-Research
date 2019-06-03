#!/bin/bash



create_output () {
	dataset_file=""
	DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"	#Gets path of script
	if [[ "$1" != "SConstruct" && "$1" != "Makefile" ]];then
		echo "$1 is not a valid parameter. Please pass in either 'Makefile' or 'SConstruct'"
		return 1
	else
		dataset_file="$DIR/$1-project-list.txt"
	fi
	mkdir -p "results"
	mkdir -p "repos"

	output_filename="results/$1.csv"

	# return 0

	cd "repos"
	cat $dataset_file | while read x;do
		# git clone $x
		echo $x
	done
	error_code=$?	#If an error occurs in the while loop, this will detect it
	cd "../"
	if [[ $error_code != 0 ]];then
		exit "$error_code"
	fi

	return 0

	ls "$PWD" | while read x;do
		#Explore each of the projects
		echo "Test"
	done
	error_code=$?	#If an error occurs in the while loop, this will detect it
	if [[ $error_code != 0 ]];then
		exit "$errorCode"
	fi
}

create_output "SConstruct"
create_output "Makefile"
create_output "DERP"