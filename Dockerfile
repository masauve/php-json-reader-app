#Dockerfile
FROM php:7.4-apache
WORKDIR /
COPY app/* /var/www/html
#COPY docs/config.json /opt/
RUN sed -i "s/Listen 80/Listen 8080/" /etc/apache2/ports.conf 
RUN docker-php-ext-install pdo_mysql
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]