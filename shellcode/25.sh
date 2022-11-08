#!/bin/bash
echo "[!] U25. NFS service access control config check..."
export_chk=`cat /etc/exports | grep -v "^#" | grep insecure | wc -w`
export_conf=`cat /etc/exports | grep -v "^#" | sed '/^$/d'`

if [ $export_chk != 0 ];then
	echo "[-] U25. NFS service access control config is vulnerable, Result : Vul"
else
	echo "[+] U25. NFS service access control config is very well, Result : Good"
fi
echo "[/etc/exports]"
echo "----------------------------------------------------------------------"
echo "$export_conf"
echo "----------------------------------------------------------------------"


