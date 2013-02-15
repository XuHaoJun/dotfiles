#!/bin/zsh

REPEATED_FILES=$(basename -a .* ${HOME}/.* | sort | uniq -d)
REPEATED_FILE_COUNT=$(basename -a .* ${HOME}/.* | sort | uniq -d | wc -l)

if [ "$REPEATED_FILE_COUNT" != 0 ];then
		echo "----The repeated file list----"
		echo $REPEATED_FILES
		echo "----End of repeated file list----"

		echo "Your HOME dir have repeated file. Do you overwrite it?(y/n)"
		read response
		echo
		if [[ $response =~ ^[Yy]$ ]]; then
				rsync --exclude ".git/" --exclude "*~" -av .* $HOME
		fi
fi

