#!/usr/bin/env bash

echo "Start config"

# get the script path http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
ORIGINAL_WD=${PWD}
cd ${SCRIPTPATH}

source ../common.sh

cp config/* /tmp/

echo "Config HiBench"

mv /tmp/hibench.conf ${HIBENCH_HOME}/conf/hibench.conf
mv /tmp/hadoop.conf ${HIBENCH_HOME}/conf/hadoop.conf
mv /tmp/spark.conf ${HIBENCH_HOME}/conf/spark.conf

echo "Finish config"

cd ${ORIGINAL_WD}
