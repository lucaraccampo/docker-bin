FROM nginx:alpine

# Copy default conf for proxy service
COPY ./default.conf /etc/nginx/conf.d/default.conf

# Copy ngnix conf
COPY ./server_names_hash_bucket_size.conf /etc/nginx/conf.d/server_names_hash_bucket_size.conf

# Proxy configurations
COPY ./includes/ /etc/nginx/includes/

# 404 response
COPY ./404-response.html /var/www/html/404-response.html

RUN apk update && apk add bash
