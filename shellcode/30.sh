#!/bin/bash

echo "[!] U30. Sendmail service enable & version check..."

ver_chk=`dpkg -l sendmail 2>/dev/null | tail -1 | awk -F " " '{print $3}' | tr "-" " " | awk -F " " '{print $1}' | tr -d "."`
version=8152 #위 버전검사에서 8.15.2-xx 출력될 시, .과 - 뒤의 숫자는 제거. 8152로 나오게 된다.
ver_empt=`dpkg -l sendmail 2>/dev/null | wc -w`

#미설치 시, ver_empt 변수엔 공백이 출력되고 즉, 0이 들어간다.
if [ $ver_empt = 0 ];then
	ver_chk=$version
fi

if [ $ver_chk -lt $version ];then
	echo "[-] U30. Sendmail service eanble and version is vulnerable(update -> 8.15.2+), Result : Vul"
else
	echo "[+] U30. Sendmail service version is very well or disabled, Result : Good"
fi



