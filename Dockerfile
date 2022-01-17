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

RUN mkdir /var/www/wordpress

COPY yourdomain.conf /etc/apache2/sites-available

RUN /usr/sbin/a2enmod rewrite
RUN /usr/sbin/a2ensite yourdomain.conf
RUN /usr/sbin/a2dissite 000-default.conf

RUN /usr/bin/find /var/www/wordpress/ -type d -exec chmod 750 {} \;
RUN /usr/bin/find /var/www/wordpress/ -type f -exec chmod 640 {} \;

ADD wordpress/ /var/www/wordpress/ 
COPY wp-config.php /var/www/wordpress

RUN chown -R www-data:www-data \
    /var/www \
    /var/www/wordpress*

EXPOSE 80
CMD ["apachectl","-DFOREGROUND"]


