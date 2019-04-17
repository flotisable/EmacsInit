#!/bin/sh

. ./settings

if [ -z ${targetDir} ]; then
  targetDir=$(./default.sh ${os});
fi

cp ${initSourceName} ${targetDir}/${initTargetName}
