FROM alpine:latest

EXPOSE 80

STOPSIGNAL SIGTERM

VOLUME ["/data"]

RUN apk add --update \
    nginx \
    php7-fpm \
    php7-cgi \
    php7-mysqli \
    php7-gd \
    php7-mbstring \
    php7-zip \
    php7-xml \
    apache2-utils \
    git \
    bash \
    supervisor \
    curl \
    && adduser www-data -G www-data -D

RUN rm /etc/nginx/* -rfv && \
    git clone -v https://github.com/tomaszkiewicz/wordpress-nginx.git /etc/nginx && \
    rm -rvf /etc/nginx/sites-available/000* /etc/nginx/sites-available/example* /etc/nginx/.git && \
    mkdir -p /etc/nginx/sites-enabled && \
    mkdir -p /data/www && \
    mkdir -p /data/log

COPY site.conf /etc/nginx/sites-enabled/
COPY supervisord.conf /etc/
COPY index.php /data/www
COPY php-fpm-www.conf /etc/php7/php-fpm.d/www.conf

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
