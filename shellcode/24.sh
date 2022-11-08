#!/bin/bash
echo "[!] U24. NFS service enable check..."
ps_chk=`ps -ef | egrep "\[nfsd\]|\[lockd\]|\[statd\]" | wc -l`

if [ $ps_chk != 0 ];then
	echo "[-] U24. NFS service is enable, Result : Vul"
else
	echo "[+] U24. NFS service is disable, Result : Good"
fi


