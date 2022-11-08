#!/bin/bash

echo "[!] U04 password file protect check..."
passwdCheck=$(cat /etc/passwd | awk -F: '{print $2}' | tr " " "\n")
pc2=$(cat /etc/passwd | awk -F: '{print $2}' | tr " " "\n" | wc -l)
pc3=$(cat /etc/shadow | awk -F: '{print $2}' | tr " " "\n" | wc -l)

passCount=0
#각 필드의 개수가 맞는지 확인
if [ $pc2 != $pc3 ];then
	passCount=`expr $passCount + 1`
fi

#/etc/passwd의 두번째 필드가 모두 'x'인지 확인
for pc in $passwdCheck
do
        if [ $pc != "x" ];then
                passCount=`expr $passCount + 1`
        fi
done


if [ $passCount -eq 0 ];then
        echo "[+] U04.Password File Protect config very well, Result : Good"
else
        echo "[-] U04.Password File Protect config vulnerable, Result : Vul"
fi


