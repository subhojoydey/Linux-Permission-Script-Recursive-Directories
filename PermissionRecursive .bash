#!/bin/bash

#******************************************************************************************
# This  shell script accepts username/uid, groupname/gid and an absolute path as variable #
# or as an interactive tool and uses these credentails and path verify executepermissions #
# as user, group or other. This script uses several sub-scripts. At first  "checker.bash" #
# which creates temporary file of "credentials.txt" and "result.txt". Then it calls sub-s #
# cript directoryFinder.bash which creates temporary file "Documents.txt". Finally it cal #
# ls sub-script PermissionDescriptor.bash which creates temporary file "executable_files. #
# txt" contaiting the final file with permissions along with subdirectories.              #
#******************************************************************************************


arguments=( $@ )
#takes all arguments into an array

#incase of incomplete or no arguments prepares for interactive input menu
if [ -z "$arguments"  ]; then
    read -p 'Username/UID: ' arguments[0]
    read -p 'Groupname/GID: ' arguments[1]
    read -p 'Absolute Path: ' arguments[2] 
elif [ ${#arguments[@]} == 1 ]; then
    read -p 'Groupname/GID: ' arguments[1]
    read -p 'Absolute Path: ' arguments[2]
elif [ ${#arguments[@]} == 2 ]; then
    read -p 'Absolute Path: ' arguments[2]	
fi

./checker.bash ${arguments[0]} ${arguments[1]} ${arguments[2]}
#returns a file result.txt which contains the validity

#checks the validity of the arguments as per question and exits 
#with propper mesage if otherwise
if grep -q "SUCCESS11" $HOME/project/result.txt; then
    echo "Valid UID"
elif grep -q "SUCCESS12" $HOME/project/result.txt; then
    arguments[0]=$(awk 'NR==1 {print $2}' $HOME/project/result.txt)
    echo "Valid Username"
else 
    echo "WRONG UID/USERNAME"
    exit 1
fi

if grep -q "SUCCESS21" $HOME/project/result.txt; then
    arguments[1]=$(awk 'NR==2 {print $2}' $HOME/project/result.txt)
    echo "Valid GID"
elif grep -q "SUCCESS22" $HOME/project/result.txt; then
    echo "Valid GroupName"
else
    echo "WRONG GID/GROUPNAME"
    exit 1
fi

if grep -q "SUCCESS3" $HOME/project/result.txt; then
    echo "Valid Path"
else
    echo "WRONG DIRECTORY PATH"
    exit 1
fi

./directoryFinder.bash ${arguments[2]}
#returns with temporary file Documents.txt with proper format

./PermissionDescriptor.bash ${arguments[0]} ${arguments[1]}
#returns with temporary file executable_files.txt with proper permission description 


function CLEANUP {
	rm credentials.txt
	rm group
	rm password
	rm executable_files1.txt
	rm Documents.txt
	rm result.txt
}

trap CLEANUP EXIT
