Kafka Docker
============

Kafka docker image using `OpenJDK` and more specifically `eclipse-temurin:17-jre-jammy` as base image.
Currently both `linux/amd64` and `linux/arm64` images are being produced.

Docker hub: [https://hub.docker.com/r/moukoublen/kafka](https://hub.docker.com/r/moukoublen/kafka).

Github: [https://github.com/moukoublen/docker-kafka](https://github.com/moukoublen/docker-kafka).

Based on excellent work of  [wurstmeister/kafka](https://github.com/wurstmeister/kafka-docker)


## Configs source `CONFIG_SOURCE`

### Environment variables (`env`)
In order to use environment variables as configuration you must initialize env var `CONFIG_SOURCE` with `env` value (`CONFIG_SOURCE: env`).

Use properties from [broker config](https://kafka.apache.org/documentation/#brokerconfigs) directly as environment variables with `server.` prefix. Also log4j properties can be used direclty using `log4j.` prefix.

Table of environment variables prefix and destination file.

| Prefix   | Destination file                         |
|----------|------------------------------------------|
| `server` | `${KAFKA_HOME}/config/server.properties` |
| `log4j`  | `${KAFKA_HOME}/config/log4j.properties"` |


```yml
version: '3.8'
services:

  kafka:
    image: moukoublen/kafka
    ports:
      - "9094:9094"
    environment:
      KAFKA_HEAP_OPTS: -Xmx2g -Xms2g
      CONFIG_SOURCE: env
      server.broker.id: 1
      server.zookeeper.connect: zookeeper:2181
      server.listeners: INSIDE://kafka:9092,OUTSIDE://kafka:9094
      server.advertised.listeners: INSIDE://kafka:9092,OUTSIDE://localhost:9094
      server.listener.security.protocol.map: INSIDE:PLAINTEXT,OUTSIDE:PLAINTEXT
      server.inter.broker.listener.name: INSIDE
      server.auto.create.topics.enable: "false"
      log4j.logger.kafka: DEBUG
      log4j.logger.org.apache.kafka: DEBUG
    restart: on-failure
```

### Files (`files`)
By setting `CONFIG_SOURCE` to `files` (e.g. `CONFIG_SOURCE: files`) conf files remain untouched and can be passed as link.

```yml
version: '3.8'
services:

  kafka:
    image: moukoublen/kafka
    ports:
      - "9094:9094"
    environment:
      KAFKA_HEAP_OPTS: -Xmx2g -Xms2g
      CONFIG_SOURCE: files
    volumes:
      - $PWD/config/server.properties:/opt/kafka/config/server.properties
      - $PWD/config/log4j.properties:/opt/kafka/config/log4j.properties
    restart: on-failure
```


## Docker compose examples
```shell
docker compose -f compose/single-kafka.yml up
#or
docker compose -f compose/cluster-kafka.yml up
#or for kraft cluster
docker compose -f compose/kraft-cluster.yml up
```


## Docker hub image tags
Schema: `<scala version>-<kafka version>`

### Tags
- `3.3.2-2.13`, `latest`
- `3.3.2-2.12`
- `3.3.1-2.13`
- `3.3.1-2.12`
- `2.8.2-2.13`
- `2.8.2-2.12`