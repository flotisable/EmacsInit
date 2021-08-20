#!/bin/sh

. ./readSettings.sh "./settings.toml"

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
