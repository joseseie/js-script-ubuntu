#!/bin/bash
# SCRIPT DE ATRIBUIÇÃO DE PERMISSÃO DE PASTAS DE UM PROJECTO LARAVEL 
# NO SERVIDOR UBUNTU 14.* >
# 
# RUN IT LIKE THIS:
# sh dirs_grant.sh
# VERSÃO 1.0 Marco 13 2021
# Org: Explicador Inc
# Author: Explicador Inc

# Script validation checks
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi


# ====================================================
# Reiniciando nginx
# ====================================================


# Clonando o projecto explicador do github
echo "Indique o caminho completo da pasta do seu projecto, exemplo: /var/www/myserver/ProjectDir";
echo "Pode entrar na pasta raíz do seu projecto, depois executar o comando: 'pwd', poderá ver o caminho completo.";
read $myProjectDirPath;

# 1. Tornando proprietário ao webserser user
sudo chown -R www-data:www-data $myProjectDirPath;

# 2. Adição do user ubuntu no grupo de webserver owner
sudo usermod -a -G www-data ubuntu;

# 3. Permissões para as pastas (755) e ficheiros (644)
# Permissões para os ficheiros:
sudo find $myProjectDirPath -type f -exec chmod 644 {} \; 

# Permissões para as pastas
sudo find /path/to/your/laravel/root/directory -type d -exec chmod 755 {} \;

# 4. Entrando no dir do projecto
cd $myProjectDirPath;

# 5. Tornando o meu user actual proprietário de www-data
sudo chown -R $USER:www-data .

# 6. Permissões para o meu user e para o web-server
sudo find . -type f -exec chmod 664 {} \;   
sudo find . -type d -exec chmod 775 {} \;

# 7. Permissões para o webserver poder gravar e ler sobre as pastas: storage e bootstrap
sudo chgrp -R www-data storage bootstrap/cache
sudo chmod -R ug+rwx storage bootstrap/cache

# É tudo....

echo;
echo;
echo Configuração concluida com sucesso!!;
echo O servidor agora está seguro, e o projecto vai poder correr sem problema nenhum.

echo;
echo;
echo;
echo;
echo;




