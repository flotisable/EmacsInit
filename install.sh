#!/bin/sh
settingFile="./settings.toml"

. ./readSettings.sh ${settingFile}

installFile()
{
  local sourceFile=$1
  local targetFile=$2
  local fileMessage=$3

  echo "install $fileMessage"
  cp $sourceFile $targetFile 
}

targetTableName=$(mapFind "settings" "target")
sourceTableName=$(mapFind "settings" "source")
dir=$(mapFind "$targetTableName" "dir")

for target in $(mapKeys "$targetTableName"); do

  if [ "$target" == 'dir' ]; then

    continue

  fi

  targetFile="$dir/$(mapFind "$targetTableName" "$target")"
  sourceFile=$(mapFind "$sourceTableName" "$target")

  installFile $sourceFile $targetFile $target

done
