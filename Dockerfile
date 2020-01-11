FROM php:7.0-apache
RUN apt-get update \
    && apt-get install -y zip libldap2-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install mysqli pdo pdo_mysql ldap
# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" &&\
    php composer-setup.php --install-dir=/bin --filename=composer &&\
    a2enmod rewrite
# Slim framework
COPY misc/.htaccess /var/www/html 