#!/usr/bin/env bash

echo "Install system tools"

sudo apt-get update
# FIXME: this upgrade will trigger grub update, which have a text UI
sudo apt-get upgrade -y
# NOTE: just installing linux-tools-generic is not enough, you must specify version
sudo apt-get install -y vim git curl wget zip build-essential gcc make linux-tools-common linux-tools-generic linux-tools-`uname -r` ssh rsync

# ssh without key
if [ -f "${HOME}/.ssh/id_rsa" ]; then
    echo "SSH key pair already generated"
else
    ssh-keygen -t rsa -f ~/.ssh/id_rsa -P ''
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
fi

if [ -f "${HOME}/.ssh/config" ]; then
    echo "SSH config is already copied"
else
    cp config/ssh_config ${HOME}/.ssh/config
fi

echo "Finish install system tools"
