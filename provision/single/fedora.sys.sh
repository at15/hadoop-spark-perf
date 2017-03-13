#!/usr/bin/env bash

echo "Install system tools"

# get the script path http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
ORIGINAL_WD=${PWD}
cd ${SCRIPTPATH}

sudo dnf upgrade -y
# FIXME: got error when install, error no match
sudo dnf install -y vim git curl wget zip gcc perf nginx
# https://fedoraproject.org/wiki/Nginx
sudo systemctl enable nginx.service

echo "Finish install system tools"

cd ${ORIGINAL_WD}
