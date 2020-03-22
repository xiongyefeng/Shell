#!/bin/bash
ftp -n -i 192.168.206.7 <<!
user zhangsan 123456
cd upload
mput *.log
mget *.txt
bye
!