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
	echo "Repository name,File name,Lines added,Lines removed,Commits" > $output_filename

	#For use in while loops getting data
	rm -f "$source_dir/mypipe"	#Delete the file if present
	mkfifo "$source_dir/mypipe"

	#Go into the repo with directories
	cd "repos/$1"
	current_dir=$(pwd)

	#Explore each project
	ls "$PWD" | while read x;do
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
			echo "$x,$name,$lines_added,$lines_removed,$count" >> $output_filename
			files_per_repo=$((files_per_repo + 1))
		done
		cd "$current_dir"
	done

	cd "$source_dir"

	#Now get the "files per repo" part, too hard to do it in above loop
	first=0
	count=0
	repo_name=''
	file_name=''
	echo "" >> $output_filename
	echo "Repository,Files" >> $output_filename
	sum=-1
	while IFS= read -r line
	do
		if [ $first == 0 ];then	#Skip the header
			first=1
			continue
		fi

		#If either the file or repo name is different (On change)
		if [ "$repo_name" != "$(echo "$line" | cut -d',' -f 1)" ];then
			if [[ $file_name != '' || $repo_name != '' ]];then	#Ignores first call since its going from nothing to something
				echo "$repo_name,$count" >> $output_filename
			fi
			count=0
		fi

		repo_name=$(echo "$line" | cut -d',' -f 1)
		file_name=$(echo "$line" | cut -d',' -f 2)
		if [[ $file_name == '' || $repo_name == '' ]];then	#Detect the end of the previous data and stop
			break
		fi
		count=$((count + 1))
		sum=$((sum + 1))
	done < "$source_dir/results/$1.csv"
	echo "Total,$sum" >> $output_filename	#Adding a total to the bottom

	echo "Finished collecting data for $1"
}

collect_data "Makefile"
collect_data "SConstruct"
