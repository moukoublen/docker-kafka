Kafka Docker
============

Kafka docker image with `adoptopenjdk`.


The image is available in [Docker Hub](https://hub.docker.com/r/moukoublen/kafka/)

The repo is located in [Github](https://github.com/moukoublen/docker-kafka)

Based on excellent work of  [wurstmeister/kafka](https://github.com/wurstmeister/kafka-docker)


Use properties from [broker config](https://kafka.apache.org/documentation/#brokerconfigs) directly as environment variables with `server.` prefix. Also log4j properties can be used direclty using `log4j.` prefix.

```yml
version: '3.8'
services:

  kafka:
    image: moukoublen/kafka
    ports:
      - "9094:9094"
    environment:
      KAFKA_HEAP_OPTS: -Xmx2g -Xms2g
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

### Docker compose examples
```shell
docker-compose -f compose/single-kafka.yml up
#or
docker-compose -f compose/cluster-kafka.yml up
```


### Docker hub / git tags
Schema: `<scala version>-<kafka version>_<revision>`

