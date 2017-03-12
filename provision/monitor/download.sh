#!/usr/bin/env bash

echo "Download tarballs"

# get the script path http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
ORIGINAL_WD=${PWD}
cd ${SCRIPTPATH}

if [ -f "grafana-4.2.0.linux-x64.tar.gz" ]; then
    echo "Already downloaded Grafana"
else
    echo "Start downloading Grafana"
    wget https://grafanarel.s3.amazonaws.com/builds/grafana-4.2.0.linux-x64.tar.gz
fi

if [ -f "prometheus-1.5.2.linux-amd64.tar.gz" ]; then
    echo "Already downloaded Prometheus"
else
    echo "Start downloading Prometheus"
    wget https://github.com/prometheus/prometheus/releases/download/v1.5.2/prometheus-1.5.2.linux-amd64.tar.gz
fi

cd ${ORIGINAL_WD}
