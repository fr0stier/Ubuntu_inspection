#!/bin/bash

echo "[!] U01 root remote connect check..."
if [ `ps -ef | grep xinetd | grep -v grep | wc -l` -ne 0 ]; then
	if [ `cat /etc/xinetd.d/telnet | grep disable | grep no | wc -l` -gt 0 ]; then
		if [ `cat /etc/pam.d/login | grep pam_securetty.so | grep requied | wc -l` -ne 0 ]; then
			if [ `cat /etc/securetty | grep "pts/" | wc -l` -ne 0 ]; then
				echo "[-] U01.telnet service config vulnerable, Result : Vul"
			else 
				echo "[+] U01.telnet service config very well, Result : Good"
			fi
		else
			echo "[-] U01.telnet service config vulnerable, Result : Vul"
		fi	

	else		
		echo "[+] U01.telnet service not running. Result : Good"
	fi
else
	echo "[+] U01.xinetd service not running. Result : Good"
fi

echo "[!] U01 ssh setting check..."
if [ `ps -ef | grep ssh | grep -v grep | wc -l` -ne 0 ]; then
	if [ `cat /etc/ssh/sshd_config | grep -x "PermitRootLogin No" | wc -l` -ne 0 ] ; then
		echo "[+] U01.ssh config very well, Result : Good"
	else
		echo "[-] U01.ssh config vulnerable, Result : Vul"
	fi
fi

echo ""
echo "[!] U02 Password File check..."
feild=`cat /etc/pam.d/common-password | grep minlen | tr " " "\n"`
count=0
for i in $feild
do
	if [ $i = "lcredit=-1" ];then
		count=`expr $count + 1`
	fi	
	if [ $i = "ucredit=-1" ];then
		count=`expr $count + 1`
	fi
	if [ $i = "dcredit=-1" ];then
		count=`expr $count + 1`
	fi
	if [ $i = "ocredit=-1" ];then
		count=`expr $count + 1`
	fi
	if [ $i = "minlen=8" ];then
		count=`expr $count + 1`
	fi
	if [ $i = "difok=N" ];then
		count=`expr $count + 1`
	fi
done
if [ $count != 6 ];then
	echo "[-] U02.pass file config vulnerable, Result : Vul"
else
	echo "[+] U02.pass file config very well, Result : Good"
fi

echo ""
echo "[!] U03 account lock limit check..."
t1=`cat /etc/pam.d/common-auth | grep no_magic_root | wc -l`
t2=`cat /etc/pam.d/common-auth | grep deny=5 | wc -l`
t3=`cat /etc/pam.d/common-auth | grep unlock_time | wc -l`
t4=`cat /etc/pam.d/common-auth | grep reset | wc -l`
t5=`expr $t1 + $t2 + $t3 + $t4`

if [ $t5 -lt 4 ];then
	echo "[-] U03.account lock limit config vulnerable, Result : Vul"
else
	echo "[+] U03.account lock limit config very well, Result : Good"
fi

echo ""
echo "[!] U04 password file protect check..."
passwdCheck=$(cat /etc/passwd | awk -F: '{print $2}' | tr " " "\n")
passCount=0
for passwdCheck in $passwdCheck
do
	if [ $passwdCheck != "x" ];then
		passCount=`expr $passCount + 1`
	fi
done
if [ $passCount -eq 0 ];then
	echo "[+] U04.Password File Protect config very well, Result : Good"
else
	echo "[-] U04.Password File Protect config vulnerable, Result : Vul"
fi

echo ""
echo "[!] U05 Path directory Privilege Check..."
pathpri=0

#pathDir=`cat $HOME/.profile | grep PATH | grep -v "#" | awk -F':' '{print $1}' | awk -F'"' '{print $2}' | awk -F'.' '{print $2}'`
pathDir=`cat $HOME/.profile | grep PATH | grep -v "#" | awk -F':' '{print $1}' | awk -F'"' '{print $2}' | awk -F'$' '{print $1}'`

for p in $pathDir
do
	if [ $p != "" ];then
		pathpri=`expr $pathpri + 1`
	fi
done


#pathDir=`cat /etc/profile | grep PATH | grep -v "#" | awk -F':' '{print $1}' | awk -F'"' '{print $2}' | awk -F'.' '{print $2}'`
#pathDir=`cat /etc/profile | grep PATH | grep -v "#" | awk -F':' '{print $1}' | awk -F'"' '{print $2}' | awk -F'$' '{print $1}'`

#for p in $pathDir
#do
#	if [ $p != "" ];then
#		pathpri=`expr $pathpri + 1`
#	fi
#done
dotcheck=`cat /etc/profile | grep bashrc | tr "/" "\n"`
for l in $dotcheck
do
        if [ $l = "." ];then
                pathpri=`expr $pathpri + 1`
        fi
done

if [ $pathpri != 0 ];then
	echo "[-] U05.Path directory Privilege config vulnerable, Result : Vul"
else
	echo "[+] U05.path directory Privilege config very well, Result : Good"
fi

echo ""
echo "[!] U06 file&directory owner is empty Check..."

usercheck=`sudo find / -nouser -print 2>/dev/null | wc -l`
groupcheck=`sudo find / -nogroup -print 2>/dev/null | wc -l`
ugcheck=`expr $usercheck + $groupcheck`
if [ $ugcheck != 0 ];then
	echo "[-] U06.empty owener file or directory config vulnerable, Result : Vul"
else
	echo "[+] U06.empty owener file or directory config very well, Result : Good"
fi

array=("/etc/passwd" "/etc/shadow" "/etc/hosts" "/etc/inetd.conf" "/etc/rsyslog.conf" "/etc/services")
intarray=("0644" "0600" "0600" "0600" "0640" "0644")
count=0
for path in ${array[@]}
do
	arr=`bash file_Pri.sh $path`
	own=`bash file_own.sh $path`

        if [ $path = "/etc/passwd" ];then
                echo ""
                echo "[!] U07 /etc/passwd owner & privilege Check..."
		if [ $arr -gt ${intarray[$count]} -o $own != 1 ];then
                echo "[-] U07 /etc/passwd owner & privilege config vulnerable, Result : Vul"
                else
                echo "[+] U07 /etc/passwd owner & privilege config very well, Result : Good"
                fi
        fi

        if [ $path = "/etc/shadow" ];then
                echo ""
                echo "[!] U08 /etc/shadow owner & privilege Check..."
                if [ $arr -gt ${intarray[$count]} ];then
                echo "[-] U08 /etc/shadow owner & privilege config vulnerable, Result : Vul"
                else
                echo "[+] U08 /etc/shadow owner & privilege config very well, Result : Good"
                fi
        fi

        if [ $path = "/etc/hosts" ];then
                echo ""
                echo "[!] U09 /etc/hosts owner & privilege Check..."
                if [ $arr -gt ${intarray[$count]} ];then
                echo "[-] U09 /etc/hosts owner & privilege config vulnerable, Result : Vul"
                else
                echo "[+] U09 /etc/hosts owner & privilege config very well, Result : Good"
                fi
        fi

        if [ $path = "/etc/inetd.conf" ];then
                echo ""
                echo "[!] U10 /etc/inetd.conf owner & privilege Check..."
                if [ $arr -gt ${intarray[$count]} ];then
                echo "[-] U10 /etc/inetd.conf owner & privilege config vulnerable, Result : Vul"
                else
                echo "[+] U10 /etc/inetd.conf owner & privilege config very well, Result : Good"
                fi
        fi

        if [ $path = "/etc/rsyslog.conf" ];then
                echo ""
                echo "[!] U11 /etc/rsyslog.conf owner & privilege Check..."
                if [ $arr -gt ${intarray[$count]} ];then
                echo "[-] U11 /etc/rsyslog.conf owner & privilege config vulnerable, Result : Vul"
                else
                echo "[+] U11 /etc/rsyslog.conf owner & privilege config very well, Result : Good"
                fi
        fi

        if [ $path = "/etc/services" ];then
                echo ""
                echo "[!] U12 /etc/services owner & privilege Check..."
                if [ $arr -gt ${intarray[$count]} ];then
                echo "[-] U12 /etc/services owner & privilege config vulnerable, Result : Vul"
                else
                echo "[+] U12 /etc/services owner & privilege config very well, Result : Good"
                fi
        fi

        count=`expr $count + 1`
done
