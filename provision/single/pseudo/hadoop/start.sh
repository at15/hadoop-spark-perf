#!/usr/bin/env bash

echo "Start HDFS"

# get the script path http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
ORIGINAL_WD=${PWD}
cd ${SCRIPTPATH}

source ../common.sh

${HADOOP_HOME}/sbin/start-dfs.sh

echo "Finish start hdfs"

cd ${ORIGINAL_WD}
