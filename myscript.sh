#!/bin/bash 
myvar=$(ip -br ad sh | grep -v lo | awk '{print $3}' | cut -d / -f1)
myrev=$(ip -br ad sh | grep -v lo | awk '{print $3}' | awk -F . '{print $4}' | cut -d / -f1)
nsupdate << EOF
server 192.168.100.204
zone meher.tn
update add $HOSTNAME 86400 A $myvar
send
quit
EOF

nsupdate << MOR
server 192.168.100.204
zone 100.168.192.in-addr.arpa
update add $myrev.100.168.192.in-addr.arpa 86400 PTR $HOSTNAME.
send
quit
MOR
