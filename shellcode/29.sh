#!/bin/bash
echo "[!] U29. tftp, talk service enable check..."
tftp_chk=`bash file_chk.sh /usr/bin/tftp`
talk_chk=`bash file_chk.sh /usr/bin/talk`
tftp_ps=`bash ps_chk.sh tftp`
talk_ps=`bash ps_chk.sh talk_ps`
count=0

if [ $tftp_chk != 0 ] || [ $tftp_ps != 0 ];then
	echo "[-] U29. tftp service enable, Result : Vul"
	count=`expr $count + 1`
fi
if [ $talk_chk != 0 ] || [ $talk_ps != 0 ];then
	echo "[-] U29. talk service enable, Result : Vul"
	count=`expr $count + 1`
fi

if [ $count = 0 ];then
	echo "[+] U29. tftp, talk service disabled, Result : Good"
fi




