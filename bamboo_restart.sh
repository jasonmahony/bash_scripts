#!/bin/bash

for i in `cat bamboo_server_ips`
do
  echo $i
  ssh -i ~/.ssh/ssh-keys/wops/bamboo/administrator.pem -o StrictHostKeyChecking=no administrator@$i "sudo su root -c '/etc/init.d/bamboo-agent.sh restart'"
done
