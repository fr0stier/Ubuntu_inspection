#!/bin/bash

echo ""
echo "[!] U13 file & directory Sticky bit Check..."
echo "--------------------------------------------------------------"
array=("/sbin/dump" "/sbin/restore" "/sbin/unix_chkpwd" "/usr/bin/at" "/usr/bin/lpq" "/usr/bin/lpq-lpd" "/usr/bin/lpr" "/usr/bin/lpr-lpd" "/usr/bin/lprm" "/usr/bin/lprm-lpd" "/usr/bin/newgrp" "/usr/sbin/lpc" "/usr/sbin/lpc-lpd" "/usr/sbin/traceroute")

count=0
for i in ${array[@]}
do
	sb_check=`ls -al $i 2>/dev/null | awk '{ print $1}' | grep -o s | wc -w`
	
	if [ $sb_check -ne 0 ];then
		echo "$i file/directory is using sticy bit!!"
		count=`expr $count + 1`
	fi
done

if [ $count = 0 ];then
	echo "[+] U13 file & directory Sticky bit Check is very well, Result : Good"
else
	echo "[-] U13 file & directory Sticky bit Check is vulnerable, Result : Vul"
fi
echo "--------------------------------------------------------------"


