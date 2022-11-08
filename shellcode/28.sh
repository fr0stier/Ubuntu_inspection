#!/bin/bash
echo "[!] U28. NIS/NIS+ service activate check..."
ps_chk=`ps aux | egrep "ypserv|ypbind|ypxfrd|rpc.yppasswdd" | grep -v grep | wc -l`

if [ $ps_chk != 0 ];then
	echo "[-] U28. NIS/NIS+ service activate, Result : Vul"
else
	echo "[+] U28. NIS/NIS+ service disabled, Result : Good"
fi



