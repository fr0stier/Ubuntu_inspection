#!/bin/bash
echo "[!] U31. Spam mail relay denied check..."
cffile_chk=`bash file_chk.sh /etc/mail/sendmail.cf`

#파일이 존재하는지 검사
if [ $cffile_chk != 0 ];then
	conf_chk=`cat /etc/mail/sendmail.cf 2>/dev/null | grep "R$\*" | grep "Relaying denied" | grep -v "^#" | wc -l`
	
	#Relaying denied 옵션이 포함된 줄에 주석이 붙어있는지 검사(혹은 설정이 존재하는지)
	if [ $conf_chk = 0 ];then
		echo "[-] U31. Spam mail realy not denied(/etc/mail/sendmail.cf), Result : Vul"
	else
		echo "[+] U31. Spam mail realy denied, Result : Good"
	fi
else
	echo "[+] U31. Spam mail realy denied, Result : Good"
fi
