#!/usr/bin/env bash

echo "Stop Spark"

# get the script path http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
ORIGINAL_WD=${PWD}
cd ${SCRIPTPATH}

source ../common.sh

${SPARK_HOME}/sbin/stop-all.sh

echo "Finish stop Spark"

cd ${ORIGINAL_WD}
