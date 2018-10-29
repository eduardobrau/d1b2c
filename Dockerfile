FROM php:7.2-apache

# Install lib for pdo and mysqli
RUN docker-php-ext-install pdo pdo_mysql mysqli

COPY ./meuprojeto/composer.json /var/www/html/

#ENV APACHE_DOCUMENT_ROOT /var/www/html/public-html

#RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
COPY app.conf /etc/apache2/sites-available/app.conf

WORKDIR /etc/apache2/sites-available/
#RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN a2ensite app.conf

RUN a2enmod rewrite

RUN rm -rf /etc/apache2/sites-enabled/000-default.conf

WORKDIR /var/www/html

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
&& php -r "if (hash_file('SHA384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
&& php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
&& composer install