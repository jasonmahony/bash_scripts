#!/bin/bash

touch /opt/sites/current/tmp/restart.txt
sleep 5

PS=($(ps -ef f | grep Passenger | grep -v grep | awk {'print$2":"$9'}))

for i in "${PS[@]}"
do 
  if [[ $i == *:Passenger ]]
  then
    kill -9 $(echo $i | cut -d':' -f1)
    echo -e "\nKilled PID $i RackApp hung process..."
  fi
done 
