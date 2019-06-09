#!/bin/bash

collect_data () {
	source_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"	#Gets path of script
	if [[ "$1" != "SConstruct" && "$1" != "Makefile" ]];then
		echo "$1 is not a valid parameter. Please pass in either 'Makefile' or 'SConstruct'"
		return 1
	fi
	mkdir -p "$source_dir/results"

	#Make a new output file (If it already exists, it overrides it)
	output_filename="$source_dir/results/$1.csv"
	echo "Lines added,Lines removed,File name,Repository name" > $output_filename

	#For use in while loops getting data
	rm -f "$source_dir/mypipe"	#Delete the file if present
	mkfifo "$source_dir/mypipe"

	#Go into the repo with directories
	cd "repos/$1"
	current_dir=$(pwd)

	#Explore each project
	ls "$PWD" | while read x;do
		project_name=$x
		cd "$x"
		find . -name "$1" | while read y;do

			lines_added=0
			lines_removed=0
			count=0

			#Lines added
			git log --pretty=tformat: --numstat $y | cut -f 1 > "$source_dir/mypipe" &
			while IFS= read -r z
			do
				lines_added=$((lines_added + z))
				count=$((count + 1))
			done < "$source_dir/mypipe"
			
			#Lines removed
			git log --pretty=tformat: --numstat $y | cut -f 2 > "$source_dir/mypipe" &
			while IFS= read -r z
			do
				lines_removed=$((lines_removed + z))
			done < "$source_dir/mypipe"

			#Name of file
			name=$(echo "${y#*/}")

			#Output to csv
			echo "$lines_added,$lines_removed,$name,$x" >> $output_filename

		done
		cd "$current_dir"
	done
	cd "$source_dir"
}

collect_data "Makefile"
collect_data "SConstruct"
