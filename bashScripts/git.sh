#!/bin/bash

if [[ $1 == "" ]]; then 
	echo "submit message!"
	read -r message 
	if [[ $message == "" ]]; then
	message="No message"
	fi
else 
	message=$1
fi

git add .
git commit -m "$message"
echo "You sure?! (press y)"
read -r confirm
if [[ $confirm == 'y' ]];then 
git push
else 
	echo 'no push was made'
fi
