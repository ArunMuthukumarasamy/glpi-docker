FROM php:8.1-apache

# Install PHP extensions and dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev libxml2-dev zip unzip git curl mariadb-client \
    && docker-php-ext-install pdo pdo_mysql mysqli gd xml mbstring curl \
    && apt-get clean

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Download and extract GLPI
RUN curl -L -o glpi.tgz https://github.com/glpi-project/glpi/releases/download/10.0.14/glpi-10.0.14.tgz && \
    tar -xzf glpi.tgz && \
    mv glpi/* . && \
    rm -rf glpi.tgz glpi

# Set permissions
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

EXPOSE 80
