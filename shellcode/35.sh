#!/bin/bash

echo "[!] U35. Web service directory listing check..."

file_chk=`bash file_chk.sh /etc/apache2/apache2.conf`
ps_chk=`bash ps_chk.sh apache2`
opt_chk=`cat /etc/apache2/apache2.conf 2>/dev/null | grep -v "^#" | grep Options | egrep "Indexes" | wc -l`

#apache2가 설치되었는지, 프로세스에서 실행중인지 검사
if [ $file_chk != 0 ] && [ $ps_chk != 0 ];then
	
	#apache2 설정파일에서 디렉토리 리스팅을 허용하는 "Indexes" 옵션이 적용되었는지 검사
	if [ $opt_chk != 0 ];then
		echo "[-] U35. Web service directory listing option enable(/etc/apache2/apache2.conf), Result : Vul";
	else
		echo "[+] U35. Web service directory listing option disable, Result : Good";
	fi
else
	echo "[+] U35. Web service is not installed"
fi
