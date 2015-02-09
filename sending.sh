#!/bin/bash

SERVER='server.example.com'
SENDER='email@example.com'
RECIP='email@domain.com'
i=0

while [ $i -lt 10 ]
do
(sleep 1
echo 'helo $SERVER'
sleep 0.5
echo "mail from: $SENDER"
sleep 0.5
echo "rcpt to: $RECIP"
sleep 4
echo "data"
sleep 1
echo "subject: working please"
echo "from: $SENDER"
echo "to: $RECIP"
echo "
here we go again and again and again
."
sleep 1
echo "quit"
) | telnet $SERVER 25
i=$[$i+1]
done
