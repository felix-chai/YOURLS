# Use the official PHP image from Docker Hub
FROM php:8.1-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo_mysql mysqli

# Set working directory
WORKDIR /var/www/html

# Copy the YOURLS code into the container
COPY . .

# Set permissions for Apache
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Enable Apache mod_rewrite for YOURLS
RUN a2enmod rewrite

# Expose port 80 to access the app
EXPOSE 80

# Start Apache when the container launches
CMD ["apache2-foreground"]
