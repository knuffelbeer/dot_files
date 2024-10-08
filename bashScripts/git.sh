#!/bin/bash

if [[ $1 == "" ]]; then 
	message="No message"
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

