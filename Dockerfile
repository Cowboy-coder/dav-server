FROM akter/base:v1

RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install php5-common libapache2-mod-php5 php5-cli curl php5-curl

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

RUN mkdir /var/www/sabre-dav

RUN cd /var/www/sabre-dav && composer require sabre/dav ~2.0.3
ADD server.php /var/www/sabre-dav/server.php

RUN rm /etc/apache2/sites-available/000-default.conf
ADD sabre-dav.conf /etc/apache2/sites-available/000-default.conf

RUN sudo a2enmod rewrite

CMD sudo /usr/sbin/apache2ctl -D FOREGROUND
