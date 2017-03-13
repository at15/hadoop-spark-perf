#!/usr/bin/env bash

echo "Run HiBench Hadoop"

# get the script path http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
ORIGINAL_WD=${PWD}
cd ${SCRIPTPATH}

source ../common.sh

${HIBENCH_HOME}/bin/workloads/micro/sort/hadoop/run.sh

echo "Finish HiBench Hadoop"

cd ${ORIGINAL_WD}
