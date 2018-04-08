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
    tree

RUN rm /etc/nginx/* -rfv \
    git clone https://github.com/perusio/wordpress-nginx.git \
    rm -vf wordpress-nginx/sites-available/000* wordpress-nginx/sites-available/example*

COPY wordpress-nginx/ /etc/nginx/
COPY site.conf /etc/nginx/sites-available/

RUN tree /etc/nginx

CMD ["nginx", "-g", "daemon off;"]
