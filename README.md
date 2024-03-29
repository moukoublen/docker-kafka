Kafka Docker
============

Kafka docker image using `OpenJDK` and more specifically `eclipse-temurin:21.0.1_12-jre-jammy` as base image.
Currently images are being produced for these os/arch:
- `linux/amd64`
- `linux/arm64/v8`

Docker Hub: [https://hub.docker.com/r/moukoublen/kafka](https://hub.docker.com/r/moukoublen/kafka).

GitHub: [https://github.com/moukoublen/docker-kafka](https://github.com/moukoublen/docker-kafka).

Based on the excellent work of [wurstmeister/kafka](https://github.com/wurstmeister/kafka-docker)

## Docker hub image tags
Schema: `<kafka version>-<scala version>`

### Tags
- `3.6.0-2.13`, `latest`
- `3.6.0-2.12`
- `3.5.1-2.13`
- `3.5.1-2.12`



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

## Topics seeding in docker compose
An easy way to create topics using docker compose is this:

```yml
services:
  zookeeper:
    # ...
  kafka:
    # ...
    environment:
      server.listeners: INSIDE://kafka:9092,OUTSIDE://kafka:9094
      server.advertised.listeners: INSIDE://kafka:9092,OUTSIDE://localhost:9094
      # ...

  topics-seed:
    image: moukoublen/kafka:latest
    restart: on-failure
    command: >
      bash -c "set -ex
      kafka-topics.sh --bootstrap-server 'INSIDE://kafka:9092' --create --topic samples1 --if-not-exists
      "
```

Check [single-kafka.yml](compose/single-kafka.yml) and [kraft-cluster.yml](compose/kraft-cluster.yml) for example.


## Docker compose examples

Single kafka node
```shell
docker compose -f compose/single-kafka.yml up
```

Cluster with zookeeper
```shell
docker compose -f compose/cluster-kafka.yml up
```

Kraft cluster (with external mounting of kafka log directory)
```shell
mkdir -p ./compose/logs/kraft-kafka{1,2,3}
docker compose -f compose/kraft-cluster.yml up
```
