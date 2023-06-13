# https://docs.docker.com/build/bake/
# https://docs.docker.com/build/bake/file-definition

# docker buildx bake --file docker-bake.hcl --builder kafkabuilder --no-cache --pull --load --set *.platform=linux/amd64
# docker buildx bake --file docker-bake.hcl --builder kafkabuilder --no-cache --pull --push

group "default" {
  targets = [
    "2_8_2-2_12",
    "2_8_2-2_13",

    "3_3_2-2_12",
    "3_3_2-2_13",

    "3_4_0-2_12",
    "3_4_0-2_13",

    "3_4_1-2_12",
    "3_4_1-2_13"
  ]
}

variable "JRE" {
  default = "eclipse-temurin:17.0.7_7-jre-jammy"
}

target "base-jre" {
  dockerfile = "Dockerfile"
  context = "."
  platforms = ["linux/amd64", "linux/arm/v7", "linux/arm64/v8"]
}

target "2_8_2-2_12" {
  inherits = ["base-jre"]
  tags = ["moukoublen/kafka:2.8.2-2.12"]
  args = {
    jre = "${JRE}"
    kafka = "2.8.2"
    scala = "2.12"
  }
}

target "2_8_2-2_13" {
  inherits = ["base-jre"]
  tags = ["moukoublen/kafka:2.8.2-2.13"]
  args = {
    jre = "${JRE}"
    kafka = "2.8.2"
    scala = "2.13"
  }
}

target "3_3_2-2_12" {
  inherits = ["base-jre"]
  tags = ["moukoublen/kafka:3.3.2-2.12"]
  args = {
    jre = "${JRE}"
    kafka = "3.3.2"
    scala = "2.12"
  }
}

target "3_3_2-2_13" {
  inherits = ["base-jre"]
  tags = ["moukoublen/kafka:3.3.2-2.13"]
  args = {
    jre = "${JRE}"
    kafka = "3.3.2"
    scala = "2.13"
  }
}

target "3_4_0-2_12" {
  inherits = ["base-jre"]
  tags = ["moukoublen/kafka:3.4.0-2.12"]
  args = {
    jre = "${JRE}"
    kafka = "3.4.0"
    scala = "2.12"
  }
}

target "3_4_0-2_13" {
  inherits = ["base-jre"]
  tags = ["moukoublen/kafka:3.4.0-2.13"]
  args = {
    jre = "${JRE}"
    kafka = "3.4.0"
    scala = "2.13"
  }
}

target "3_4_1-2_12" {
  inherits = ["base-jre"]
  tags = ["moukoublen/kafka:3.4.1-2.12"]
  args = {
    jre = "${JRE}"
    kafka = "3.4.0"
    scala = "2.12"
  }
}

target "3_4_1-2_13" {
  inherits = ["base-jre"]
  tags = ["moukoublen/kafka:3.4.1-2.13", "moukoublen/kafka:latest"]
  args = {
    jre = "${JRE}"
    kafka = "3.4.0"
    scala = "2.13"
  }
}