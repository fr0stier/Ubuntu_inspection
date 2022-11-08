#!/bin/basuh

echo "[!] U20. anonymous ftp enable check..."
#ftp 계정 존재 유무 확인
ftpacc_chk=`cat /etc/passwd | grep ftp | wc -l`

#anonymous ftp 설정 확인
ftpcon_chk=`cat /etc/vsftpd.conf | grep anonymous | awk -F "=" '{print $2}'`

if [ $ftpacc_chk != 0 ] && [ "$ftpcon_chk" != "NO" ];then
	echo "[-] U20. anonymous ftp enable(/etc/vsftpd.conf), Result : Vul"
else
	echo "[+] U20. anonymous ftp disable(/etc/vsftpd.conf), Result : Good"
fi




