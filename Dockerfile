FROM ubuntu:20.04

#Fix timezone bag
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    mysql-server \
    python3-pymysql \
    php-mysql \
    libapache2-mod-php \
    php-mysql*

RUN chown -R www-data:www-data /var/www
COPY server-infra-s4.ru.conf /etc/apache2/sites-available

RUN /usr/sbin/a2enmod rewrite
RUN /usr/sbin/a2ensite server-infra-s4.ru.conf
RUN /usr/sbin/a2dissite 000-default.conf

RUN mkdir /var/www/server-infra-s4.ru
RUN chown -R www-data:www-data /var/www/server-infra-s4.ru

RUN mkdir /var/www/server-infra-s4.ru/wordpress

RUN /usr/bin/find /var/www/server-infra-s4.ru/wordpress/ -type d -exec chmod 750 {} \;
RUN /usr/bin/find /var/www/server-infra-s4.ru/wordpress/ -type f -exec chmod 640 {} \;
ADD wordpress/ /var/www/server-infra-s4.ru/wordpress/ 
COPY wp-config.php /var/www/server-infra-s4.ru/wordpress
RUN chown -R www-data:www-data /var/www/server-infra-s4.ru/wordpress
RUN network=host

EXPOSE 80
CMD ["apachectl","-DFOREGROUND"]


