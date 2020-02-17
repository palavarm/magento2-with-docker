FROM php:7.2-fpm-stretch

# Install system dependencies
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/local/include/ \
    && echo $TZ > /etc/timezone \
    && apt-get update \
    && apt-get -y --no-install-recommends install apt-utils \
        procps \
        git \
        vim \
        nano \
        sqlite3 \
        zip \
        zlib1g-dev \
        libfreetype6-dev \
        libicu-dev \
        libssl-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libedit-dev \
        libedit2 \
        libxslt1-dev \
        re2c \
        libmhash-dev \
        apache2-utils \
        openssl \
        sudo \
        curl \
        unzip

# Install Magento Dependencies
RUN docker-php-ext-configure \
  	gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/; \
  	docker-php-ext-install \
  	opcache \
  	gd \
  	bcmath \
  	intl \
  	mbstring \
  	pdo_mysql \
  	sockets \
  	soap \
  	xsl \
  	zip

# Install oAuth
RUN apt-get update \
  	&& apt-get install -y \
  	libpcre3 \
  	libpcre3-dev \
  	# php-pear \
  	&& pecl install oauth \
  	&& echo "extension=oauth.so" > /usr/local/etc/php/conf.d/docker-php-ext-oauth.ini

# Install Node, NVM, NPM and Grunt
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  	&& apt-get install -y nodejs build-essential \
    && curl https://raw.githubusercontent.com/creationix/nvm/v0.16.1/install.sh | sh \
    && npm i -g grunt-cli yarn

#Install composer
ENV COMPOSER_ALLOW_SUPERUSER=1
COPY docker/php/bin/composer-installer.sh /usr/local/bin/composer-installer
RUN chmod +x /usr/local/bin/composer-installer \
    && sleep 6s \
    && /usr/local/bin/composer-installer \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer \
    && composer --ansi --version --no-interaction

ENV PATH="/var/www/.composer/vendor/bin/:${PATH}"

# Remove Cache
RUN rm -rf /var/cache/apk/*

# Add UID '1000' to www-data
RUN usermod -u 1000 www-data

# Change the directory permissions
RUN chown -R www-data:www-data /var/www

# Change current user to www
USER www-data

# Set working directory
WORKDIR /var/www

# Expose port 9000 and start php-fpm server
EXPOSE 9000

CMD ["php-fpm"]