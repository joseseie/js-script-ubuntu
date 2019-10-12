#  Todo do refazer para apache
#!/bin/bash
# Instalation OF SSL Certificate ON YOUR SERVER
# VERSION 1.0 October 10 2018
# Org: Explicador Inc
# Author: Explicador Inc
# PRE REQUISITIES: 
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

sudo apt-get update;

sudo apt-get install python-certbot-nginx;

#Allowing HTTPS Through the Firewall
sudo ufw allow 'Nginx Full';
sudo ufw delete allow 'Nginx HTTP';

#Obtaining an SSL Certificate
echo escrava o nome do seu dominio principal, sem www;
read domain1;
echo escrava o nome do seu dominio com www;
read domain2;
sudo certbot --nginx -d $domain1 -d $domain2;


#Activing renew process
#Set up automatic certificate renewal
sudo certbot renew --dry-run;

echo
echo
echo "Parabés, O Certificado de segurança SSL para o seu site foi instalado com sucesso!";
echo Já podes acessar via https://$domain1;
