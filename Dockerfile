# syntax=docker/dockerfile:1.4
ARG jre=eclipse-temurin:17.0.4.1_1-jre-jammy
FROM ${jre} as base

RUN <<eot
apt-get update
apt-get install -y \
    jq sed bash curl acl ca-certificates \
    gzip libc6 procps tar zlib1g
eot

FROM base

ARG kafka_version=3.1.0
ARG scala_version=2.13

ENV KAFKA_VERSION=$kafka_version \
    SCALA_VERSION=$scala_version \
    KAFKA_HOME=/opt/kafka

ENV PATH=${PATH}:${KAFKA_HOME}/bin

COPY install-scripts /tmp/install-scripts
COPY bin /usr/bin/

RUN <<eot
#!/usr/bin/env sh
/tmp/install-scripts/install-kafka.bash
rm -rf /tmp/*
apt-get remove --purge jq --yes
apt-get autoremove --purge --yes
apt-get clean autoclean
rm -rf /var/lib/apt/lists/*
eot


CMD ["start-kafka"]
