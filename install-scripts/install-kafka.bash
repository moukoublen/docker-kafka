#!/usr/bin/env bash

set -e

KAFKA_HOME=${KAFKA_HOME:-"/opt/kafka"}
SCALA_VERSION=${SCALA_VERSION:-2.13}
KAFKA_VERSION=${KAFKA_VERSION:-3.0.0}
FILENAME="kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz"

echo "Installing kafka ${SCALA_VERSION}-${KAFKA_VERSION}"

url=$(curl --fail --silent --stderr /dev/null "https://www.apache.org/dyn/closer.cgi?path=/kafka/${KAFKA_VERSION}/${FILENAME}&as_json=1" | jq -r '"\(.preferred)\(.path_info)"')

# Test if mirror is valid. Fallback to archive.apache.org
if [[ ! $(curl --fail --silent --head "${url}") ]]; then
  url="https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/${FILENAME}"
fi

echo "Downloading Kafka from $url"
curl --fail --silent --show-error --location "${url}" --output "/tmp/${FILENAME}"

echo "Installing Kafka to ${KAFKA_HOME}"
tar --extract --gzip --verbose --file=/tmp/${FILENAME} --directory=/opt
ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME}
ls -la /opt/
rm -rf /tmp/${FILENAME}
cp -r $KAFKA_HOME/config $KAFKA_HOME/config-backup
