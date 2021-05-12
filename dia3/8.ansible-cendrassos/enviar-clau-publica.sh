#!/bin/bash
< hosts.list xargs -n 1 -I % sh -c "ssh root@% -oPasswordAuthentication=no true || sshpass -e ssh-copy-id -i ~/.ssh/id_rsa.pub root@%"
echo "...Fet"
