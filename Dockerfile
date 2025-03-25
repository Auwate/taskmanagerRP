FROM nginx:1.27.4-alpine

COPY ./env.conf.template /etc/nginx/templates/

EXPOSE 80 443