#!/bin/bash

echo "[!] U16 /dev non-existent device check..."
dir_check=`find /dev -type f -exec ls -l {} \; | wc -w`

if [ $dir_check != 0 ];then
	echo `find /dev -type f -exec ls -l {} \; | awk -F " " '{print $9}' > deviceFile.txt`"[-] U16 /dev non-existent device is True, Result : Vul"
else
	echo "[+] U16 /dev non-existent device is False, Result : Good"
fi



