#!/bin/bash

echo "[!] U37. Web service parent directory access allow check..."

file_chk=`bash file_chk.sh /etc/apache2/apache2.conf`
ps_chk=`bash ps_chk.sh apache2`
opt_chk=`cat /etc/apache2/apache2.conf 2>/dev/null | grep -v "^#" | grep AllowOverride | grep -i "none" | wc -l`

#apache2가 설치되었는지, 프로세스에서 실행중인지 검사
if [ $file_chk != 0 ] && [ $ps_chk != 0 ];then

        #apache2 설정파일에서 상위 디렉토리 접근을 가능하게 하는 AllowOverride 설정에 "none" 옵션 확인
        if [ $opt_chk != 0 ];then
		echo "[-] U37. Web service parent directory access option enable(/etc/apache2/apache2.conf), Result : Vul";
        else
                echo "[+] U37. Web service parent directory access option disable, Result : Good";
        fi
else
        echo "[+] U37. Web service is not installed"
fi



