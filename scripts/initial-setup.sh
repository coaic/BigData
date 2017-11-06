#!/bin/bash
#
export KAFKA_VERSION=2.12-1.0.0
export KAFKA_MIRROR="http://mirror.intergrid.com.au/apache/kafka/1.0.0/kafka_${KAFKA_VERSION}.tgz"
export RUNTIME_ARTIFACTS="./run-time-artifacts"
#
mkdir -p ${RUNTIME_ARTIFACTS}
#
# Kafka
#
cd ${RUNTIME_ARTIFACTS}
wget ${KAFKA_MIRROR}
ln -s kafka_${KAFKA_VERSION} kafka
cd ..
#
# Scala Kafka Streams Examples
#
git clone git@github.com:coaic/kafka-streams-scala-examples.git
#
# JSON data generator
#
git clone git@github.com:coaic/json-data-generator.git
cd json-data-generator
mvn clean package
cp target/json-data-generator-1.0.0-bin.tar ../run-time-artifacts
cd run-time-artifacts
tar xvf json-data-generator-1.0.0-bin.tar
ln -Fs json-data-generator-1.3.1-SNAPSHOT json-data-generator
cd ..
#
# Add more initial stuff
#
