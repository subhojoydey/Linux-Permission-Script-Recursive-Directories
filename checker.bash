#!/bin/bash

#******************************************************************************************
# This  shell script accepts username/uid, groupname/gid and an absolute path as argument #
# and then checks for the validity of the arguments. First we combine /etc/group and /etc #
# /passwd into a single file sorted individually as "password" "group" into "credentials. #
# txt". This file was then used to search for the user and group. For success of user,gr  #
# oup we print appropriate string in file "result.txt".                                   #
#******************************************************************************************


user=$1 
group=$2
path=$3

sort -t: -k4,4 /etc/passwd > password
sort -t: -k3,3 /etc/group > group

#single file with username, uid, groupname, gid into a single file
join -t: -1 3 -2 4 group password > credentials.txt

echo "" > result.txt

awk -F':' -vX=$user '{if($5==X){print "SUCCESS11"}  \
		else if($7==X){print "SUCCESS12 " $5}}' credentials.txt > result.txt
#if username and uid comes valid then SUCCESS11/SUCCESS12 is printed

awk -F':' -vX=$user '{if($5==X){print } \
		else if($7==X){print }}' credentials.txt | awk -F':' -vY=$group '{ \
		if($1==Y){print "SUCCESS21 " $2} else if($2==Y){print "SUCCESS22"}}' >> result.txt
#if groupname and gid comes valid then SUCCESS21/SUCCESS22 is printed


if test -d "$path"; then echo "SUCCESS3" >> result.txt; fi
#if path comes valid then SUCCESS3 is printed

