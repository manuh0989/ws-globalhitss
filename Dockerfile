FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    nano \
    supervisor
# Instala las extensiones de PHP requeridas por Laravel
RUN docker-php-ext-install pdo_mysql sockets opcache

# RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs npm

# Crea un nuevo usuario y grupo llamado "laravel"
# RUN groupadd -g 1000 laravel && useradd -u 1000 -g laravel -m -s /bin/bash laravel



RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Establece los permisos del directorio de la aplicación
# RUN chown -R laravel:laravel /var/www

# Cambia al usuario "laravel"
# USER laravel
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0"
ENV COMPOSER_VENDOR_DIR="/var/vendor"

ADD opcache.ini "$PHP_INI_DIR/conf.d/opcache.ini"
# Establece el directorio de trabajo
WORKDIR /var/www

COPY config/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY config/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY config/php/php.ini /usr/local/etc/php/php.ini



# Copia los archivos de la aplicación Laravel al contenedor
COPY src /var/www
RUN composer install  --optimize-autoloader
RUN npm install
RUN npm run build
# RUN  composer install --optimize-autoloader -d "/srv/vendor"

RUN chmod -R 777 storage/


# RUN composer install --no-dev --optimize-autoloader
# Instala las dependencias de la aplicación Laravel
# RUN npm install --save-dev chokidar

# Expone el puerto en el que se ejecutará la aplicación
# EXPOSE 8000


# CMD ["php", "artisan", "octane:start", "--watch", "--host=0.0.0.0", "--port=8000"]
CMD ["supervisord"]
EXPOSE 6001
