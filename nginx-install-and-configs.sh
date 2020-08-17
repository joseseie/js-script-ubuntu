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
sudo ufw allow 'OpenSSH';
sudo ufw enable;


# Instalacao do mySql
sudo apt install mysql-server-5.7;

# Instalacao do php
sudo apt install php-fpm php-mysql;

# Instalacao dos repositorios de terceiros,...
sudo apt install software-properties-common;
sudo add-apt-repository ppa:ondrej/php;
sudo apt install python-software-properties;

# Instalacao de php 7.2
sudo apt update;
sudo apt install php7.2-fpm;

sudo apt-get install php7.2-cli php7.2-fpm php7.2-curl php7.2-gd php7.2-mysql php7.2-mbstring zip unzip;

sudo apt update;
sudo apt -y install unzip zip php7.2 php7.2-mysql php7.2-fpm php7.2-mbstring php7.2-xml php7.2-curl php7.2-xml php-dev php-pear libmcrypt-dev;

# ====================================================
# Instalacao do PHP myAdmin
# ====================================================

sudo apt-get update;
sudo apt-get install phpmyadmin;

# Criando o link
sudo ln -s /usr/share/phpmyadmin /var/www/html;

# ====================================================
# Reiniciando nginx
# ====================================================

echo copiando p ficheiro de configurações;
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bk;
sudo rm /etc/nginx/sites-available/default;
sudo cp default /etc/nginx/sites-available/;

# =====================================================
# Instalacao do composer
# =====================================================

cd ~;
sudo curl -sS https://getcomposer.org/installer | php;
sudo mv composer.phar /usr/local/bin/composer;

# Clonando o projecto do github

sudo git clone $repo;

#Entrando no dir do projecto clonado
cd $dir

#instalando as dependencias
composer install;

# Permissoes para o Projecto (actualize aqui para o seu projecto especifico)
sudo chown -R :www-data $dir #dir do projecto
sudo chmod -R 775 $dir/storage
sudo chmod -R 775 $dir/bootstrap/cache;

# ====================================================
# Instalacao do supervisor, para correr o queue:work
# ====================================================

sudo apt install supervisor;

# Copiando o ficheiro de configurações
cp /home/ubuntu/js-script-ubuntu/laravel-worker.conf /etc/supervisor/conf.d/;

#Starting Supervisor
sudo supervisorctl reread;
sudo supervisorctl update;
sudo supervisorctl start laravel-worker:*;


# ====================================================
# Reiniciando nginx
# ====================================================

sudo service php7.2-fpm restart;
sudo service nginx restart;

