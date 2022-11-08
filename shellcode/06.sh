#!/bin/bash

echo "[!] U06 file&directory owner is empty Check..."

usercheck=`sudo find / -nouser -print 2>/dev/null | wc -l`
groupcheck=`sudo find / -nogroup -print 2>/dev/null | wc -l`
ugcheck=`expr $usercheck + $groupcheck`
if [ $ugcheck != 0 ];then
        echo "[-] U06.empty owener file or directory config vulnerable, Result : Vul"
else
        echo "[+] U06.empty owener file or directory config very well, Result : Good"
fi

