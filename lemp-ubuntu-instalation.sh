#!/bin/bash
# FRESH INSTALL OF LEMPP SERVER IN UBUNTU 16.04+
# THIS WILL INSTALL PHP 7.2 FASTCGI PROCESS MANAGER HANDLER
# VERSIONS CAN BE SWITCHED USING switch_php_version.sh SCRIPT
# BEFORE RUNNING THIS SCRIPT, MAKE SURE YOU ENTIRELY REMOVED ANY PREVIOUS NGINX-PHP-MYSQL INSTALLATION
# YOU CAN ALSO USE REMOVAL SCRIPT lampp_uninstall.sh
# RUN IT LIKE THIS:
# sh install_lampp_ubuntu.sh /home/emerson/sourcecode/ emerson
# VERSION 1.0 October 1 2018
# Org: Explicador Inc
# Author: Explicador Inc

# Script validation checks
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Instalation using 'apt'
# Run an update
sudo apt update;

# Install Nginx
sudo apt install nginx;

# Allowing trafic in 80 and 443 ports
sudo ufw allow 'Nginx HTTP';
sudo ufw allow 'Nginx HTTPS';

# Restart nginx
service nginx restart;

# Instalacao do mySql
sudo apt install mysql-server-5.7;

# Instalacao do php
sudo apt install php-fpm php-mysql;

# Restart nginx
sudo systemctl reload nginx;

# Criando o ficheiro de teste de instalacao de PHP
echo "<?php" > /var/www/html/info.php;
echo "phpinfo();" >> /var/www/html/info.php;

#
echo;
echo;
echo Instalação concluida com sucesso!!;
echo Pode testar o servidor da seguinte forma:;
echo "http://your_server_domain_or_IP/info.php";
