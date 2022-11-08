#!/bin/bash

echo "[!] U15 world writable file Check..."

tmp=`find / -type f -perm -2 -exec ls –l {} \; 2>/dev/null | wc -w`

if [ $tmp = 0 ];then
	echo "[+] U15 world writable file Check is very well, Result : Good"
else
	echo `find / -type f -perm -2 -exec ls -l {} \; 2>/dev/null | awk -F " " '{print $9}' | tr " " "\n" > wordlist.txt`"[-] U15 world writable file Check is vulnerable, Result : wordlist.txt"
fi
