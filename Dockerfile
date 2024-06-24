FROM php:8.2-fpm

# Install system dependencies (Required for PHP, Laravel, Mixpost)
RUN apt-get update && apt-get install -y \
  libpng-dev \
  libjpeg62-turbo-dev \
  libfreetype6-dev \
  libzip-dev \
  zip \
  unzip \
  git \
  curl \
  libpq-dev \
  libcurl4-gnutls-dev \
  nginx \
  libonig-dev \
  zlib1g-dev \
  libicu-dev \
  libjpeg-dev

# Install Redis extension //pecl = PHP Extension Community Library (Redis, Mixpost)
RUN pecl install redis && docker-php-ext-enable redis

# Install PHP extensions (Required for PHP, Laravel and Mixpost)
RUN docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ && \
  docker-php-ext-install mysqli pdo pdo_mysql bcmath curl mbstring zip intl gd

# Install Composer to intall extra libraries and to run the composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# (Required to edit or view the files in console)
RUN apt-get update && apt-get install -y nano

# (Required to setup and run cronjobs)
RUN apt-get update && apt-get install -y cron

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs

# Change ownership of application code to www-data
# www-data:www-data = user:group
# (Required)
RUN chown -R www-data:www-data /var/www

# Set working directory
# Group
# (Required)
WORKDIR /var/www

# Set the default command
# Runs PHP at the end
# (Required PHP)
CMD ["php-fpm"]