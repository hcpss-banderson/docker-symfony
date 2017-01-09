FROM ubuntu:xenial

RUN apt-get update && apt-get install -y \
		git \
		zip \
		xz-utils \
		curl \
		wget \
		php \
		php-cli \
		php-curl \
		php-gd \
		php-mysql \
		php-json \
		php-intl \
		php-mbstring \
		php-mcrypt \
		php-xml \
		mysql-client \
		apache2 \
		libapache2-mod-php \
	&& apt-get clean

COPY config/php.ini /usr/local/etc/php/

# Install
RUN a2enmod rewrite \
	&& php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php composer-setup.php \
	&& php -r "unlink('composer-setup.php');" \
	&& mv composer.phar /usr/local/bin/composer \
    && wget https://github.com/bander2/twit/releases/download/1.1.0/twit-linux-amd64 -O /usr/local/bin/twit \
    && chmod u+x /usr/local/bin/twit \
    && curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony \
    && chmod a+x /usr/local/bin/symfony

RUN mkdir -p /var/www/symfony/web

COPY config/000-default.conf /etc/apache2/sites-enabled/000-default.conf

WORKDIR /var/www/symfony/web

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
