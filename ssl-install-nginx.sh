#!/bin/bash
# Instalation OF SSL Certificate ON YOUR SERVER
# VERSION 1.0 October 10 2018
# Org: Explicador Inc
# Author: Explicador Inc
# PRE REQUISITIES: 
# Step 1 – INSTALLING NGINX
# sudo apt update
# sudo apt install nginx
# Step 2 – ADJUSTING THE FIREWALL
# sudo ufw status
# sudo ufw enable
# sudo ufw status
# sudo ufw allow 'Nginx HTTP'
# sudo ufw allow 'openssh'
# sudo ufw status
# Step 3 – CHECKING YOUR WEB SERVER 
# systemctl status nginx
#1. Edit your: 
#sudo nano /etc/nginx/sites-available/default
#2. Add the server name: 
#server_name example.com www.example.com;
#3. You Can Test your configs: 
#sudo nginx -t
#4. Restart Nginx:
#sudo systemctl reload nginx

# Script validation checks
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

#Installing Certbot
#Certbot is in very active development, so the Certbot packages provided by Ubuntu tend to be outdated. However, the Certbot 
#developers maintain a Ubuntu software repository with up-to-date versions, so we'll use that repository instead.
sudo add-apt-repository ppa:certbot/certbot;

sudo apt update;

sudo apt install python3-certbot-nginx;

#Allowing HTTPS Through the Firewall
sudo ufw allow 'Nginx Full';
sudo ufw delete allow 'Nginx HTTP';

# Requesting domain name from user:
echo ESCREVA O NOME DO SEU DOMÍNIO PRINCIPAL, SEM WWW:;
read domain;

#Obtaining an SSL Certificate
sudo certbot --nginx -d $domain -d www.$domain;


#Activing renew process
#Set up automatic certificate renewal
sudo certbot renew --dry-run;

echo
sudo ln -s /etc/nginx/sites-available/$domain /etc/nginx/sites-enabled/
sudo service nginx restart
echo
echo
echo
echo "PARABÉNS, O CERTIFICADO DE SEGURANÇA PARA O SEU SITE FOI INSTALADO COM SUCESSO!";
echo Já podes acessar via https://$domain;
echo
echo
echo
echo







