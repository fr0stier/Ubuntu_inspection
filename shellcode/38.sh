#!/bin/bash
echo "[!] U38. web service Unnecessary file check..."
find_file=`find / -name manual 2>/dev/null`

if [ "${find_file:(-6)}" = "manual" ];then
	echo "[-] U38. web service Unnecessary file is $find_file, Result : Vul"
else
	echo "[+] U38. web service Unnecessary file not found, Result : Good"
fi

