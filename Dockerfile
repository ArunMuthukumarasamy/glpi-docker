FROM php:8.2-apache

# Install required extensions
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev libzip-dev unzip \
    libcurl4-openssl-dev libxml2-dev libldap2-dev libicu-dev \
    libonig-dev libxslt1-dev git libbz2-dev zlib1g-dev \
    libgd-dev libsodium-dev && \
    docker-php-ext-install pdo mysqli curl intl zip bz2 exif opcache \
    ldap gd soap sockets && \
    a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Download GLPI
RUN curl -L -o glpi.tgz https://github.com/glpi-project/glpi/releases/download/10.0.14/glpi-10.0.14.tgz && \
    tar -xzf glpi.tgz && rm glpi.tgz && \
    chown -R www-data:www-data glpi

# Set correct document root
ENV APACHE_DOCUMENT_ROOT /var/www/html/glpi/public

# Fix document root config
RUN sed -i "s|/var/www/html|/var/www/html/glpi/public|g" /etc/apache2/sites-available/000-default.conf

# Expose port
EXPOSE 80
