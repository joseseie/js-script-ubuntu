#!/bin/bash
# Restaura o backup da plataforma e2payments

# Script validation checks
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Script de backup da db: app_e2p_do_backup.sh

# ==================================
# === Leitura das variáveis ========
# ==================================

echo "BEM VINDO AO SCRIPT DE BACKUP!"
echo "A seguir, vamos ler as seguintes informações:"
echo "1. Caminho do repositório que armazena os backups;"
echo
echo


# Esse código vais e imprimir no console durante a execução
echo # ==================================
echo # === Leitura das variáveis ========
echo # ==================================

# Ler o caminho do projecto local:
echo 1. ESCREVA O CAMINHO COMPLETO ATÉ AO REPOSITÓRIO DE BACKUPS;
read backup_repo_path;
echo
echo

# ==================================
# == Início de execução do script ==
# ==================================

# 1 e 2 - Importação do último backup a partir do repositório
cd $backup_repo_path; #Por Ler Esse caminho
sudo git pull;
sudo git push

# 3 - Fazer o backup
cd /var/www/e2payments.explicador.co.mz/production
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
echo "PARABÉNS, O BACKUP FOI REALIZADO COM SUCESSO!";
echo
echo
echo







