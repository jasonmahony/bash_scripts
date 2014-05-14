#!/bin/bash

SERVER='duralistener2.sc.verticalresponse.com'
SENDER='jason@verticalresponse.com'
RECIP='jason.mahony@gmail.com'

(sleep 1
echo 'helo $SERVER'
sleep 1
echo "mail from: $SENDER"
sleep 1
echo "rcpt to: $RECIP"
sleep 5
echo "data"
sleep 1
echo "subject: working please"
echo "from: $SENDER"
echo "to: $RECIP"
echo "
here we go again and again and again
."
sleep 1
echo "quit") | telnet $SERVER 25
