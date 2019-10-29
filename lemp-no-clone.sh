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
# Definindo PHP 7.2 como default
# ====================================================

sudo update-alternatives --set php /usr/bin/php7.2;

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

# =====================================================
# Instalacao do projecto Laravel para testes
# =====================================================
echo "Asseguir vai criar o directório /var/www/laravel e criar um Projecto laravel com o nome test"
# Criacao de pasta Laravel no /var/www/
sudo mkdir -p /var/www/laravel;

# Criar um novo projecto Laravel para testes
sudo composer create-project laravel/laravel /var/www/laravel/test;


# ===> Permissões ao directório d Projecto:
sudo chown -R :www-data /var/www/laravel/test;
sudo chmod -R 775 /var/www/laravel/test/storage;
sudo chmod -R 775 /var/www/laravel/test/bootstrap/cache;



# ====================================================
# Reiniciando nginx
# ====================================================

sudo service php7.2-fpm restart;
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
echo NOTA 1: Não esquece de actualizar o 'server name', no: /etc/nginx/sites-availables/default;
echo NOTA 2: Não esquece de definir permissões de Leitura ao seu projecto Laravel;
echo NOTA 3: Use este comando: sudo nano /etc/php/7.2/fpm/php.ini;
echo "Descomente e atribui valor zero (0) na linha 'cgi.fix_pathinfo' como vês asseguir: ";
echo cgi.fix_pathinfo=0;
echo Depois reiniciar: sudo service php7.2-fpm restart;
echo;
echo Pode testar o servidor da seguinte forma:;
echo "http://your_server_domain_or_IP/info.php";
echo Esse é o seu ip:;
curl -4 icanhazip.com;




