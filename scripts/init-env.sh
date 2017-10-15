#!/bin/bash
#
# Initialise environments
#
called=$_
[[ ${called} != $0 ]] && true  ||  echo "Script must be sourced" || exit 1
echo "BASH_SOURCE: ${BASH_SOURCE[@]}"
scripts_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
unset PROJECTS_DIR
export PROJECTS_DIR="$( cd ${scripts_dir}/.. && pwd )"
echo "PROJECTS_DIR: ${PROJECTS_DIR}"
#
# Init Kafka environment
#
unset KAFKA_HOME
export KAFKA_HOME="$( cd ${PROJECTS_DIR}/run-time-artifacts/kafka && pwd )"
echo "KAFKA_HOME: ${KAFKA_HOME}"
unset LOG_DIR
export LOG_DIR="${PROJECTS_DIR}/logs"
echo "LOG_DIR: ${LOG_DIR}"
unset GC_LOG_FILE_NAME
GC_LOG_FILE_NAME="kafka_gc.log"
unset KAFKA_GC_LOG_OPTS
export KAFKA_GC_LOG_OPTS="-Xlog:gc:$LOG_DIR/$GC_LOG_FILE_NAME -verbose:gc -Xlog:gc*"
unset KAFKA_JMX_OPTS
export KAFKA_JMX_OPTS="--add-modules java.xml.bind -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false  -Dcom.sun.management.jmxremote.ssl=false "
unset ZOOKEPER_LOCATION
export ZOOKEEPER_LOCATION="localhost:2181"
unset BROKER_LOCATION
export BROKER_LOCATION="localhost:9092"
#
# start zookeeper
#
run_zookeeper() {
  ${KAFKA_HOME}/bin/zookeeper-server-start.sh ${KAFKA_HOME}/config/zookeeper.properties &
}
#
# start server/broker
#
run_kafka_server() {
  ${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_HOME}/config/server.properties &
}
#
# list topics
#
run_list_topics() {
  unset KAFKA_GC_LOG_OPTS
  ${KAFKA_HOME}/bin/kafka-topics.sh --list --zookeeper ${ZOOKEEPER_LOCATION}
}
#
# create topic
#
run_create_topic() {
  unset KAFKA_GC_LOG_OPTS
  ${KAFKA_HOME}/bin/kafka-topics.sh --create --zookeeper ${ZOOKEEPER_LOCATION} --replication-factor 1 --partitions 1 --topic $1
}
#
# send messages to topic
#
run_console_producer() {
  unset KAFKA_GC_LOG_OPTS
  ${KAFKA_HOME}/bin/kafka-console-producer.sh --broker-list ${BROKER_LOCATION} --topic $1
}
#
# read ALL messages from a topic
#
run_console_consumer_from_beginning() {
  unset KAFKA_GC_LOG_OPTS
  ${KAFKA_HOME}/bin/kafka-console-consumer.sh --bootstrap-server ${BROKER_LOCATION} --topic $1 --from-beginning
}
#
# read unread messages from a topic
#
run_console_consumer() {
  unset KAFKA_GC_LOG_OPTS
  ${KAFKA_HOME}/bin/kafka-console-consumer.sh --bootstrap-server ${BROKER_LOCATION} --topic $1
}
