# Dockerfile for rastermedia/laravel-docker based on Homestead nginx + php-fpm
FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y wget

# Get New Relic gpg key for apt repo
RUN wget -O - https://download.newrelic.com/548C16BF.gpg | apt-key add -

# Tell apt where to get New Relic package
RUN echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list

# Update and install dependencies
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php5 php5-mcrypt php5-gd php5-json newrelic-php5 apache2 libapache2-mod-php5 curl php5-curl git-core
RUN rm /etc/apache2/sites-*/*
RUN php5enmod mcrypt
RUN a2enmod rewrite
ADD ./apache.vhost.conf /etc/apache2/sites-enabled/laravel.conf

# Grab composer and install it in /usr/local/bin/composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

ADD ./start.sh /start.sh

EXPOSE 80

VOLUME /var/www/laravel
VOLUME /var/log

CMD ["/start.sh"]

RUN php5dismod newrelic
