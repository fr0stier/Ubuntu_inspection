#!/bin/bash

echo "[!] U17 $HOME, /etc hosts file check..."
count=0
etcown_check=`bash file_own.sh /etc/hosts.equiv 2>/dev/null | grep root | wc -w`
etcown_count=`bash file_own.sh /etc/hosts.equiv 2>/dev/null | wc -w`
etcpri_check=`bash file_Pri.sh /etc/hosts.equiv 2>/dev/null`
etcpri_count=`bash file_Pri.sh /etc/hosts.equiv 2>/dev/null | wc -w`
etcplus_chk=`cat /etc/hosts.equiv 2>/dev/null | grep \+ | wc -w`

#/etc/hosts.equiv 파일의 소유자가 root인지 확인
if [ $etcown_check = 0 ] && [ $etcown_check != 0 ];then
	echo "[-] U17 /etc/hosts.equiv file config is vulnerable Result : owner is not root"
	count=`expr $count + 1`
fi

#/etc/hosts.equiv 파일의 권한이 600이하인지 확인
if [ $etcpri_count != 0 ] && [ $etcpri_check -gt 0600 ];then
	echo "[-] U17 /etc/hosts.equiv file config is vulnerable Result : privilege is great than \"600\""
	count=`expr $count + 1`
fi

#/etc/hosts.equiv 파일에 '+' 설정이 되어있는지 확인
if [ $etcplus_chk != 0 ];then
	echo "[-] U17 /etc/hosts.equiv file config is vulnerable Result : file config \"+\""
fi

user_list=`ls /home | tr " " "\n"`
for i in ${user_list[@]}
do
	homeown_count=`bash file_own.sh /home/$i/.rhosts 2>/dev/null | wc -w`	
	homeown_check=`bash file_own.sh /home/$i/.rhosts | sed '/root/d' | sed "/$i/g" | wc -w`
	homepri_count=`bash file_Pri.sh /home/$i/.rhosts 2>/dev/null | wc -w`
	homepri_check=`bash file_Pri.sh /home/$i/.rhosts 2>/dev/null`
	etcplus_chk=`cat /home/$i/.rhosts 2>/dev/null | grep \+ | wc -w`

	#$HOME/.rhosts 파일의 소유자가 root인지 확인
	if [ $homeown_check != 0 ] && [ $homeown_count != 0 ];then
		echo "[-] U17 /home/$i/.rhosts file config is vulnerable Result : owner is not root or $i"
		count=`expr $count + 1`
	fi

	#$HOME/.rhosts 파일의 권한이 600이하인지 확인
	if [ $homepri_count != 0 ] && [ $homepri_check -gt 0600 ];then
		echo "[-] U17 /home/$i/.rhosts file config is vulnerable Result : privilege is great than \"600\""
		count=`expr $count + 1`
	fi

	#$HOME/.rhosts 파일에 '+' 설정이 되어있는지 확인
	if [ $etcplus_chk != 0 ];then
        	echo "[-] U17 /home/$i/.rhosts file config is vulnerable Result : file config \"+\""
	fi

done


