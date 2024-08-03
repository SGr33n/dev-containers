FROM php:8.2-fpm

ENV NODE_VERSION=17.x

# Install system dependencies
RUN apt-get update && apt-get install -y \
	git \
	curl \
	sudo \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libmemcached-dev \
	libzip-dev \
	libpng-dev \
	libonig-dev \
	libxml2-dev \
	librdkafka-dev \
	libpq-dev \
    zip \
    unzip \
    supervisor \
	nano \
	cron \
	telnet

RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION} | sudo bash - 

# Install Node
RUN apt-get install -y nodejs

# Install nginx 
RUN apt-get update && apt-get install -y nginx

# Install PHP extensions zip, mbstring, exif, bcmath, intl
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install zip mbstring exif pcntl bcmath -j$(nproc) gd intl

# Install Redis and enable it
#RUN pecl install redis  && docker-php-ext-enable redis

# Install the php memcached & memcache extensions
RUN pecl install memcached && docker-php-ext-enable memcached && \
	pecl install memcache && docker-php-ext-enable memcache

#php8.2-memcache

# Install the PHP pdo_mysql extention
RUN docker-php-ext-install pdo_mysql mysqli

# Install the PHP pdo_pgsql extention
#RUN docker-php-ext-install pdo_pgsql

# Install PHP Opcache extention
#RUN docker-php-ext-install opcache

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install WP-Cli
RUN curl -o /usr/local/bin/wp -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x /usr/local/bin/wp

RUN rm -Rf /var/www/* && \
    mkdir -p /var/www/html

RUN rm -rf /etc/nginx/conf.d/default.conf && \
	rm -rf /etc/nginx/sites-enabled/default && \
	rm -rf /etc/nginx/sites-available/default
	
COPY src/default.conf /etc/nginx/conf.d/

ADD src/php.ini $PHP_INI_DIR/conf.d/
ADD src/opcache.ini $PHP_INI_DIR/conf.d/
ADD src/supervisor/supervisord.conf /etc/supervisor/supervisord.conf

COPY docker-entrypoint.sh /usr/local/bin/

RUN mkdir -p /var/log/supervisor && \
	chmod +x /usr/local/bin/docker-entrypoint.sh

VOLUME [ "/var/www/html" ]

# Install WordPress
RUN set -eux; \
	version=$WP_VERSION; \
	\
	curl -o wordpress.tar.gz -fL "https://wordpress.org/wordpress-$version.tar.gz"; \
	\
# upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
	tar -xzf wordpress.tar.gz -C /usr/src/; \
	cp -a /usr/src/wordpress/. /var/www/html/; \
	rm wordpress.tar.gz; \
	\
	chown -R www-data:www-data wp-content; \
	rm -R wp-content/plugins/*; \
	chmod -R 777 wp-content

#env
COPY wp-config.php /var/www/html/
COPY info.php /var/www/html/

ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG WP_PATH

# Create the user
RUN groupadd --gid $USER_GID vscode \
	&& useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m vscode \
	&& usermod -a -G www-data vscode \
	&& usermod -a -G sudo vscode \
	&& echo "vscode ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/vscode

RUN ln -s /workspace/release $WP_PATH

RUN chown -R vscode:www-data /var/www/html && \
	chown -R vscode:www-data /var/log/supervisor && \
	chown -R vscode:www-data /etc/nginx/conf.d/ && \
	chown -R vscode:www-data /tmp

#USER vscode

ENTRYPOINT ["docker-entrypoint.sh"]
