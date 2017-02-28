#!/usr/bin/env bash

JDK_VERSION=8u121
JDK_TAR=jdk-${JDK_VERSION}-linux-x64.tar.gz
JDK_FOLDER=jdk1.8.0_121

MAVEN_VERSION=3.3.9
MAVEN_TAR=apache-maven-${MAVEN_VERSION}-bin.tar.gz
MAVEN_DOWNLOAD=http://www-us.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/${MAVEN_TAR}
MAVEN_FOLDER=apache-maven-${MAVEN_VERSION}

HADOOP_VERSION=2.7.3
HADOOP_TAR=hadoop-${HADOOP_VERSION}.tar.gz
HADOOP_DOWNLOAD=http://www-us.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/${HADOOP_TAR}

SPARK_VERSION=2.1.0
SPARK_TAR=spark-${SPARK_VERSION}-bin-without-hadoop.tgz
SPARK_DOWNLOAD=http://www-us.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_TAR}

HIBENCH_ZIP=hibench.zip
HIBENCH_DOWNLOAD=https://github.com/intel-hadoop/HiBench/archive/master.zip