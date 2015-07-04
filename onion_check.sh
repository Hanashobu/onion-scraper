#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 onionlist.txt";
	exit;
fi

touch $1;

while true; do
	url="http://"$(cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-z0-9' | fold -w 16 | head -n 1)".onion";
	echo "[i] Scanning $url";
	if torsocks curl --fail --head "$url" >/dev/null 2>&1; then
		echo "$url" >> $1;
    	echo "[+] Valid hidden service $url";
	else
    	echo "[-] Invalid hidden service $url";
	fi
done;
