#!/usr/bin/env bash

echo "Install system tools"

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y vim git curl wget zip build-essential gcc make linux-tools-generic

echo "Finish install system tools"