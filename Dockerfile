FROM nginx:1.27.4-alpine

COPY ./nginx.conf /etc/nginx/conf.d/
COPY ./nginx.conf.template /etc/nginx/templates/

VOLUME [ "/etc/letsencrypt" ]

EXPOSE 80 443