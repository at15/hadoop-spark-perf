#!/usr/bin/env bash

echo "Toogle tar"

# get the script path http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
ORIGINAL_WD=${PWD}
cd ${SCRIPTPATH}

source common.sh

if [ -f ${JDK_TAR} ]; then
  echo "move out"
  mv *.gz ../tar
  mv *.tgz ../tar
else
  echo "move in"
  mv ../tar/*.gz .
  mv ../tar/*.tgz .
fi

echo "Finish toogle"

cd ${ORIGINAL_WD}
