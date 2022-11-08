#/bin/bash

echo "[!] U18 connect IP & Port config check..."
allow_chk=`cat /etc/hosts.allow | grep -v ^# | wc -w`
deny_chk=`cat /etc/hosts.deny | grep -v ^# | wc -w`

#접속허용 IP, Port 검사
if [ $allow_chk = 0 ];then
	echo "[-] U18 allow IP & Port config is not set, Result : Vul"
else
	echo "[+] U18 allow IP & Port config is Result : Good"
	echo "`cat /etc/hosts.allow | grep -v ^#`"
fi

#접속 거부 IP, Port 검사
if [ $deny_chk = 0 ];then
	echo "[-] U18 deny IP & Port config is not set, Result : Vul"
else
	echo "[+] U18 deny IP & Port config is set, Result : Good"
	echo "`cat /etc/hosts.deny | grep -v ^#`"
fi




