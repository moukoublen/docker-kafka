# https://docs.docker.com/build/bake/
# https://docs.docker.com/build/bake/file-definition

# docker buildx bake --file docker-bake.hcl --builder kafkabuilder --no-cache --pull --load --set *.platform=linux/amd64
# docker buildx bake --file docker-bake.hcl --builder kafkabuilder --no-cache --pull --push

group "default" {
  targets = [
    "3_5_1-2_12",
    "3_5_1-2_13",

    "3_6_0-2_12",
    "3_6_0-2_13"
  ]
}

variable "JRE" {
  default = "eclipse-temurin:21.0.1_12-jre-jammy"
}

target "base-jre" {
  dockerfile = "Dockerfile"
  context = "."
  platforms = ["linux/amd64", "linux/arm64/v8"]
}

target "3_5_1-2_12" {
  inherits = ["base-jre"]
  tags = ["moukoublen/kafka:3.5.1-2.12"]
  args = {
    jre = "${JRE}"
    kafka = "3.5.1"
    scala = "2.12"
  }
}

target "3_5_1-2_13" {
  inherits = ["base-jre"]
  tags = ["moukoublen/kafka:3.5.1-2.13"]
  args = {
    jre = "${JRE}"
    kafka = "3.5.1"
    scala = "2.13"
  }
}

target "3_6_0-2_12" {
  inherits = ["base-jre"]
  tags = ["moukoublen/kafka:3.6.0-2.12"]
  args = {
    jre = "${JRE}"
    kafka = "3.6.0"
    scala = "2.12"
  }
}

target "3_6_0-2_13" {
  inherits = ["base-jre"]
  tags = ["moukoublen/kafka:3.6.0-2.13", "moukoublen/kafka:latest"]
  args = {
    jre = "${JRE}"
    kafka = "3.6.0"
    scala = "2.13"
  }
}