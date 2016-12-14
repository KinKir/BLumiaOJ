#!/bin/bash
#OJ Install Script for Debian 8

#Configure variables
WWW_PATH=/var/www/html/
JUDGER_USER=judge
HTTPD_USER=www-data
DB_USER=root
DB_PASSWORD=root

#Install dept package
sudo apt-get install flex g++ libmysql++-dev php5 apache2 mysql-server php5-mysql php5-gd php5-cli mono-gmcs git make

#Start MySQL service
sudo service mysql start

#Fetch source code
git clone https://github.com/BLumia/BLumiaOJ.git --depth=1
git clone https://github.com/zhblue/hustoj.git --depth=1

#Judger account
sudo useradd -m -u 1536 $JUDGER_USER

#Compile Judger
sudo ./hustoj/beta/core/make.sh

#Running database sql and copy www data
sudo cp -r BLumiaOJ/webframe/ $WWW_PATH/OnlineJudge/
sudo chmod -R 771 $WWW_PATH/OnlineJudge/
sudo chown -R $HTTPD_USER $WWW_PATH/OnlineJudge/
sudo mysql -h localhost -u$DB_USER -p$DB_PASSWORD < BLumiaOJ/utils/sql_runner/db.sql

#Creating folder for Judger
sudo mkdir /home/$JUDEGR_USER/etc
sudo mkdir /home/$JUDEGR_USER/data
sudo mkdir /home/$JUDEGR_USER/log
sudo mkdir /home/$JUDEGR_USER/run0
sudo mkdir /home/$JUDEGR_USER/run1
sudo mkdir /home/$JUDEGR_USER/run2
sudo mkdir /home/$JUDEGR_USER/run3
cd hustoj/beta/install/
sudo cp java0.policy judge.conf /home/$JUDEGR_USER/etc
sudo chown -R $JUDEGR_USER /home/$JUDEGR_USER