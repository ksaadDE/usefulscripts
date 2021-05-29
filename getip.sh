#!/bin/bash
#wget https://ip-check.info/
ip=$(curl --silent -L https://ip-check.info | grep "document.write" | grep -v -i "Start Test" | cut -d ">" -f2 | cut -d"<" -f1)
echo $ip;
