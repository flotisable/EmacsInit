#!/bin/sh
settingFile="./settings.toml"

scriptDir="$(dirname $0)"

. ${scriptDir}/readSettings.sh ${settingFile}

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
dirTableName=$(mapFind "settings" "dir")

for target in $(mapKeys "$targetTableName"); do

  targetFile="$(mapFind "$dirTableName" "target")/$(mapFind "$targetTableName" "$target")"
  sourceFile=$(mapFind "$sourceTableName" "$target")

  installFile $sourceFile $targetFile $target

done
