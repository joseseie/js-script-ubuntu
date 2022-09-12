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
sudo apt install mysql-server;

# Politica de definição de senha, isso permitirá que se defina a senha do root no fim.
sudo mysql_secure_installation;

# Instalacao do php
sudo apt install php-fpm php-mysql;

# Instalacao dos repositorios de terceiros,...
sudo apt install software-properties-common;
sudo add-apt-repository ppa:ondrej/php;

# Instalacao de php 7.4
sudo apt update;
sudo apt install php7.4-fpm;

sudo apt-get install php7.4-cli php7.4-fpm php7.4-curl php7.4-gd php7.4-mysql php7.4-mbstring zip unzip;

sudo apt update;
sudo apt -y install unzip zip php7.4 php7.4-mysql php7.4-fpm php7.4-mbstring php7.4-xml php7.4-curl php7.4-xml php-dev php-pear libmcrypt-dev;

# Instalacao de php 8.0
sudo apt update;
sudo apt install php8.0-fpm;

sudo apt-get install php8.0-cli php8.0-fpm php8.0-curl php8.0-gd php8.0-mysql php8.0-mbstring zip unzip;

sudo apt -y install unzip zip php8.0 php8.0-mysql php8.0-fpm php8.0-mbstring php8.0-xml php8.0-curl php8.0-xml php-dev php-pear libmcrypt-dev;

# Instalacao de php 8.1
sudo apt update;
sudo apt install php8.1-fpm;

sudo apt-get install php8.1-cli php8.1-fpm php8.1-curl php8.1-gd php8.1-mysql php8.1-mbstring zip unzip;

sudo apt -y install unzip zip php8.1 php8.1-mysql php8.1-fpm php8.1-mbstring php8.1-xml php8.1-curl php-dev php-pear libmcrypt-dev;


# ====================================================
# Definindo PHP 7.4 como default
# ====================================================

sudo update-alternatives --set php /usr/bin/php7.4;

# ====================================================
# Instalacao do PHP myAdmin
# ====================================================

sudo apt update;
sudo apt install phpmyadmin;

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

sudo service php7.4-fpm restart;
sudo service nginx restart;

# =====================================================
# Informacoes de teste do servidor
# =====================================================

# Criando o ficheiro de teste de instalacao de PHP
echo "<?php" > /var/www/html/info.php;
echo "phpinfo();" >> /var/www/html/info.php;

#
echo;
echo;
echo Instalação concluida com sucesso!!;
echo NOTA: Não esquece de actualizar o 'server name', no: /etc/nginx/sites-availables/default;
echo;
echo Pode testar o servidor da seguinte forma:;
echo "http://your_server_domain_or_IP/info.php";
echo Esse é o seu ip:;
curl -4 icanhazip.com;
