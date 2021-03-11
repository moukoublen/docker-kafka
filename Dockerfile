ARG jre=adoptopenjdk:11.0.10_9-jre-hotspot

FROM ${jre}

ARG kafka_version=2.7.0
ARG scala_version=2.13

ENV KAFKA_VERSION=$kafka_version \
    SCALA_VERSION=$scala_version \
    KAFKA_HOME=/opt/kafka

ENV PATH=${PATH}:${KAFKA_HOME}/bin

ADD install-scripts /tmp/install-scripts
ADD scripts /usr/bin/

RUN apt-get update && \
    apt-get install -y jq bash && \
    /tmp/install-scripts/install-kafka.bash && \
    rm -rf /tmp/*

VOLUME ["/kafka-logs"]

CMD ["start-kafka"]
