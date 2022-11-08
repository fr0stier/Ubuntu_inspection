#!/bin/bash

echo "[!] U39. Web service link enable check..."

file_chk=`bash file_chk.sh /etc/apache2/apache2.conf`
ps_chk=`bash ps_chk.sh apache2`
opt_chk=`cat /etc/apache2/apache2.conf 2>/dev/null | grep -v "^#" | grep Options | grep -v - | grep -i "FollowSymLinks" | wc -l`

#apache2가 설치되었는지, 프로세스에서 실행중인지 검사
if [ $file_chk != 0 ] && [ $ps_chk != 0 ];then

        #apache2 설정파일에서 심볼릭 링크 사용설정인 Options 설정에 "FollowSymLinks" 옵션 확인
        if [ $opt_chk != 0 ];then
		echo "[-] U39. Web service link enable(/etc/apache2/apache2.conf), Result : Vul";
        else
                echo "[+] U39. Web service link disable, Result : Good";
        fi
else
        echo "[+] U39. Web service is not installed"
fi



