#!/bin/bash
echo "[!] U32. nomal user sendmail q option enable check..."
file_chk=`bash file_chk.sh /etc/mail/sendmail.cf`

#파일 유효성 검사
if [ $file_chk != 0 ];then

	config_chk=`grep -v '^ *#' /etc/mail/sendmail.cf | grep PrivacyOptions | grep restrictqrun | wc -l`

	#PrivacyOptions 설정에 restrictqurun 옵션이 설정되어있는지 검사
	if [ $config_chk = 0 ];then
		echo "[-] U32. q option denie not set(/etc/mail/sendmail.cf), Result : Vul"
	else
		echo "[+] U32. q option denie set, Result : Good"
	fi
else
	echo "[+] U32. q option denie set, Result : Good"
fi
