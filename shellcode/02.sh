#!/bin/bash

echo "[!] U02 Password File check..."
feild=`cat /etc/pam.d/common-password | grep password | grep required | grep pam_cracklib.so | tr " " "\n"`
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
