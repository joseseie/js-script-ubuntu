#!/bin/bash
# Restaura o backup da plataforma e2payments

# Script validation checks
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

Script de restore da db: app_e2p_restore.sh

# 1 - Importação da base de dados
cd /var/backups/backup-e2payments-platform4; #Por Ler Esse caminho
sudo git pull;

# 2 - Fazer o push
sudo git push

# 3 - Restaurar o backup localmente
# 3.1 - Fazer login no mysql
sudo mysql -u root -p #or sudo mysql -u root //sem senha

# 3.2 - Deletar a base de dados
mysql> drop database e2paymetntssecrets1234; #Por guardar na variável
mysql> create database e2paymetntssecrets1234;
Mysql> exit;

# 3.3 - Extrair os ficheiros do backups 
sudo unzip /var/backups/backup-e2payments-platform4/e2Payments/2021-05-11-16-40-05.zip -d /var/restore/ #Por guardar o file name na variável

# 3.4 - Restauração(copia) do Storage:
sudo cp -r /var/restore/var/www/e2payments.explicador.co.mz/production/storage/* /var/www/e2payments.explicador.co.mz/production/storage

# 3.5 - Actualização das permissões do dir storage:
sudo chmod 777 /var/www/e2payments.explicador.co.mz/production/storage/ -R

#  3.6 - Restauração da base de dados:
mysql -u e2paymetntssecrets1234 -p e2paymetntssecrets1234 < /var/restore/db-dumps/mysql-e2paymetntssecrets1234.sql;

# 3.7 - Fazer o backup
cd /var/www/e2payments.explicador.co.mz/production
sudo php artisan backup:run

# 3.8 - Fazer commit e push
cd /var/backups/backup-e2payments-platform4 #caminho do file do backup
sudo git add .
sudo git commit -m 'backup(App): Backup realizado pelo script'
sudo git push

echo
echo
echo
echo
echo "PARABÉNS, O BACKUP FOI RESTAURADO COM SUCESSO!";
echo
echo
echo







