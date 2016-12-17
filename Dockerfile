# nginx/php
# VERSION 0.1

FROM ubuntu:16.04
MAINTAINER Floris Hoogenboom <floris@digitaldreamworks.nl>

# Get some security updates
RUN apt-get update
RUN apt-get -y upgrade

# install nginx, php5, mysql driver and supervisor
RUN apt-get -y install nginx
RUN apt-get -y install php7.0-fpm
RUN apt-get -y install php7.0-mysql
RUN apt-get -y install supervisor

# Add our config files
ADD conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD conf/nginx.conf /etc/nginx/nginx.conf
ADD conf/php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf
ADD conf/php.ini /etc/php/7.0/fpm/php.ini

# Start the php7.0-fpm service once on build to make sure all
# needed files a present in the container
RUN service php7.0-fpm start

# disable the daemons for nginx & php
# RUN echo "daemon off;" >> /etc/nginx/nginx.conf
# RUN sed -i "s/;daemonize = yes/daemonize = no/g" /etc/php/7.0/fpm/php-fpm.conf

# sites volume
RUN mkdir /home/www
RUN echo "<?php phpinfo() ?>" > /home/www/index.php

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/sites-available", "/var/log/nginx", "/home/www"]
# Path to your conf file & sites-* .
# Mount with `-v <data-dir>:/etc/nginx/sites-enabled`

# expose http & https
EXPOSE 80
EXPOSE 443

CMD ["/usr/bin/supervisord"]
