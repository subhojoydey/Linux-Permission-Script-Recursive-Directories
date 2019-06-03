#!/bin/bash

#******************************************************************************************
# This  shell script accepts username/uid and groupname/gid and we provide appropriate pe #
# rmission search with preference order of user->group->other with specific execute permi #
# ssions. The file is then stored as "executable_files.txt"                               #
#******************************************************************************************


user=$1
group=$2

echo "" > executable_files1.txt


awk -vX=$user '{if( $3==X ){print $0}}' Documents.txt | grep ^...x......  | 
awk '{print $0, " UY"}' >> executable_files1.txt
awk -vX=$user '{if( $3==X ){print $0}}' Documents.txt | grep ^...-...... | 
awk '{ print $0, " UN"}' >> executable_files1.txt
#checking user permission by checking "x" at appropriate location 

awk -vX=$group -vY=$user '{if( $4==X && $3!=Y ){print $0}}' Documents.txt | 
grep ^......x... | awk '{print $0," GY"}' >> executable_files1.txt
awk -vX=$group -vY=$user '{if( $4==X && $3!=Y ){print $0}}' Documents.txt | 
grep ^......-... | awk '{print $0," GN"}' >> executable_files1.txt
#checking group permissions by checking "x" at appropriate location

awk -vX=$group -vY=$user '{if( $4!=X && $3!=Y){print $0}}' Documents.txt | 
grep ^.........x | awk '{print $0," OY"}' >> executable_files1.txt
awk -vX=$group -vY=$user '{if( $4!=X && $3!=Y){print $0}}' Documents.txt | 
grep ^.........- | awk '{print $0," ON"}' >> executable_files1.txt
#checking other permissions by checking "x" at appropriate location

column -t executable_files1.txt > executable_files.txt
#formatting the columns
