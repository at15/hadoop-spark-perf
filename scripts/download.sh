#!/usr/bin/env bash

echo "Download tarballs"

JDK_VERSION=8u121
JDK_TAR=jdk-${JDK_VERSION}-linux-x64.tar.gz

MAVEN_VERSION=3.3.9
MAVEN_TAR=apache-maven-${MAVEN_VERSION}-bin.tar.gz
MAVEN_DOWNLOAD=http://www-us.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/${MAVEN_TAR}

HADOOP_VERSION=2.7.3
HADOOP_TAR=hadoop-${HADOOP_VERSION}.tar.gz
HADOOP_DOWNLOAD=http://www-us.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/${HADOOP_TAR}

SPARK_VERSION=2.1.0
SPARK_TAR=spark-${SPARK_VERSION}-bin-without-hadoop.tgz
SPARK_DOWNLOAD=http://www-us.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_TAR}

HIBENCH_ZIP=hibench.zip
HIBENCH_DOWNLOAD=https://github.com/intel-hadoop/HiBench/archive/master.zip

# echo Hadoop version: ${HADOOP_VERSION}
# echo Hadoop download url: ${HADOOP_DOWNLOAD}

# get the script path http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
ORIGINAL_WD=${PWD}
cd ${SCRIPTPATH}

if [ -f ${JDK_TAR} ]; then
    echo "Already downloaded JDK ${JDK_VERSION}"
else
    echo "Start downloading JDK ${JDK_VERSION}"
    # http://askubuntu.com/questions/651752/how-to-download-and-install-oracle-java-by-a-script
    wget --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
        $(curl -s http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html | \
            awk "/downloads\['/ && ! /demos/ && /\['files'\]/ && /linux-x64/ && /\.tar\.gz/" | \
            grep -o 'http.*\.tar\.gz'\
        )
fi


if [ -f ${MAVEN_TAR} ]; then
    echo "Already downloaded Maven ${MAVEN_VERSION}"
else
    echo "Start downloading Maven"
    wget ${MAVEN_DOWNLOAD}
fi


if [ -f ${HADOOP_TAR} ]; then
    echo "Already downloaded Hadoop ${HADOOP_VERSION}"
else
    echo "Start downloading from ${HADOOP_DOWNLOAD}"
    wget ${HADOOP_DOWNLOAD}
fi


if [ -f ${SPARK_TAR} ]; then
    echo "Already downloaded Spark ${SPARK_VERSION}"
else
    echo "Start downloading from ${SPARK_DOWNLOAD}"
    wget ${SPARK_DOWNLOAD}
fi


if [ -f ${HIBENCH_ZIP} ]; then
    echo "Already downloaded HiBench"
else
    echo "Start downloading HiBench"
    wget ${HIBENCH_DOWNLOAD}
    mv master.zip ${HIBENCH_ZIP}
fi

cd ${ORIGINAL_WD}
