#!/bin/bash
xarxa=$1
echo "[alumnes]" > hosts.list
nmap -sP -n 192.168.$xarxa.0/24 -PT22 | grep 192.168.$xarxa. | cut -f 5 -d ' ' >> hosts.list
echo "... Generant el fitxer hosts.list"
echo "  Resultat:"
echo "--------------------"
cat hosts.list
