#!/bin/bash
echo "[!] U22. Crontab file owner & privilege check..."

usrbinOWN_chk=`bash file_own.sh /usr/bin/crontab | grep root | wc -l`
usrbinPRI_chk=`bash file_Pri.sh /usr/bin/crontab`

etcOWN_chk=`bash file_own.sh /etc/crontab | grep root | wc -l`
etcPRI_chk=`bash file_Pri.sh /etc/crontab`

count=0

if [ $usrbinOWN_chk = 0 ];then
	echo "[-] U22. Crontab file(/usr/bin/crontab) owner is not root, Result : Vul"
	count=`expr $count + 1`
fi
if [ $usrbinPRI_chk -gt 0750 ];then
        echo "[-] U22. Crontab file(/usr/bin/crontab) privilege is great than 0750, Result : Vul"
        count=`expr $count + 1`
fi
if [ $etcOWN_chk = 0 ];then
        echo "[-] U22. Crontab file(/etc/crontab) owner is not root, Result : Vul"
        count=`expr $count + 1`
fi
if [ $etcPRI_chk -gt 0640 ];then
        echo "[-] U22. Crontab file(/etc/crontab) privilege is great than 640, Result : Vul"
        count=`expr $count + 1`
fi

if [ $count = 0 ];then
	echo "[+] U22. Crontab file owner & privilege config is very well, Result : Good"
fi


