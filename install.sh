#!/bin/sh

if [ -z ${OS} ]; then
  OS=$(uname -s);
fi

echo "detected OS: ${OS}"

. ./settings

if [ -z ${targetDir} ]; then
  targetDir=$(./default.sh ${OS});
fi

echo "install emacs init file"
cp ${initSourceName} ${targetDir}/${initTargetName}
