#!/bin/bash
cat /var/log/secure|awk '/Failed/{if($(NF-3)~/[[:digit:]]/){print $(NF-3)}}'|sort|uniq -c|awk '{print $2"="$1}' >/root/black
DEFINE=3
for i in `cat /root/black`
do
	IP=`echo $i |awk -F= '{print $1}'`
	NUM=`echo $i|awk -F= '{print $2}'`
	if [ $NUM -gt $DEFINE ];
	then
		if [ $IP == 49.73.82.153 ]; then
			continue
		fi
		grep $IP /etc/hosts.deny &> /dev/null
		if [ $? -gt 0 ];
		then
			echo "sshd:$IP" >> /etc/hosts.deny
		fi
	fi
done
