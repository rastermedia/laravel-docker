#!/bin/bash
chown www-data: -R /var/www/laravel
env | grep _ >> /etc/environment
source /etc/apache2/envvars

LOCKFILE=/run/apache2/apache2.pid

# Previous apache should execute successfully:

[ -f $LOCKFILE ] && exit 0

# Upon exit, remove lockfile.

trap "{ rm -f $LOCKFILE ; exit 255; }" EXIT

/usr/sbin/apache2 -D FOREGROUND

exit 0