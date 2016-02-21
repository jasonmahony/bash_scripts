#!/bin/bash

# Run jmap on elasticsearch host and email a summary

NOW=`date +"%Y-%m%d_%m%S"`
HOST=`host $1 | awk {'print$5'}`
ssh opsadm@$1 "ps -ef | grep java | grep -v grep | awk {'print\$2'} | xargs -I {} sudo -u elasticsearch /usr/bin/jmap -heap {} | sudo -u elasticsearch tee /var/log/es/jmap/jmap.out.$NOW >/dev/null"
mail -s "Memory Threshold Reached on ES VM $HOST" jason@example.com << EOM
Java Heap Dump (jmap) was run on $HOST
Memory threshold reached at `date`
--------------------------------------------
See jmap output for $HOST in /var/log/es/jmap/jstack.out.$NOW
EOM
