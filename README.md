ABOUT
=====

+ This repository provides a dockerised bundle of nginx and php7.0-fpm.
+ The container is running nginx-1.11.7 and php7.0-fpm-5.5.9 on Ubuntu 16.04 LTS.

CONFIG
======
+ Replace or modify the provided configuration files in `conf/`.

**Be careful with the daemons !**

Both nginx and php5-fpm need to be run in non-daemon mode by supervisord.
As such, changes have been made in the config files; if you replace them by yours,
be careful to add :
* `daemon off;` in your nginx.conf
* `daemonize = no;` in your php-fpm.conf

BUILD
=====

1. Clone the repo and cd into it
2. Build the image with `docker build -t {your_tag} .`

USAGE
=====

This image exposes 3 volumes `/etc/nginx/sites-enabled`, `/etc/nginx/sites-available` and `/home/www`.
Run it with

`docker run -d -p 127.0.0.1:80:80 -v /<path_to_the_repo>/sites-enabled:/etc/nginx/sites-enabled {your_tag}`

* You probably want to run this image on a public interface (and not localhost),
change the ip adress accordingly.
* You can mount multiple directories by passing multiple -v arguments
