#!/bin/bash

# Takes host IP as an argument to SSH
# emails netstat output and runs a restart script
ssh opsadm@$1 "sudo netstat -tp | awk {'print\$2,\$3,\$5,\$6,\$7,\$8'} | sort" > /home/jason/libexec/cpu_netstat.txt
mail -s "CPU Threshold Reached. Restarting App on `host $1 | awk {'print$5'}`" jason@example.com << EOM
Restart script was run on `host $@ | grep -v oceans | awk {'print$5'}`
CPU threshold was reached.
Netstat Output captured at time of restart -`date`
--------------------------------------------
Socket Connection Count Summary
Total connections: `cat /opt/zenoss/libexec/cpu_netstat.txt | wc -l`

Socket Connection Detail -
Recv-Q | Send-Q | Foreign-Address | State | PID/Program-Name
`cat /opt/zenoss/libexec/cpu_netstat.txt`
EOM
ssh opsadm@$1 "sudo /bin/passenger_restart"
