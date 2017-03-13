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

# ssh without key
if [ -f "${HOME}/.ssh/id_rsa" ]; then
    echo "SSH key pair is already copied"
else
# use the same ssh key pair for every machine, so they can all ssh into each other without password
    cp config/id_rsa ~/.ssh
    cp config/id_rsa.pub ~/.ssh
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
    echo "SSH key pair copied"
fi

if [ -f "${HOME}/.ssh/config" ]; then
    echo "SSH config is already copied"
else
    cp config/ssh_config ${HOME}/.ssh/config
    echo "SSH config copied"
fi

echo "Finish install system tools"

cd ${ORIGINAL_WD}
