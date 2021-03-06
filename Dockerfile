FROM ubuntu:14.04
MAINTAINER Christian Stolz <hg8496@cstolz.de>

ENV HOME /root

ENV VERSION 7.0.1-m2

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y wget \
    && wget -q -O service.sh http://gridvis.janitza.de/download/$VERSION/GridVis-Service-$VERSION-64bit.sh \
    && sh service.sh -q \
    && rm service.sh \
    && chmod -R a-w /usr/local/GridVisService \
    && apt-get clean \
    && echo "gridvis ALL=NOPASSWD: /usr/local/bin/own-volume" >> /etc/sudoers \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV USER_TIMEZONE UTC
ENV USER_LANG en
ENV FILE_ENCODING UTF-8

VOLUME ["/opt/GridVisData", "/opt/GridVisProjects"]
ADD gridvis-service.sh /gridvis-service.sh
ADD own-volume.sh /usr/local/bin/own-volume

EXPOSE 8080
USER gridvis
CMD ["/gridvis-service.sh"]

