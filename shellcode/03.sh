#!/bin/bash

echo "[!] U03 account lock limit check..."
t1=`cat /etc/pam.d/common-auth | grep /lib/security/pam_tally.so | grep no_magic_root | grep account | grep reset | wc -l`
t2=`cat /etc/pam.d/common-auth | grep /lib/security/pam_tally.so | grep auth | grep no_magic_root | grep deny=5 | grep unlock_time | wc -l`
t3=`cat /etc/pam.d/common-auth | grep /lib/security/pam_tally.so | grep no_magic_root | grep account | grep reset | grep "#" | wc -l`
t4=`cat /etc/pam.d/common-auth | grep /lib/security/pam_tally.so | grep auth | grep no_magic_root | grep deny=5 | grep unlock_time | grep "#" | wc -l`

if [ $t3 -eq 0 -a $t4 -eq 0 ];then
	t5=`expr $t1 + $t2`
else
	t5=0
fi

if [ $t5 = 0 ];then
        echo "[-] U03.account lock limit config vulnerable, Result : Vul"
else
        echo "[+] U03.account lock limit config very well, Result : Good"
fi
