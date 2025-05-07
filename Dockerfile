# Use official PHP 8.1 Apache image
FROM php:8.1-apache

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    wget \
    gnupg \
    libldap2-dev \
    libicu-dev \
    libzip-dev \
    libmariadb-dev \
    mariadb-client \
    && docker-php-ext-install pdo pdo_mysql mysqli gd ldap intl zip xml opcache \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Download and install GLPI
RUN wget https://github.com/glpi-project/glpi/releases/download/10.0.14/glpi-10.0.14.tgz \
    && tar -xvzf glpi-10.0.14.tgz \
    && rm -rf glpi-10.0.14.tgz \
    && rm -rf /var/www/html/* \
    && mv glpi/* . \
    && rm -rf glpi

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html

# Expose web port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
