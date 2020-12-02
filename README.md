kafka-docker
============

Kafka docker image with `adoptopenjdk`.


The image is available directly from [Docker Hub](https://hub.docker.com/r/moukoublen/kafka/)

Based on excellent work of  [wurstmeister/kafka](https://github.com/wurstmeister/kafka-docker)


Use properties from [broker config](https://kafka.apache.org/documentation/#brokerconfigs) directly as environment variables

```yml
version: '3.8'
services:

  kafka:
    image: moukoublen/kafka
    ports:
      - "9094:9094"
    environment:
      server.broker.id: 1
      server.zookeeper.connect: zookeeper:2181
      server.listeners: INSIDE://kafka:9092,OUTSIDE://kafka:9094
      server.advertised.listeners: INSIDE://kafka:9092,OUTSIDE://localhost:9094
      server.listener.security.protocol.map: INSIDE:PLAINTEXT,OUTSIDE:PLAINTEXT
      server.inter.broker.listener.name: INSIDE
      server.auto_create_topics_enable: "false"
    restart: on-failure
```

