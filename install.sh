#!/bin/sh

if [ -z ${OS} ]; then
  OS=$(uname -s);
fi

. ./settings

if [ -z ${targetDir} ]; then
  targetDir=$(./default.sh ${OS});
fi

cp ${initSourceName} ${targetDir}/${initTargetName}
