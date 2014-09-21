#!/bin/bash

env | grep _ >> /etc/environment
source /etc/apache2/envvars
/usr/sbin/apache2 -D FOREGROUND
