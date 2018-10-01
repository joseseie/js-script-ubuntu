#!/bin/bash
# FRESH INSTALL OF LAMPP SERVER IN UBUNTU 16.04+
# THIS WILL INSTALL PHP 7.1 AND 7.2 FASTCGI PROCESS MANAGER HANDLER
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

# Run an update
apt-get update;

# Install MySQL 5.7 -now default in Ubuntu 16.04
apt-get -y install mysql-server mysql-client;

# Install Nginx
sudo apt install nginx;

# Install HP 7.2, PHP 7.1, PHP 7.0 and PHP 5.6 FastCGI process manager (FPM)
apt-get install php7.2-fpm php7.1-fpm;

# Enable proxy_fcgi module
a2enmod proxy_fcgi setenvif;

# Enable php7.2-fpm configuration as default (not PHP 7.1 but this can switched easily if needed)
a2enconf php7.2-fpm;

# Reload nginx
service nginx reload;

# Install PHP 7.2, PHP 7.1 MySQL extension
apt-get install php7.2-mysql php7.1-mysql;

# Install important PHP developer libraries in their  7.2, 7.1 versions
apt-get install php7.2-curl php7.1-curl php7.2-gd php7.1-gd php7.2-intl php7.1-intl php-pear php7.2-imap php7.1-imap php7.2-mcrypt php7.1-mcrypt php7.2-ps php7.1-ps php7.2-pspell php7.1-pspell php7.2-recode php7.1-recode php7.2-snmp php7.1-snmp php7.2-sqlite php7.1-sqlite php7.2-tidy php7.1-tidy php7.2-xmlrpc php7.1-xmlrpc php7.2-xsl php7.1-xsl php7.2-zip php7.1-zip php7.2-xml php7.1-xml php7.2-dev php7.1-dev; 

# Run an update
apt-get update;

# Install phpMyadmin and its dependencies
apt-get install phpmyadmin php7.2-mbstring php7.1-mbstring php-gettext;

# Update working home Apache directories
# rpl "/var/www/" $1 /etc/apache2/apache2.conf;
# notrailing=${1%/};
# rpl "/var/www/html" $notrailing /etc/apache2/sites-available/000-default.conf;
# rpl "/var/www/html" $notrailing /etc/apache2/sites-available/default-ssl.conf;

# Update user targeting default PHP 7.0/7.1/5.6 FPM
#rpl "www-data" $2 /etc/php/7.2/fpm/pool.d/www.conf;
#rpl "www-data" $2 /etc/php/7.1/fpm/pool.d/www.conf;
#rpl "www-data" $2 /etc/php/7.0/fpm/pool.d/www.conf;
#rpl "www-data" $2 /etc/php/5.6/fpm/pool.d/www.conf;
#rpl "www-data" $2 /etc/apache2/envvars;

# Include phpMyadmin configuration file
# echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf;

# Enable mod rewrite module
a2enmod rewrite;

# Enable SSL module
a2enmod ssl;

# Set PHP 7.2 as default CLI, php-config and phpize (when you switch versions these should be changed also)
update-alternatives --set php /usr/bin/php7.2
update-alternatives --set php-config /usr/bin/php-config7.2
update-alternatives --set phpize /usr/bin/phpize7.2

# Reload PHP 7.2 FPM
service php7.2-fpm reload;

# Restart nginx
service nginx restart;
