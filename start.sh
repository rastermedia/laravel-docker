#!/bin/bash
chown www-data: -R /var/www/laravel
env | grep _ >> /etc/environment
source /etc/apache2/envvars
/usr/sbin/apache2 -D FOREGROUND
