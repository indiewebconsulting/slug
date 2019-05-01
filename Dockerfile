FROM php:fpm-alpine
MAINTAINER BiStormLLC <info@bistorm.org>

ENV SLUG_ENV="production"
ENV SLUG_CONFIG="/slug/slug.json"
ENV SLUG_EXEC_ROOT="/slug"

COPY storm /usr/local/bin
RUN chmod +x /usr/local/bin/storm

RUN mkdir -p /slug /var/log/slug && \
    touch /var/log/slug/trace.xt /var/log/slug/error.log && \
    apk update && \
    apk --no-cache add \
    g++ \
    make \
    autoconf \
    libmcrypt-dev \
    git \
    nano \
    grep \
    pcre \
    bash \
    vim \
    zlib-dev \
    python-dev py-pip \
    ruby ruby-json ruby-rdoc ruby-irb ruby-rake ruby-io-console ruby-bigdecimal ruby-json ruby-bundler \
    libstdc++ tzdata ca-certificates 

# Install PHP extensions
RUN docker-php-source extract \
    && pecl install xdebug \
    && docker-php-ext-install mcrypt zip \
    && docker-php-ext-enable xdebug mcrypt zip \
    && docker-php-source delete 

# Custom variables for PHP        
RUN echo "error_log=/var/log/slug/error.log" >> /usr/local/etc/php/conf.d/slug.ini \
    && echo "error_prepend_string={\"SLUG\": " >> /usr/local/etc/php/conf.d/slug.ini \
    && echo "error_append_string={}" >> /usr/local/etc/php/conf.d/slug.ini \
    && echo "error_log=/proc/self/fd/2" >> /usr/local/etc/php/conf.d/slug.ini \
    && echo "file_uploads=Off" >> /usr/local/etc/php/conf.d/slug.ini \
    && echo "log_errors=On" >> /usr/local/etc/php/conf.d/slug.ini \   
    && echo "output_encoding='UTF-8'" >> /usr/local/etc/php/conf.d/slug.ini \
    && echo "output_buffering=On" >> /usr/local/etc/php/conf.d/slug.ini \
    && echo "session.cookie_secure=On" >> /usr/local/etc/php/conf.d/slug.ini \
    && echo "session.name=SLUG" >> /usr/local/etc/php/conf.d/slug.ini \
    && echo "date_default_timezone_set='UTC'" >> /usr/local/etc/php/conf.d/slug.ini \
    && rm -rf /tmp/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Install Node, Grunt, Gulp, Bower
RUN apk add nodejs \ 
    && npm install -g grunt-cli \
    && npm install -g gulp \
    && npm install -g bower 

COPY ./sample/slug.json /slug
COPY ./sample/* /slug/

ENTRYPOINT ["storm"]

WORKDIR /var/www/html

EXPOSE 9000
EXPOSE 9011
