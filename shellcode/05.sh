#!/bin/bash

echo "[!] U05 Path directory Privilege Check..."
pathpri=0
home_pro=`cat $HOME/.profile | egrep "\.:|::|:.:" | wc -l`
etc_pro=`cat /etc/profile | egrep "\.:|::|:.:" | wc -l`

if [ $home_pro -ne 0 -o $etc_pro -ne 0 ];then
	pathpri=1
fi

if [ $pathpri != 0 ];then
        echo "[-] U05.Path directory Privilege config vulnerable, Result : Vul"
else
        echo "[+] U05.path directory Privilege config very well, Result : Good"
fi



