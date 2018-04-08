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
    bash

RUN rm /etc/nginx/* -rfv && \
    git clone -v https://github.com/perusio/wordpress-nginx.git /etc/nginx && \
    rm -rvf /etc/nginx/sites-available/000* /etc/nginx/sites-available/example* /etc/nginx/.git

COPY site.conf /etc/nginx/sites-available/

CMD ["nginx", "-g", "daemon off;"]
