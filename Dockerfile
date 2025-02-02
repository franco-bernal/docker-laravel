# Usa una imagen base con PHP y Apache
FROM php:8.1-apache

# Instala dependencias y extensiones necesarias para Laravel
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    curl && \
    docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Habilita el módulo mod_rewrite de Apache para Laravel
RUN a2enmod rewrite

# Establece la DocumentRoot en /var/www/html/public
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf

# Instala Composer (copiándolo desde la imagen oficial de Composer)
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Establece el directorio de trabajo (que coincide con el montaje de la carpeta app)
WORKDIR /var/www/html

EXPOSE 80

