# syntax=docker/dockerfile:1.5
### https://hub.docker.com/r/docker/dockerfile
ARG jre

FROM ${jre}

ARG kafka=3.3.1
ARG scala=2.13

ENV KAFKA_VERSION=${kafka}
ENV SCALA_VERSION=${scala}
ENV KAFKA_HOME=/opt/kafka
ENV PATH=${PATH}:${KAFKA_HOME}/bin

RUN <<eot
set -e
apt-get update
apt-get install -y \
    jq sed bash curl acl ca-certificates \
    gzip libc6 procps tar zlib1g
eot

#SHELL ["/usr/bin/bash", "-c"]

COPY install-scripts /tmp/install-scripts
COPY bin /usr/bin/

RUN <<eot
set -e
/tmp/install-scripts/install-kafka.bash
rm -rf /tmp/*
apt-get remove --purge jq --yes
apt-get autoremove --purge --yes
apt-get clean autoclean
rm -rf /var/lib/apt/lists/*
eot


CMD ["start-kafka"]
