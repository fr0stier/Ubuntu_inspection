#!/bin/bash
echo "[!] U21. r service enable check..."
rpak_chk=`find /usr/share/doc -name rsh-server 2>/dev/null | wc -l`

if [ $rpak_chk != 0 ];then
	echo "[-] U21. r service is enable, result : Vul"
else
	echo "[+] U21. r service is disable, result : Good"
fi


