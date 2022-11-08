#!/bin/bash
echo "[!] U36. Web service & Web process privilege limit check..."

file_chk=`bash file_chk.sh /etc/apache2/apache2.conf`
user_chk=`cat /etc/apache2/apache2.conf 2>/dev/null | grep -v "^#" | grep "^User" | awk -F " " '{print $2}' | grep -i "root" | wc -l`
group_chk=`cat /etc/apache2/apache2.conf 2>/dev/null | grep -v "^#" | grep "^Group" | awk -F " " '{print $2}' | grep -i "root" | wc -l`
count=0

#에러 출력을 없애기 위한 파일 유효성 검사
if [ $file_chk = 0 ];then
	user_chk="null"
	group_chk="null"
fi

#apache2 데몬 구동 권한 user가 root인지 확인
if [ $user_chk -eq 1 ];then
	echo "[-] U36. Web service config file User set \"root\"(/etc/apache2/apache2.conf), Result : Vul"
	count=`expr $count + 1`
fi

#apache2 데몬 구동 권한 group이 root인지 확인
if [ $group_chk -eq 1 ];then
	echo "[-] U36. Web service config file Group set \"root\"(/etc/apache2/apache2.conf), Result : Vul"
	count=`expr $count + 1`
fi

if [ $count = 0 ];then
	echo "[+] U36. Web service config file is very well, Result : Good"
fi
