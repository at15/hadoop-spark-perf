#!/usr/bin/env bash

echo "Start Spark"

# get the script path http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
ORIGINAL_WD=${PWD}
cd ${SCRIPTPATH}

source ../common.sh

${SPARK_HOME}/sbin/start-all.sh

echo "Finish start Spark"

cd ${ORIGINAL_WD}
