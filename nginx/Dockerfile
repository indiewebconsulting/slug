FROM nginx:stable-alpine
MAINTAINER BiStormLLC <info@bistorm.org>

RUN mkdir -p /var/log/nginx && \
    rm /etc/nginx/conf.d/default.conf && \
    apk update && \
    apk upgrade && \
    apk add bash && \
    apk add vim
    
COPY ./nginx.conf /etc/nginx
COPY ./slug.conf /etc/nginx/conf.d

EXPOSE 9082
