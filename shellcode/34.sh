#!/bin/bash

echo "[!] U34. DNS Zone Transfer check..."

ps_chk=`bash ps_chk.sh named`
all_chk=`cat /etc/bind/named.conf | grep 'allow-transfer' | wc -l`
xtf_chk=`cat /etc/bind/named.conf | grep 'xfrnets' | wc -l`
count=0

#DNS 프로세스 실행 검사
if [ $ps_chk != 0 ];then

	#allow-transfer 설정 검사
	if [ $all_chk = 0 ];then
		echo "[-] U34. DNS service config \"allow-transfer\" option not set(/etc/bind/named.conf), Result : Vul"
		count=`expr $count + 1`
	fi

	#xfrnets 설정 검사
	if [ $xtf_chk = 0 ];then
		echo "[-] U34. DNS service config \"xfrnets\" option not set(/etc/bind/named.conf), Result : Vul"
		count=`expr $count + 1`
	fi

	if [ $count = 0 ];then
		echo "[+] U34. DNS service config is very well, Result : Good"
	fi
else
	echo "[+] U34. DNS service disabled, Result : Good"
fi

