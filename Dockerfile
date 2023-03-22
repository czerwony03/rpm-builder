FROM tenzer/fpm:no-entrypoint
MAINTAINER Mariusz Wroński <mwronski@trans.eu>

# Environment
ENV TZ="Europe/Warsaw"
ENV PHP_VERSION="php8.0"
ENV DEBIAN_FRONTEND="noninteractive"
ENV LC_ALL="C.UTF-8"

# Install tools
RUN apt-get -y update
RUN apt-get install -y --no-install-recommends apt-utils apt-transport-https lsb-release ca-certificates wget ssh git jq
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
    && apt-get -y update

# Install PIP, PHP, and supplimentary programs.
RUN apt-get install -y ${PHP_VERSION} ${PHP_VERSION}-dev ${PHP_VERSION}-bcmath ${PHP_VERSION}-bz2 \
    ${PHP_VERSION}-cli ${PHP_VERSION}-curl ${PHP_VERSION}-intl ${PHP_VERSION}-mbstring \
    ${PHP_VERSION}-opcache ${PHP_VERSION}-soap ${PHP_VERSION}-sqlite3 ${PHP_VERSION}-xml ${PHP_VERSION}-xsl \
    ${PHP_VERSION}-zip ${PHP_VERSION}-mysql ${PHP_VERSION}-pgsql ${PHP_VERSION}-zip \
    ${PHP_VERSION}-amqp ${PHP_VERSION}-redis

RUN rm /usr/bin/php && ln /usr/bin/php8.0 /usr/bin/php

# Upgrade all
#RUN apt-get -y upgrade

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Entrypoint
CMD [ "fpm", "--help" ]

# docker run -v ~/.ssh/id_rsa:/root/.ssh/id_rsa image command
