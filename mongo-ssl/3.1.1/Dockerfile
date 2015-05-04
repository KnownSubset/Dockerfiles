# http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
FROM       ubuntu:latest
MAINTAINER nathan@radialogica.com

# Installation:
# Import MongoDB public GPG key AND create a MongoDB list file
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.1 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.1.list

# Update apt-get sources AND install MongoDB
RUN apt-get update \
  && apt-get upgrade -yq --no-install-recommends \
  && apt-get install -yq --no-install-recommends mongodb-org-unstable \
  && apt-get autoremove -y --purge \
  && apt-get clean autoclean \
  && rm -rf /var/lib/{apt,dpkg,cache,lists} /tmp/* /var/tmp/*

# Create the MongoDB data directory
RUN mkdir -p /data/db
VOLUME /data/db

# Expose port #27017 from the container to the host
EXPOSE 27017

CMD ["mongod"]
