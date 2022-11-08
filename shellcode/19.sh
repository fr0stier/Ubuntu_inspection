#!/bin/bash
echo "[!] U19. Finger service enable check..."
finger_chk=`find /usr/bin -name finger | wc -w`

if [ $finger_chk = 0 ];then
	echo "[+] U19. Finger service disable, Result : Good"
else
	echo "[-] U19. Finger service enable, Result : Vul"
fi
