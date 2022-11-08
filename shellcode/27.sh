#!/bin/bash
echo "[!] U27. RPC service enable check..."
file_list=`ls -a /etc/xinetd.d`
counnt=0
for filename in ${file_list[@]}
do
	if [ $filename = "." ] || [ $filename = ".." ];then
		continue
	fi
	check_count=`cat /etc/xinetd.d/$filename | grep disable | awk -F "=" '{print $2}' | wc -w`
	check=`cat /etc/xinetd.d/$filename | grep disable | awk -F "=" '{print $2}' | grep yes | wc -w`
	
	if [ $check != $check_count ];then
		echo "[-] U27. RPC service is enable(/etc/xinetd.d/$filename), Result : Vul"
		count=`expr $count + 1`
	fi

done

if [ $count = 0 ];then
	echo "[+] U27. RPC service is disable, Result : Good"
fi



