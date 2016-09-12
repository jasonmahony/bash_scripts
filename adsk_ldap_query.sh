#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: $0 mahonyjadmin"
else
	ldapsearch -x -h 10.39.208.14 -D "CN=Jason Mahony,OU=Mailboxes,DC=ads,DC=autodesk,DC=com" -W -b 'DC=ads,DC=autodesk,DC=com' "sAMAccountName=$1" memberOf | grep memberOf
fi
