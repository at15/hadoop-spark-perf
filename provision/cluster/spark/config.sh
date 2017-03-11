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

echo "Config Spark"

mv /tmp/slaves ${SPARK_HOME}/conf/slaves
mv /tmp/spark-env.sh ${SPARK_HOME}/conf/spark-env.sh

echo "Finish config"

cd ${ORIGINAL_WD}
