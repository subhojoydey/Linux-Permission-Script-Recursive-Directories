# Linux Permission Recreated on Recursive Directories

## Overview

This project recreates the Ubuntu Permission Algorithm using a Bash Shell Script. It accepts three arguments or accepts user inputs of UserID/Username, GroupID/Groupname and Complete path to search recreate the Linux Permissions on the current and all the recursive diretories.

### Taking 3 arguments

#### CLI Arguments

You can pass the Command Line Arguments wihle running the bash script from the command line as follows:-
* ./PermissionRecursive argument1 argument2 argument3

You can then call these arguments by $1 $2 and $3 from the bash scripts. These are all stored as array elements and can be called all together as $@. This allows you to check for the number of arguments passed while calling the bash script and we use this to accept incomplete arguments from CLI as user inputs instead.

#### User Input

You can also take user input from the Command Line as:-
* read -p 'Username/UID: ' arguments[0]

This will print Username/UID: on the CLI and ask for an input which will be stored in arguments array.

