#!/usr/bin/env bash

# get the script path http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
ORIGINAL_WD=${PWD}
cd ${SCRIPTPATH}

source common.sh
# incase you run the script several times in the same session, the updated sh in /etc/profild.d are not reflected in current session
source /etc/profile

# my personal flavor
function installAt15 {
    echo "Install at15's personal flavor"
    sudo rm -f /etc/profile.d/at15.sh
    echo "export GIT_EDITOR=vim" | sudo tee -a /etc/profile.d/at15.sh
    echo "alias cls='clear'" | sudo tee -a /etc/profile.d/at15.sh
    echo "alias wv='cd /vagrant'" | sudo tee -a /etc/profile.d/at15.sh
    echo "alias gst='git status'" | sudo tee -a /etc/profile.d/at15.sh
    source /etc/profile.d/at15.sh
}

function installJava {
    echo "Install Java ${JDK_VERSION}"
    sudo mkdir -p /usr/lib/jvm
    echo "tar -zxf ${JDK_TAR} -C /usr/lib/jvm"
    sudo tar -zxf ${JDK_TAR} -C /usr/lib/jvm
    sudo rm -f /etc/profile.d/java.sh
    # http://stackoverflow.com/questions/84882/sudo-echo-something-etc-privilegedfile-doesnt-work-is-there-an-alterna
    echo "export JAVA_HOME=/usr/lib/jvm/${JDK_FOLDER}" | sudo tee -a /etc/profile.d/java.sh
	  echo "export PATH=\${JAVA_HOME}/bin:\${PATH}" | sudo tee -a /etc/profile.d/java.sh
    # TODO: may need to run update alternative
    source /etc/profile.d/java.sh
}


function installMaven {
    echo "Install Maven ${MAVEN_VERSION}"
    sudo mkdir -p /usr/lib/maven
    sudo tar -zxf ${MAVEN_TAR} -C /usr/lib/maven
    sudo rm -f /etc/profile.d/maven.sh
    echo "export MAVEN_HOME=/usr/lib/maven/${MAVEN_FOLDER}" | sudo tee -a /etc/profile.d/maven.sh
	  echo "export PATH=\${MAVEN_HOME}/bin:\${PATH}" | sudo tee -a /etc/profile.d/maven.sh
    source /etc/profile.d/maven.sh
}

function installHibench {
    echo "Install HiBench"
    unzip hibench.zip -d /tmp
    sudo mv /tmp/HiBench-master /usr/lib/hibench
    cd /usr/lib/hibench
    mvn -Dscala=2.11 clean package
    cd ${SCRIPTPATH}
}

function installHadoop {
    echo "Install Hadoop"
    tar -zxf ${HADOOP_TAR} -C /tmp
    sudo mv /tmp/hadoop-${HADOOP_VERSION} ${HADOOP_HOME}
    sudo rm -f /etc/profile.d/hadoop.sh
    echo "export HADOOP_PREFIX=${HADOOP_HOME}" | sudo tee -a /etc/profile.d/hadoop.sh
    echo "export HADOOP_YARN_HOME=\${HADOOP_PREFIX}" | sudo tee -a /etc/profile.d/hadoop.sh
    echo "export HADOOP_CONF_DIR=\${HADOOP_PREFIX}/etc/hadoop" | sudo tee -a /etc/profile.d/hadoop.sh
    echo "export PATH=\${HADOOP_PREFIX}/bin:\${PATH}" | sudo tee -a /etc/profile.d/hadoop.sh
    source /etc/profile.d/hadoop.sh
}

function installSpark {
    echo "Install Spark"
    tar -zxf ${SPARK_TAR} -C /tmp
    sudo mv /tmp/${SPAKR_FOLDER} ${SPARK_HOME}
    sudo rm -f /etc/profile.d/spark.sh
    echo "export SPARK_HOME=${SPARK_HOME}" | sudo tee -a /etc/profile.d/spark.sh
    # TODO: may add other spark config
    source /etc/profile.d/spark.sh
}

if hash java 2>/dev/null; then
    echo "Java is installed"
else
    installJava
fi


if hash mvn 2>/dev/null; then
    echo "Maven is installed"
else
    installMaven
fi


if [ -d "/usr/lib/hibench" ]; then
    echo "HiBench is installed"
else
    installHibench
fi


if [ -d "${HADOOP_HOME}" ]; then
    echo "Hadoop is installed"
else
    installHadoop
fi

if [ -d "${SPARK_HOME}" ]; then
    echo "Spark is installed"
else
    installSpark
fi

installAt15

cd ${ORIGINAL_WD}
