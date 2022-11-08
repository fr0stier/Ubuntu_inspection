echo "[!] U01 root remote connect check..."
if [ `ps -ef | grep xinetd | grep -v grep | wc -l` -ne 0 ]; then
        if [ `cat /etc/xinetd.d/telnet | grep disable | grep no | wc -l` -ne 0 ]; then
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

if [ `ps -ef | grep ssh | grep -v grep | wc -l` -ne 0 ]; then
        if [ `cat /etc/ssh/sshd_config | grep -x "PermitRootLogin No" | wc -l` -ne 0 ] ; then
                echo "[+] U01.ssh config very well, Result : Good"
        else
                echo "[-] U01.ssh config vulnerable, Result : Vul"
        fi
fi
