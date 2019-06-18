FROM ubuntu:bionic

RUN export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update && apt-get install -y --no-install-recommends \
		git \
		zip \
		xz-utils \
		openssl \
		ca-certificates \
		curl \
		wget \
		php \
		php-cli \
		php-curl \
		php-gd \
		php-zip \
		php-mysql \
		php-json \
		php-intl \
		php-mbstring \
		php-xml \
		mysql-client \
		apache2 \
		libapache2-mod-php \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY config/php.ini /etc/php/7.2/apache2/php.ini
RUN a2enmod rewrite

# Install composer
COPY install-composer.sh /install-composer.sh
RUN /install-composer.sh \
	&& mv composer.phar /usr/local/bin/composer

RUN mkdir -p /var/www/symfony

COPY config/000-default.conf /etc/apache2/sites-enabled/000-default.conf

WORKDIR /var/www/symfony

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
