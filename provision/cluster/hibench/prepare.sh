#!/usr/bin/env bash

echo "Prepare HiBench"

# get the script path http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
ORIGINAL_WD=${PWD}
cd ${SCRIPTPATH}

source ../common.sh

${HIBENCH_HOME}/bin/workloads/micro/wordcount/prepare/prepare.sh

echo "Finish HiBench prepare"

cd ${ORIGINAL_WD}
