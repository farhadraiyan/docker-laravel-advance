FROM php:7.2-fpm

# Copy composer.lock and composer.json
COPY ./src/composer.lock ./src/composer.json /var/www/src/

# # Set working directory
WORKDIR /var/www/src

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    mariadb-client \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install mysqli mbstring zip exif pcntl
RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
RUN docker-php-ext-install gd

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# composer update to update all dependancies
RUN composer update

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory contents
COPY ./src /var/www/src

# Copy existing application directory permissions
COPY --chown=www:www ./src /var/www/src
# RUN chmod -R 777 /var/www/src/storage && sudo chmod -R 777 /var/www/src/bootstrap/cache

# # Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 8080