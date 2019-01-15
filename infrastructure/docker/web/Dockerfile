FROM php:7.3-fpm-alpine

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

# Copy across any custom php.ini files
COPY ./infrastructure/configs/php-fpm/ /usr/local/etc/php/conf.d/

WORKDIR /var/www/web
