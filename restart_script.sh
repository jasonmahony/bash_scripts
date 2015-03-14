#!/bin/bash

# Script assumes touch /tmp/restart.txt will
# restart passenger running with Nginx on host
touch /tmp/restart.txt
sleep 5

PS=($(ps -ef f | grep Passenger | grep -v grep | awk {'print$2":"$9'}))

# This section kills hung passenger processes
for i in "${PS[@]}"
do 
  if [[ $i == *:Passenger ]]
  then
    kill -9 $(echo $i | cut -d':' -f1)
    echo -e "\nKilled PID $i RackApp hung process..."
  fi
done 
