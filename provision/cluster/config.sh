#!/usr/bin/env bash

echo "Start config"

# get the script path http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
ORIGINAL_WD=${PWD}
cd ${SCRIPTPATH}

source common.sh

cp hosts /tmp/
sudo mv /tmp/hosts /etc/hosts

./spark/config.sh

echo "Finish config"

cd ${ORIGINAL_WD}
