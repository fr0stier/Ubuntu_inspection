#!/bin/bash

echo "[!] U41. Web service root directory path config check..."

file_chk=`bash file_chk.sh /etc/apache2/sites-available/000-default.conf`
ps_chk=`bash ps_chk.sh apache2`
opt_chk=`cat /etc/apache2/sites-available/000-default.conf | grep -v "^#" | grep DocumentRoot | awk -F " " '{print $2}' | tr -d " "`
opt_count=`cat /etc/apache2/sites-available/000-default.conf | grep -v "^#" | grep DocumentRoot | wc -l`
check_list=("/usr/local/apache2/htdocs" "/var/www/html")
count=0

#apache2가 설치되었는지, 프로세스에서 실행중인지 검사
if [ $file_chk != 0 ] && [ $ps_chk != 0 ];then

        #아파치 사이트 기본설정파일에서 "DocumentRoot" 설정 존재 확인
        if [ $opt_count = 0 ];then
		echo "[-] U41. Web service root directory path config not set(/etc/apache2/apache2.conf), Result : Vul";
        else
		
		#설정되지 않아야 할 경로가 설정되어 있는지 확인
		for path in ${check_list[@]}
		do
			if [ $opt_chk = $path ];then
				count=`expr $count + 1`
			fi
		done

		if [ $count = 0 ];then
			echo "[+] U41. Web service root directory path config is very well, Result : Good"
		else
			echo "[-] U41. Web service root directory path config is vulnerable (not \"/usr/local/apache2/htdocs\" or \"/var/www/hteml\"), Result : Vul"
		fi
	
        fi
else
        echo "[+] U41. Web service is not installed"
fi



