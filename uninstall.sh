#!/bin/bash

. ./settings

if [ -z ${OS} ]; then
  OS=$(uname -s);
fi

echo "detected OS: ${OS}"

if [ -z ${targetDir} ]; then

  targetDir=$(./default.sh $OS)

fi

echo "uninstall emacs init file"
rm ${targetDir}/${initTargetName}
