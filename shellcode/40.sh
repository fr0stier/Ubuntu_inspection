#!/bin/bash

echo "[!] U40. Web service file download limit config check..."

file_chk=`bash file_chk.sh /etc/apache2/apache2.conf`
ps_chk=`bash ps_chk.sh apache2`
opt_chk=`cat /etc/apache2/apache2.conf 2>/dev/null | grep -v "^#" | grep -i "LimitRequestBody" | wc -l`

#apache2가 설치되었는지, 프로세스에서 실행중인지 검사
if [ $file_chk != 0 ] && [ $ps_chk != 0 ];then

        #apache2 설정파일에서 파일 사이즈 용량 제한 설정인 "LimitRequestBody"를 확인
        if [ $opt_chk = 0 ];then
		echo "[-] U40. Web service file download limit config not set(/etc/apache2/apache2.conf), Result : Vul";
        else
                echo "[+] U40. Web service file download limit config is very well, Result : Good";
        fi
else
        echo "[+] U40. Web service is not installed"
fi



