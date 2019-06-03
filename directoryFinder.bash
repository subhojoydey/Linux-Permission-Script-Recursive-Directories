#!/bin/bash

#******************************************************************************************
# This  shell script recursively searches for all files and directories and their subdire #
# ctories and then prints the ls -al with the complete path of the directories and files. #
# Then all this is stored in "Documents.txt".                                             #
#******************************************************************************************


echo "" > Documents.txt
ls -al $1 | awk -vX=$1 '$9=X"/"$9 {print $0}' >> Documents.txt
#current directory details

direc=$1"/*"

#recursive directory search
for d in $direc ; do
  if [ -d $d ]; then
	ls -al $d | awk -vX=$d '$9=X"/"$9 {print $0}' >> Documents.txt
  fi
done
