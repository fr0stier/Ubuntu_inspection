#!/bin/bash
echo "[!] Dos attack vulnerable service enable check..."
p1=`cat /etc/xinetd.d/echo | grep disable | awk -F "=" '{print $2}' | grep yes | wc -w`
p2=`cat /etc/xinetd.d/discard | grep disable | awk -F "=" '{print $2}' | grep yes | wc -w`
p3=`cat /etc/xinetd.d/daytime | grep disable | awk -F "=" '{print $2}' | grep yes | wc -w`
p4=`cat /etc/xinetd.d/chargen | grep disable | awk -F "=" '{print $2}' | grep yes | wc -w`
count=0
if [ $p1 != 2 ];then
	echo "[-] \"echo\" service(/etc/xinetd.d/echo) is enable, Result : Vul"
	count=`expr $count + 1`
fi
if [ $p2 != 2 ];then
	echo "[-] \"discard\" service(/etc/xinetd.d/discard) is enable, Result : Vul"
	count=`expr $count + 1`
fi
if [ $p3 != 2 ];then
	echo "[-] \"daytime\" service(/etc/xinetd.d/daytime) is enable, Result : Vul"
	count=`expr $count + 1`
fi
if [ $p4 != 2 ];then
	echo "[-] \"chargen\" service(/etc/xinetd.d/chargen) is enable, Result : Vul"
	count=`expr $count + 1`
fi

if [ $count = 0 ];then
	echo "[+] vulnerable service is disable, Result : Good"
fi










