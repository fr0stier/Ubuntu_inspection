#!/bin/bash

echo "[!] U26. automount service enable check..."
am_chk=`ps -aux | grep autofs | grep -v grep | wc -l`

if [ $am_chk != 0 ];then
	echo "[-] U26. automount service enable, Result : Vul"
else
	echo "[+] U26. automount service disable, Result : Good"
fi


