#!/bin/bash

echo ""
echo "[!] U14 /home/user sys & env file config Check..."
echo "--------------------------------------------------"
user=`ls /home | tr '  ' ' '`
count=0
for i in ${user[@]}
do
	#환경변수 파일은 홈디렉토리 밑에 .으로 시작하는 파일이므로 해당 파일만 가져옴.
	path=`ls -al /home/$i | awk -F " " '{print $9}' | grep "^\."`
	
	for file_path in ${path[@]}
	do
		#현재 경로를 뜻하는 '.'나, 이전 경로를 뜻하는 '..' 배제
		if [ $file_path = "." ] || [ $file_path = ".." ];then
			continue
		fi
		
		file_path="/home/$i/$file_path"

		#소유자가 본인 혹은 root인지 확인
		usercheck=`bash file_own.sh $file_path | grep "root\|$i" | wc -w`
		check_cont=`bash file_own.sh $file_path | wc -w`
	
		#작업 결과 중, 빈 디렉토리가 나올 경우 검사에서 배제.
		if [ $check_cont = 0 ];then
			continue
		fi

		if [ $usercheck = 0 ];then
			if [[ $usercheck != " " ]];then
				echo "$file_path owner is other!"
                		count=`expr $count + 1`
			fi
        	fi


		#해당 경로의 권한 가져오기
		file_write=`bash file_Pri.sh $file_path`

		#group부분 쓰기 권한 검사
		if [ ${file_write:2:1} -eq 2 ] || [ ${file_write:2:1} -eq 3 ] || [ ${file_write:2:1} -eq 6 ] || [ ${file_write:2:1} -eq 7 ];then
                        echo "$file_path is group can write!"
                        count=`expr $count + 1`
                fi
		#other부분 쓰기 권한 검사
                if [ ${file_write:3:1} -eq 2 ] || [ ${file_write:3:1} -eq 3 ] || [ ${file_write:3:1} -eq 6 ] || [ ${file_write:3:1} -eq 7 ];then
			echo "$file_path is other can write!"
                       	count=`expr $count + 1`
                fi
	done
done

echo "--------------------------------------------------"
if [ $count -eq 0 ];then
        echo "[+] U14 /home/user sys & env file config very well, Result : Good"
else
        echo "[-] U14 /home/user sys & env file config vulnerable, Result : Vul"
fi

