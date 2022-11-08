#!/bin/bash
echo "[!] U33. Bind service enalbe & version check..."
ps_chk=`ps -ef | grep named | grep -v grep | wc -l`
ver_chk=`named -v 2>/dev/nill | awk -F " " '{print $2}' | awk -F "ubuntu" '{print $1}' | awk -F "-" '{print $1}' | tr -d "."`
inst_chk=`named -v 2>/dev/null | wc -l`
version=9113

#bind9 서비스가 설치되어있고 작동하는지 확인.
if [ $ps_chk != 0 ] && [ $inst_chk != 0 ];then

	#설정한 버전과 bind9 버전 비교
	if [ $ver_chk -lt $version ];then
		echo "[-] U33. Bind version is vulnerable, Result : Vul" 
	else
		echo "[+] U33. Bind version is very well, Result : Good"
	fi
else
	echo "[+] U33. Bind service disable, Result : Good"
fi


