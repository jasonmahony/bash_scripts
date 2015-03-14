#!/bin/bash

NOW=`date +"%Y-%m%d_%m%S"`
HOST=`host $1 | awk {'print$5'}`
ssh opsadm@$1 "ps -ef | grep java | grep -v grep | awk {'print\$2'} | xargs -I {} sudo -u elasticsearch /usr/bin/jstack {} | sudo -u elasticsearch tee /var/log/es/jstack/jstack.out.$NOW >/dev/null"
mail -s "CPU Threshold Reached on ES VM $HOST" jason@example.com << EOM
Java Stack Trace (jstack) was run on $HOST
CPU threshold reached at `date`
--------------------------------------------
See jstack output for $HOST in /var/log/es/jstack/jstack.out.$NOW
EOM
