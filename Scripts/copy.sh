#!/bin/sh
settingFile="./settings.toml"

scriptDir="$(dirname $0)"

. ${scriptDir}/readSettings.sh ${settingFile}

targetTableName=$(mapFind "settings" "target")
sourceTableName=$(mapFind "settings" "source")

for target in $(mapKeys "$targetTableName"); do

  if [ "$target" == 'dir' ]; then

    continue

  fi

  targetFile="$(mapFind "$targetTableName" "dir")/$(mapFind "$targetTableName" "$target")"
  sourceFile=$(mapFind "$sourceTableName" "$target")

  if [ -r "$targetFile" ]; then

    echo "copy $targetFile to $sourceFile"
    cp $targetFile $sourceFile

  fi

done
