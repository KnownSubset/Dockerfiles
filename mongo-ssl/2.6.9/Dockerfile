FROM debian:jessie
MAINTAINER nathan@radialogica.com

RUN (echo "deb http://http.debian.net/debian/ jessie main contrib non-free" > /etc/apt/sources.list && echo "deb http://http.debian.net/debian/ jessie-updates main contrib non-free" >> /etc/apt/sources.list && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list) && \
    echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN  apt-get update && \
     apt-get upgrade -yq --no-install-recommends;

RUN apt-get -yq install --no-install-recommends \
      build-essential \
      git-core \
      scons \
      libssl-dev \
      libboost-filesystem-dev \
      libboost-program-options-dev \
      libboost-system-dev \
      libboost-thread-dev \
    && mkdir -p /var/downloads /usr/local/bin /data/db /var/log/mongo.log \
    && cd /var/downloads \
    && git clone git://github.com/mongodb/mongo.git \
    && cd /var/downloads/mongo \
    && git checkout r2.6.9 \
    && scons mongod --64 --ssl -j8 --no-glibc-check --prefix=/usr/local \
    && scons mongos --64 --ssl -j8 --no-glibc-check --prefix=/usr/local \
    && scons mongo --64 --ssl -j8 --no-glibc-check --prefix=/usr/local \
    && cp /var/downloads/mongo/build/linux2/64/ssl/mongo/mongod /usr/local/bin \
    && cp /var/downloads/mongo/build/linux2/64/ssl/mongo/mongo /usr/local/bin \
    && rm -rf /var/downloads \
    && apt-get remove -y --purge git-core scons \
    && apt-get autoremove -y --purge \
    && apt-get clean autoclean \
    && rm -rf /var/lib/{apt,dpkg,cache,lists} /tmp/* /var/tmp/*

EXPOSE 27017
