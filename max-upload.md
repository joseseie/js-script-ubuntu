# Actualização da memória:

## No Servidor:

[Sugestão de leitura 01](https://www.tecmint.com/limit-file-upload-size-in-nginx/)

### 1- Mudar no nginx:

```
$ sudo nano /etc/nginx/nginx.conf
```

```

http {
    ...
    client_max_body_size 100M;
} 

```


### 2 - Mudar no PHP php.ini:

[Sugestão de leitura 02](https://medium.com/@nedsoft/how-to-fix-posttoolargeexception-in-laravel-on-apache-server-4dbdb7cdaaac)

Localizar o ficheiro das configurações 

```
$ php -i | grep php.ini
```

post_max_size = 1024M                                                                                                            
upload_max_filesize = 1024M

### 3 - Mudar PHP fpm

```
$ sudo nano /etc/php/7.2/fpm/php.ini
```

post_max_size = 1024M                                                                                                            
upload_max_filesize = 1024M

```
$ sudo systemctl restart php7.fpm
```

Ou

```
$ sudo reboot
```
