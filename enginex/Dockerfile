FROM nginx:alpine

LABEL maintainer "Captain Nick Lucifer* <naryal2580@gmail.com>"

ENV HOSTNAME="malert.co"

RUN apk update && \
    apk upgrade && \
    apk add \
    certbot \
    certbot-nginx
    #iproute2 \
    #curl

RUN echo $HOSTNAME > /hostname

COPY index.html /usr/share/nginx/html/

COPY 50x.html /usr/share/nginx/html/

COPY config_template/ /config_template/

EXPOSE 80 443

COPY main.sh /
COPY vhost.sh /

RUN /main.sh
