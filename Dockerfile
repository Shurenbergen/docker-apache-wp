FROM ubuntu:20.04

#Fix timezone bag
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    python3-pymysql \
    php-mysql \
    libapache2-mod-php \
    php-mysql*

COPY config/wordpress.conf /etc/apache2/sites-available

#if u need enable rewrite-mode in apache RUN /usr/sbin/a2enmod rewrite

RUN /usr/sbin/a2ensite wordpress.conf
RUN /usr/sbin/a2dissite 000-default.conf

COPY wordpress/ /var/www/wordpress/ 

COPY config/wp-config.php /var/www/wordpress

RUN /usr/bin/find /var/www/wordpress/ -type d -exec chmod 750 {} \;

RUN /usr/bin/find /var/www/wordpress/ -type f -exec chmod 640 {} \;

RUN chown -R www-data:www-data \
    /var/www \
    /var/www/wordpress*

EXPOSE 80

CMD ["apachectl","-DFOREGROUND"]
