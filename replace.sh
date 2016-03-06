#!/bin/bash

# takes IPs from aws and subsitues them into another file

# Get IPs from aws
PUBIPS=($(aws --profile aws-profile ec2 describe-instances --filter "Name=image-id,Values=ami-id" | grep INSTANCES | awk '{print$16}'))
PRVIPS=($(aws --profile aws-profile ec2 describe-instances --filter "Name=image-id,Values=ami-id" | grep INSTANCES | awk '{print$14}'))

i=0
while read -r line ; do
        # find the IPs to replace
	IP_PRV=$(echo $line | awk -F":" '{print$6}' | awk -F"\"" '{print$2}')
	echo $line | sed "s/$IP_PRV/${PRVIPS[$i]}/" >> intermediate_file.txt
	i=$((i+1))
done < original_file.txt

i=0
while read -r line ; do
	# find another IP column to replace
	IP_PUB=$(echo $line | awk -F":" '{print$7}' | awk -F"\"" '{print$2}')
	echo $line | sed "s/$IP_PUB/${PUBIPS[$i]}/" >> final_file.txt
	i=$((i+1))
done < intermediate_file.txt
