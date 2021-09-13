ARG jre=adoptopenjdk:11.0.11_9-jre-hotspot-focal

FROM ${jre}

ARG kafka_version=2.8.0
ARG scala_version=2.13

ENV KAFKA_VERSION=$kafka_version \
    SCALA_VERSION=$scala_version \
    KAFKA_HOME=/opt/kafka

ENV PATH=${PATH}:${KAFKA_HOME}/bin

ADD install-scripts /tmp/install-scripts
ADD scripts /usr/bin/

RUN set -eux; \
    apt-get update; \
    apt-get install -y jq sed bash; \
    /tmp/install-scripts/install-kafka.bash; \
    rm -rf /tmp/*; \
    apt-get remove --purge jq --yes; \
    apt-get autoremove --purge --yes; \
    apt-get clean autoclean; \
    rm -rf /var/lib/apt/lists/*

VOLUME ["/kafka-logs"]

CMD ["start-kafka"]
