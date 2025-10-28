FROM php:8.2-fpm

WORKDIR /data
COPY .  /data

ENV TZ Asia/Shanghai

RUN apt-get update \
    && apt-get install -y iputils-ping zlib1g-dev git \
    && apt-get install -y libcurl4-openssl-dev libzip-dev unzip \
    && apt-get install -y libmemcached-dev \
    && apt-get install -y libpq-dev libssl-dev \
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-install curl zip \
    && docker-php-ext-install mysqli pgsql pdo_mysql pdo_pgsql \
    && pecl channel-update pecl.php.net \
    && pecl install redis    && docker-php-ext-enable redis \
    && pecl install memcache && docker-php-ext-enable memcache \
    && pecl install mongodb  && docker-php-ext-enable mongodb \
    && docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install -j$(nproc) gd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
