FROM nginx

ADD docker/nginx/nginx.conf /etc/nginx/

ARG PHP_UPSTREAM_CONTAINER=magento2-php
ARG PHP_UPSTREAM_PORT=9000

# Set upstream conf and remove the default conf
RUN echo "upstream fastcgi_backend { server ${PHP_UPSTREAM_CONTAINER}:${PHP_UPSTREAM_PORT}; }" > /etc/nginx/conf.d/upstream.conf \
    && rm /etc/nginx/conf.d/default.conf

EXPOSE 80 443

WORKDIR /etc/nginx

CMD ["nginx"]
