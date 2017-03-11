#!/usr/bin/env bash
echo "Sync common configuration from base box to single, cluster, monitor"

# get the script path http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
ORIGINAL_WD=${PWD}
cd ${SCRIPTPATH}

cp -v base/common.sh single/pseudo/common.sh
cp -v base/common.sh single/yarn/common.sh
cp -v base/common.sh cluster/common.sh

echo "Finish Sync"

cd ${ORIGINAL_WD}
