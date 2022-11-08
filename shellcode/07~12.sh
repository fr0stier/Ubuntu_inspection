#!/bin/bash

array=("/etc/passwd" "/etc/shadow" "/etc/hosts" "/etc/xinetd.conf" "/etc/rsyslog.conf" "/etc/services")
intarray=("0644" "0600" "0600" "0600" "0640" "0644")
count=0
for path in ${array[@]}
do
        arr=`bash file_Pri.sh $path`
        own=`bash file_own.sh $path`
	tmp=`bash file_Pri.sh $path | wc -l`

        if [ $tmp = 0 ];then
                arr=0
                own="root"
        fi

        if [ $path = "/etc/passwd" ];then
                echo ""
                echo "[!] U07 /etc/passwd owner & privilege Check..."
                if [ $arr -gt ${intarray[$count]} -o $own != "root" ];then
                echo "[-] U07 /etc/passwd owner & privilege config vulnerable, Result : Vul"
                else
                echo "[+] U07 /etc/passwd owner & privilege config very well, Result : Good"
                fi
        fi

        if [ $path = "/etc/shadow" ];then
                echo ""
                echo "[!] U08 /etc/shadow owner & privilege Check..."
                if [ $arr -gt ${intarray[$count]} -o $own != "root" ];then
                echo "[-] U08 /etc/shadow owner & privilege config vulnerable, Result : Vul"
                else
                echo "[+] U08 /etc/shadow owner & privilege config very well, Result : Good"
                fi
        fi

        if [ $path = "/etc/hosts" ];then
                echo ""
                echo "[!] U09 /etc/hosts owner & privilege Check..."
                if [ $arr -gt ${intarray[$count]} -o $own != "root" ];then
                echo "[-] U09 /etc/hosts owner & privilege config vulnerable, Result : Vul"
                else
                echo "[+] U09 /etc/hosts owner & privilege config very well, Result : Good"
                fi
        fi

        if [ $path = "/etc/xinetd.conf" ];then
                echo ""
                echo "[!] U10 /etc/xinetd.conf owner & privilege Check..."
                if [ $arr -gt ${intarray[$count]} -o $own != "root" ];then
                echo "[-] U10 /etc/xinetd.conf owner & privilege config vulnerable, Result : Vul"
                else
                echo "[+] U10 /etc/ixnetd.conf owner & privilege config very well, Result : Good"
                fi
        fi

        if [ $path = "/etc/rsyslog.conf" ];then
                echo ""
                echo "[!] U11 /etc/rsyslog.conf owner & privilege Check..."
                if [ $arr -gt ${intarray[$count]} -o $own != "root" ];then
                echo "[-] U11 /etc/rsyslog.conf owner & privilege config vulnerable, Result : Vul"
                else
                echo "[+] U11 /etc/rsyslog.conf owner & privilege config very well, Result : Good"
                fi
        fi

        if [ $path = "/etc/services" ];then
                echo ""
                echo "[!] U12 /etc/services owner & privilege Check..."
                if [ $arr -gt ${intarray[$count]} -o $own != "root" ];then
                echo "[-] U12 /etc/services owner & privilege config vulnerable, Result : Vul"
                else
                echo "[+] U12 /etc/services owner & privilege config very well, Result : Good"
                fi
        fi

        count=`expr $count + 1`
done
