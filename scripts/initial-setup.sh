#!/bin/bash
#
# Kafka
#
wget http://mirror.ventraip.net.au/apache/kafka/0.11.0.1/kafka_2.12-0.11.0.1.tgz
#
# Scala Kafka Streams Examples
#
git clone git@github.com:coaic/kafka-streams-scala-examples.git
#
# JSON data generator
#
git clone git@github.com:coaic/json-data-generator.git
mkdir -p run-time-artifacts
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
