ARG PHP_VER=7.3

FROM php:${PHP_VER}-fpm-alpine

# install the PHP extensions we need
RUN apk update && \
    apk add mysql-client \
            freetype-dev \
            libjpeg-turbo-dev \
            libpng-dev \
            libpq \
            postgresql-dev \
            libpng-dev \
            libzip-dev \
            unzip \
            git \
            imagemagick \
            htop \
            wget

# configure extensions
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ && \
    docker-php-ext-configure opcache --enable-opcache

# php extensions
RUN docker-php-ext-install gd \
                           mbstring \
                           opcache \
                           pdo \
                           pdo_mysql \
                           pdo_pgsql \
                           mysqli \
                           zip
# Add composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Copy across any custom php.ini files
COPY ./infrastructure/configuration/php-fpm/ /usr/local/etc/php/conf.d/

# Copy across any codebase
COPY ./backend-code/ /var/www/

WORKDIR /var/www

RUN chown -R www-data:www-data /var/www

USER www-data

RUN composer install -vvv

WORKDIR /var/www/web