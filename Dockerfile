FROM hsl888/ubuntu
MAINTAINER shilei<331968891@qq.com>

VOLUME /app
ENV WEBROOT /app
WORKDIR $WEBROOT

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php -y && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --fix-missing \
        build-essential \
        imagemagick \
        ca-certificates \
        libpng12-dev \
        libjpeg-dev \
        php7.1 \
        php7.1-cli \
        php7.1-dev \
        php7.1-bcmath \
        php7.1-bz2 \
        php7.1-fpm \
        php7.1-common \
        php7.1-curl \
        php-imagick \
        php7.1-gd \
        php7.1-intl \
        php7.1-json \
        php-apcu \
        php7.1-mbstring \
        php7.1-mcrypt \
        php7.1-mysql \
        php7.1-xml \
        php7.1-opcache \
        php7.1-sqlite3 \
        php7.1-zip \
        php-redis \
        git vim rsyslog zip \
    && mkdir /run/php/ \
    && groupmod --gid 1000 www-data && usermod --uid 1000 --gid 1000 www-data

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:jonathonf/ffmpeg-3 -y && apt-get update \
    && apt-get install ffmpeg libav-tools x264 x265 libavcodec-extra libavcodec-ffmpeg-extra56 -y

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs \
    && npm -g install yarn
RUN apt-get install -y libmysqlclient-dev python-pip \
    && pip install --upgrade pip\
    && pip install mysql-python

RUN curl https://getcomposer.org/installer | php -- && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer \
    && apt-get autoclean && apt-get autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

EXPOSE 9000

CMD ["php-fpm7.1", "--nodaemonize"]
