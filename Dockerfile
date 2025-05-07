FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libonig-dev libxml2-dev zip unzip wget \
    gnupg libldap2-dev libicu-dev libzip-dev \
    libmariadb-dev mariadb-client \
    && docker-php-ext-install pdo pdo_mysql mysqli gd ldap intl zip xml opcache

RUN a2enmod rewrite

RUN wget https://github.com/glpi-project/glpi/releases/download/10.0.14/glpi-10.0.14.tgz \
    && tar -xvzf glpi-10.0.14.tgz \
    && mv glpi /var/www/html/ \
    && rm glpi-10.0.14.tgz

RUN chown -R www-data:www-data /var/www/html/glpi

EXPOSE 80
CMD ["apache2-foreground"]
