#!/usr/bin/env bash

echo "Start config"

# get the script path http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
ORIGINAL_WD=${PWD}
cd ${SCRIPTPATH}

source common.sh

cp config/hosts /tmp/
sudo mv /tmp/hosts /etc/hosts
echo "hosts file copied"

cp config/id_rsa ~/.ssh
chmod 600 ~/.ssh/id_rsa
cp config/id_rsa.pub ~/.ssh
chmod 600 ~/.ssh/id_rsa.pub
cp config/ssh_config ${HOME}/.ssh/config
chmod 600 ~/.ssh/config
echo "SSH config copied"

# TODO: need to detect if it is already appended
# cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

./spark/config.sh
./hadoop/config.sh
./hibench/config.sh

echo "Finish config"

cd ${ORIGINAL_WD}
