#!/bin/bash
input="avalon-employees.csv"

counter=0;

echo "rhbase_users:" >>../ansible/host_vars/pr001.yml
while IFS=',' read -r f1 f2 f3 f4 f5 f6 f7
do 

if [ $counter -eq 0 ]; then
input="skipd"$f2;
else
  	echo "- name: "$f4 >>../ansible/host_vars/pr011.yml
    	echo "  comment:" $f2 $f3 >>../ansible/host_vars/pr011.yml
    	echo "  password:" $f4 >>../ansible/host_vars/pr011.yml
    	echo "  groups: [" $f6 "]">>../ansible/host_vars/pr011.yml
	echo " ">>../ansible/host_vars/pr011.yml
fi
counter=2;

done < "$input"
