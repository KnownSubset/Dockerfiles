FROM debian:jessie
MAINTAINER nathan@radialogica.com

RUN (echo "deb http://http.debian.net/debian/ jessie main contrib non-free" > /etc/apt/sources.list && echo "deb http://http.debian.net/debian/ jessie-updates main contrib non-free" >> /etc/apt/sources.list && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list) && \
    echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN  apt-get update && \
     apt-get upgrade -yq --no-install-recommends;
     
RUN  apt-get install -yq --no-install-recommends \
       wget \
       build-essential \
       scons \
       libssl-dev \
       libboost-filesystem-dev \
       libboost-program-options-dev \
       libboost-system-dev \
       libboost-thread-dev && \
     apt-get install -yq --no-install-recommends --reinstall procps && \
     apt-get clean && \
     rm -rf /var/lib/apt/lists/* && \
     \
     mkdir -p /var/downloads /data/db /var/log/mongo.log  && \
     cd /var/downloads  && \
     wget --quiet --no-check-certificate https://github.com/mongodb/mongo/archive/r3.1.1.tar.gz  && \
     tar -xf r3.1.1.tar.gz  && \
     cd /var/downloads/mongo-r3.1.1 && \
     scons core --ssl -j4 --prefix=/usr/local  && \
     cp /var/downloads/mongo-r3.1.1/build/x86_64/ssl/mongo/mongo* /usr/local/bin  && \
     \
     rm -rf /var/downloads && \
     apt-get remove -y --purge \
       wget \
       build-essential \
       scons \
       libboost-filesystem-dev \
       libboost-program-options-dev \
       libboost-system-dev \
       libboost-thread-dev && \
     apt-get autoremove -y --purge  && \
     apt-get clean autoclean && \
     rm -rf /var/lib/{apt,dpkg,cache,lists} /tmp/* /var/tmp/*

EXPOSE 27017
