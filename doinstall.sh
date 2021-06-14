#!/bin/bash
#
# Written by ksaadDE (29 May 2021)
#
# Mondial Database Install Script 

deleteAfterStop=true
port="8080"
protocol="http"
browser="firefox"
mariadbrootpass="thisisnotagoodpassword!"
servicename='mondialdatabase'
adminerContainerName=$servicename"_adminer_1"

# Mondial Database SQL File Downloads
linkMondialScheme="https://www.dbis.informatik.uni-goettingen.de/Mondial/OtherDBMSs/mondial-schema-mysql.sql"
linkMondialData="https://www.dbis.informatik.uni-goettingen.de/Mondial/OtherDBMSs/mondial-inputs-mysql.sql"

echo "[i] Downloading mondial SQL Files, so you can just upload them later to adminer"
wget $linkMondialScheme &> /dev/null
wget $linkMondialData &> /dev/null
echo "[+] Done Downloading mondial SQL Files"

echo -e "\t\t [INSTALL Docker-Compose Service and Containers]"
echo "[i] Creating Docker-Compose.yml - if a old yml exists, this step overwrites it - not abortable!"

# fill the docker-compose.yml
echo "version: '3'

services:
  db:
    image: mariadb
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: $mariadbrootpass

  adminer:
    image: adminer
    restart: always
    ports:
      - $port:$port
" > docker-compose.yml
echo "[+] Completed writing docker-compose.yml"

echo "[i] Building Docker-compose Service with name $servicename"
docker-compose -p "$servicename" up -d &> /dev/null
echo "[+] Completed"

mysqlrootPass=$(cat docker-compose.yml | grep -e "MYSQL_ROOT_PASSWORD" | cut -d":" -f2)

# öffnet einen Browser mit <protocol>://dockerIP>:<port> (also z.B. Firefox mit http://172...:80/)
ip=$(docker inspect $(docker ps -a | grep -e "$adminerContainerName"| cut -d" " -f1) | grep -e 'IPAddress":' | grep -v '""' | cut -d'"' -f4); 


# Open Browser and do output stuff
link=$protocol://$ip:$port

echo -e "\t\t [START BROWSER]"

# Print Adminer Webinterface Link
echo "[=] Link: $link";
# Print MySQL Root Pass
echo "[=] MySQL Root Password: $mysqlrootPass";

# Start the Browser with specified URL
echo "[i] Starting the specified Browser:  $browser with $ulink"
$browser "$link"
echo "[+] Browser is closed now.."
echo -e "\t\t [AFTER CLOSE OF BROWSER]"

echo "[i] checking if deleteAfterStop is active..."
# UNINSTALL -change the var deleteAfterStop to false, if not intended
if [ deleteAfterStop ]; then
	echo -e "\t\t [DELETING SERVICE, CONTAINER, NETWORKS...]"
	echo "[i] Stopping and deleting the docker-compose service (containers, content, vols, networks etc) | Reason: deleteAfterStop is active!";
	docker-compose -p "$servicename" down &> /dev/null
	echo "[+] Completed stopping and deleting the containers";
fi
echo -e "\t\t [EXIT]"
echo "[+] Done ;-) EXIT"
