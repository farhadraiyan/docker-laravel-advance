FROM php:7.2-fpm

# Copy composer.lock and composer.json
COPY composer.* /var/www/src/

# Set working directory
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

# Install dependencies
RUN composer install --prefer-dist --no-scripts --no-dev --no-autoloader

# Copy existing application directory contents
COPY . /var/www/src

# Finish composer
RUN composer dump-autoload --no-scripts --no-dev --optimize

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory permissions
COPY --chown=www:www . /var/www/src

# # Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 8080