#!/bin/bash

find . -name "Makefile" | while read y;do	#Finds makefiles in a directory and subdirectory
	if [[ "./src/etcd/Makefile" == "$y" ]];then
		# echo $(git log --numstat --oneline --no-decorate $y)
		# echo $(git log --pretty=format:"Hello %n %H %n" $y)
		# echo $output
		# git log --pretty=format:"Hello%n%H%n" $y
		# output=$(git log --numstat --oneline --no-decorate $y)
		# git log --numstat --oneline --no-decorate $y
		# var="$(printf "$(git log --numstat --oneline --no-decorate $y)")"
		# var="$(git log --numstat --oneline --no-decorate $y)"
		# printf "$var"
		# name=$(echo $y | cut -f1 -d"/")

		#Get the name all nicely
		name=$(echo "${y#*/}")

		git log --pretty=tformat: --numstat $y	#Confirming its right
		lines_added=0
		lines_removed=0
		count=0

		mkfifo mypipe	#This is kinda dodgy, if file hasn't been

		#Lines added
		git log --pretty=tformat: --numstat $y | cut -f 1 > mypipe &
		while IFS= read -r z
		do
			lines_added=$((lines_added + z))
			count=$((count + 1))
		done < mypipe

		#Lines removed
		git log --pretty=tformat: --numstat $y | cut -f 2 > mypipe &
		while IFS= read -r z
		do
			lines_removed=$((lines_removed + z))
		done < mypipe

		echo "Test: " $lines_added
		echo "Test: " $lines_removed
		echo "Test: " $count
		echo "Test: " $name
	fi
	echo $y
done

#How about we store the string, and while loop though it  delimiter '\n' searching for "number number string"
# Since none of the paths happen to have spaces in them, we can just match this


#export MYVAR="2 5a1 js/dfs/dfs/SConstruct"
#export MYFILE="js/dfs/dfs/SConstruct"
#[[ $MYVAR =~ [[ $MYVAR =~ [0-9]+[\s]+[0-9]+[\s]+[$MYFILE]{1}$ ]] && echo "yes"

#Its almost there, but cases like this don't work



#or maybe just `output | grep $Filename` and then filter it using [0-9]+\s+[0-9]+\s+
