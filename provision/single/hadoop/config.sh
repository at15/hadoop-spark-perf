#!/usr/bin/env bash

echo "Start config"

# get the script path http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
ORIGINAL_WD=${PWD}
cd ${SCRIPTPATH}

source ../common.sh

cp config/* /tmp/

echo "Config hadoop"

mv /tmp/slaves  ${HADOOP_HOME}/etc/hadoop/slaves

mv /tmp/hadoop-env.sh ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh
mv /tmp/hdfs-site.xml ${HADOOP_HOME}/etc/hadoop/hdfs-site.xml
mv /tmp/core-site.xml ${HADOOP_HOME}/etc/hadoop/core-site.xml
mv /tmp/yarn-site.xml ${HADOOP_HOME}/etc/hadoop/yarn-site.xml
mv /tmp/mapred-site.xml ${HADOOP_HOME}/etc/hadoop/mapred-site.xml


echo "Finish config"

cd ${ORIGINAL_WD}
