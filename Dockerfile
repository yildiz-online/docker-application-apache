FROM ubuntu:bionic

LABEL maintainer="Grégory Van den Borre vandenborre.gregory@hotmail.fr"

ENV EMAIL ""
ENV DOMAIN ""
ENV ARGUMENT ""

ENV TZ=Europe/Brussels

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN (apt-get update && apt-get upgrade -y -q && apt-get dist-upgrade -y -q && apt-get -y -q autoclean && apt-get -y -q autoremove)
RUN apt-get install -y -q software-properties-common
RUN add-apt-repository ppa:ondrej/apache2
RUN add-apt-repository ppa:certbot/certbot
RUN apt-get update
RUN apt-get install apache2 python-certbot-apache -y -q
COPY script.sh /
RUN chmod 777 script.sh
RUN a2enmod headers
RUN a2enmod ssl

EXPOSE 80
EXPOSE 443

VOLUME ["/etc/letsencrypt", "/var/www/html/", "/etc/apache2"]

ENTRYPOINT ./script.sh
