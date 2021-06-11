#!/bin/bash
# Restaura o backup da plataforma e2payments

# Script validation checks
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Script de restore da db: app_e2p_restore.sh

# ==================================
# === Leitura das variáveis ========
# ==================================

echo "BEM VINDO AO SCRIPT DE RESTAURAÇÃO DE BACKUP!"
echo "A seguir, vamos ler as seguintes informações:"
echo "1. Caminho do projecto que está em produção;"
echo "2. Caminho do repositório que armazena os backups;"
echo "3. O nome do backup que se deseja restaurar;"
echo "4. O nome da base de dados a ser recriada;"
echo "* Precisará de ter a senha da sua db próximo."

# Esse código vais e imprimir no console durante a execução
echo # ==================================
echo # === Leitura das variáveis ========
echo # ==================================

# Ler o caminho do projecto local:
echo 1. ESCREVA O CAMINHO COMPLETO ATÉ AO PROJECTO, INCLUINDO A PASTA 'production';
read main_project_path;

echo 2. ESCREVA O CAMINHO COMPLETO ATÉ AO REPOSITÓRIO DE BACKUPS;
read backup_repo_path;

echo 3. ESCREVA O NOME DO BACKUP QUE DESEJA RESTAURAR, POR EXEMPLO: '2021-05-11-16-40-05.zip';
read backup_file_to_restore;

echo 4. ESCREVA O NOME DA BASE DE DADOS DESEJA RESTAURAR, POR EXEMPLO: 'my_db_name_example';
read db_name;


# ==================================
# == Início de execução do script ==
# ==================================

# 1 e 2 - Importação do último backup a partir do repositório
cd $backup_repo_path; #Por Ler Esse caminho
sudo git pull;
sudo git push

# 3 - Restaurar o backup localmente
# 3.1 - Fazer login no mysql
# sudo mysql -u root -p #or sudo mysql -u root //sem senha

# 3.2 - Deletar a base de dados
# mysql -u root -e drop database if exists $db_name
# mysql -u root -e create database if not exists $db_name

# If /root/.my.cnf exists then it won't ask for root password
if [ -f /root/.my.cnf ]; then

    mysql -e "DROP DATABASE IF EXISTS ${db_name};"
    mysql -e "CREATE DATABASE IF NOT EXISTS ${db_name} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
    
# If /root/.my.cnf doesn't exist then it'll ask for root password   
else
    echo "Please enter root user MySQL password!"
    echo "Note: password will be hidden when typing"
    read -sp rootpasswd
    mysql -uroot -p${rootpasswd} -e "DROP DATABASE IF EXISTS ${db_name};"
    mysql -uroot -p${rootpasswd} -e "CREATE DATABASE IF NOT EXISTS ${db_name} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
    
fi

# drop database $db_name; #Por guardar na variável
# create database $db_name;
# exit;

# 3.3 - Extrair os ficheiros do backups 
sudo unzip $backup_repo_path/e2Payments/$backup_file_to_restore -d /var/restore/ #Por guardar o file name na variável

# 3.4 - Restauração(copia) do Storage:
sudo rm $main_project_path/storage -R
sudo cp -r /var/restore/$main_project_path/storage $main_project_path

# 3.5 - Actualização das permissões do dir storage:
sudo chmod 777 $main_project_path/storage/ -R

#  3.6 - Restauração da base de dados:
mysql -u $db_name -p $db_name < /var/restore/db-dumps/mysql-$db_name.sql;

# 3.7 - Fazer o backup
cd $main_project_path
sudo php artisan backup:run

# 3.8 - Fazer commit e push
cd $backup_repo_path #caminho do file do backup
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







