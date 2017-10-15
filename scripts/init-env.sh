#!/bin/bash
#
# Initialise environments
#
called=$_
[[ ${called} != $0 ]] && true  ||  echo "Script must be sourced" || exit 1
echo "BASH_SOURCE: ${BASH_SOURCE[@]}"
dirname ${BASH_SOURCE[@]}
scripts_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#
# Init Kafka environment
#
unset KAFKA_HOME
export KAFKA_HOME="$( cd ${scripts_dir}/../kafka && pwd )"
echo "KAFKA_HOME: ${KAFKA_HOME}"
