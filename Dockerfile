# syntax=docker/dockerfile:1.3.1
ARG jre=openjdk:17.0.2-slim-bullseye
FROM ${jre}

ARG kafka_version=3.1.0
ARG scala_version=2.13

ENV KAFKA_VERSION=$kafka_version \
    SCALA_VERSION=$scala_version \
    KAFKA_HOME=/opt/kafka

ENV PATH=${PATH}:${KAFKA_HOME}/bin

ADD install-scripts /tmp/install-scripts

RUN set -eux;                                \
    apt-get update;                          \
    apt-get install -y                       \
        jq sed bash curl acl ca-certificates \
        gzip libc6 procps tar zlib1g;        \
    /tmp/install-scripts/install-kafka.bash; \
    rm -rf /tmp/*;                           \
    apt-get remove --purge jq --yes;         \
    apt-get autoremove --purge --yes;        \
    apt-get clean autoclean;                 \
    rm -rf /var/lib/apt/lists/*

ADD bin /usr/bin/

CMD ["start-kafka"]
