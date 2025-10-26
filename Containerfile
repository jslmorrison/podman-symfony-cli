FROM docker.io/library/php:8.4.14-cli-alpine

LABEL maintainer="jslmorrison@gmail.com"

COPY --from=docker.io/library/composer:2.8 /usr/bin/composer /usr/bin/composer
COPY --from=docker.io/mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN apk add --no-cache \
        bash \
        curl \
        git \
    && install-php-extensions intl pdo_mysql zip \
    && curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.alpine.sh' | bash \
    && apk add symfony-cli

ENV COMPOSER_ALLOW_SUPERUSER=1

WORKDIR /app

CMD ["symfony"]