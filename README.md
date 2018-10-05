# js-script-ubuntu
Script de configuracao do servidor linux ubuntu

## Primeiros passos

Passos a serem seguintes na mesma sequência para a preparacao do server:

* Passo 1 - Instalaçao do git
$ `sudo apt update; sudo apt install git`;
* Passo 2 - Clonar este repositório:
$ `git clone https://github.com/joseseie/js-script-ubuntu.git`;
* Passo 3 - Acessar o directório do repositório:
$ `cd js-script-ubuntu`;
* Passo 4 - Tornar o script executável:
$ `sudo chmod +x *.sh`;
* Passo 5 - Entrar como root:
$ `sudo -s -H`
* Passo 6 - Iniciar o script:
$ `sh lemp-ubuntu-instalation.sh`


#  Notas

* sudo nano /etc/php/7.0/fpm/php.ini

Definir este valor e descomentar a linha
	

cgi.fix_pathinfo=0

* Restart PHP 7.2 FPM

sudo service php7.2-fpm restart

#  =============================================
#  Base de dados
# ==============================================
#
# Criacao da base de dados
# CREATE DATABASE explicadordb2018;
# Criacao de User
# CREATE USER 'explicador2018'@'localhost' IDENTIFIED BY 'new_password';

# Permissoes na db
# GRANT ALL ON explicadordb2018.* TO 'new_user'@'localhost';

# Actualizar as permissoes
# FLUSH PRIVILEGES;
#
# Para ver base de dados:
# SHOW DATABASES;

