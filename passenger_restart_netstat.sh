#!/bin/bash

ssh opsadm@$1 "sudo netstat -tp | awk {'print\$2,\$3,\$5,\$6,\$7,\$8'} | sort" > /home/jason/libexec/cpu_netstat.txt
mail -s "CPU Threshold Reached. Restarting App on `host $1 | grep -v oceans | awk {'print$5'}`" jason@example.com << EOM
Restart script was run on `host $@ | grep -v oceans | awk {'print$5'}`
CPU threshold was reached.
Netstat Output captured at time of restart -`date`
--------------------------------------------
Socket Connection Count Summary
Shard databases: `cat /opt/zenoss/libexec/cpu_netstat.txt | grep s0._r1 | wc -l`
Load balancers: `cat /opt/zenoss/libexec/cpu_netstat.txt | grep 10.40.16.1 | wc -l` 
Master database: `cat /opt/zenoss/libexec/cpu_netstat.txt | grep masterdb01 | wc -l` 
New Relic: `cat /opt/zenoss/libexec/cpu_netstat.txt | grep newrelic | wc -l` 
EC2: `cat /opt/zenoss/libexec/cpu_netstat.txt | grep ec2 | wc -l`

Socket Connection Detail -
Recv-Q | Send-Q | Foreign-Address | State | PID/Program-Name
`cat /opt/zenoss/libexec/cpu_netstat.txt`
EOM
ssh opsadm@$1 "sudo /bin/passenger_restart"
