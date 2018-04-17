FROM jenkins/jenkins:lts-slim

USER root
RUN apt-get update \
      && apt-get upgrade -y \
      && apt-get install -y libltdl-dev \
      && rm -rf /var/lib/apt/lists/*
RUN groupadd --gid 994 docker
RUN usermod -aG docker jenkins 

USER jenkins
