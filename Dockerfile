FROM nginx:1.27.4-alpine

COPY ./nginx.conf /

VOLUME [ "/etc/letsencrypt" ]

EXPOSE 80 443