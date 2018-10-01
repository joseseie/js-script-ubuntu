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



## Notas: adicionar isto no script:

* Instalacao do composer
* Instalacao do nodejs

###### Ficheiro de teste do server com as linhas:

<?php
echo 'Php in the server is good';
echo phpinfo();
?>
