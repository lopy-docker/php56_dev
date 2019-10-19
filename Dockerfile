# build:
#
# docker build -t registry.cn-hongkong.aliyuncs.com/lopy-dev/php5.6-fpm .

# This dockerfile uses the ubuntu image
# VERSION 2 - EDITION 1
# Author: docker_user
# Command format: Instruction [arguments / command ] ..

# Base image to use, this nust be set as the first line
FROM php:5.6-fpm

# Maintainer: docker_user <docker_user at email.com> (@docker_user)
MAINTAINER zengyu 284141050@qq.com

#


ENV FPM_HOST 127.0.0.1
ENV FPM_PORT 9000
ENV XDEBUG_REMOTE_HOST 172.17.0.1
ENV XDEBUG_REMOTE_PORT 19001
ENV XDEBUG_IDE_KEY PHPSTORM



# add default user for web server
RUN usermod -u 1000 www-data &&  usermod -G staff www-data && usermod --shell /bin/bash www-data

# install mysql
RUN docker-php-ext-install -j$(nproc) pdo_mysql

# install gd 
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        git \
        libjpeg62-turbo-dev \
        libpng-dev \
        zip \
        sudo \
        procps \
        inetutils-ping \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install zip \
    && echo "debian  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


# install extensions can't install by docker-php-ext-install or pecl
ADD extension /tmp/extension

# install xdebug
#RUN sh /tmp/extension/xdebug/install.sh
RUN php /tmp/extension/ExtInstaller.php -n xdebug \
    && php /tmp/extension/ExtInstaller.php -n swoole \
    && rm -rf /tmp/extension


# utf8 ,support zh-cn
ENV LANG C.UTF-8

## node

RUN cd /tmp \
    && curl https://nodejs.org/dist/v10.16.3/node-v10.16.3-linux-x64.tar.xz -o node.tar.xz \
    && xz -d node.tar.xz \
    && tar -xvf node.tar && rm -rf node.tar \
    && mv node-v10.16.3-linux-x64/ /usr/local/node \
    && /usr/local/node/bin/npm -g install bower gulp webpack \
    && npm cache clean -f


RUN cd /usr/local/bin \
    && curl -sS https://getcomposer.org/installer | php \
    && echo "export PATH=\$PATH:/root/.composer/vendor/bin:/usr/local/node/bin/" >> /root/.bashrc \
    && echo "export PATH=\$PATH:/root/.composer/vendor/bin:/usr/local/node/bin/" >> /root/.profile \
    && echo "export PATH=\$PATH:/root/.composer/vendor/bin:/usr/local/node/bin/" >> /etc/profile



