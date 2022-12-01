FROM php:8.1.0-fpm

# Install dependencies
RUN apt-get update \
  && apt-get install -y \
    git \
    libfreetype6-dev \ 
    libicu-dev \ 
    libjpeg62-turbo-dev \ 
    libmcrypt-dev \ 
    libpng-dev \ 
    libxslt1-dev \ 
    sendmail-bin \ 
    sendmail \ 
    sudo \ 
    libzip-dev \
	libonig-dev \
	libxml2-dev \ 
	libxslt-dev \
	libsodium-dev
	
# Configure the gd library
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

# Install Magento Dependencies
RUN docker-php-ext-install \
	mysqli \
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

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php composer-setup.php \
	&& php -r "unlink('composer-setup.php');" \
	&& mv composer.phar /usr/bin/composer

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
