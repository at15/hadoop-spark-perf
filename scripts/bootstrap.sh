#!/usr/bin/env bash

echo "Install system tools"

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y vim git curl wget build-essential gcc make linux-tools-generic

# TODO: install JDK and set environment
