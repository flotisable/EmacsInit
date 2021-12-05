#!/bin/sh
settingFile="./settings.toml"

scriptDir="$(dirname $0)"

. ${scriptDir}/readSettings.sh ${settingFile}

removeFile()
{
  local file=$1

  echo "remove $file"
  rm $file
}

targetTableName=$(mapFind "settings" "target")
dir=$(mapFind "$targetTableName" "dir")

for target in $(mapKeys "$targetTableName"); do

  if [ "$target" == 'dir' ]; then

    continue

  fi

  targetFile="$dir/$(mapFind "$targetTableName" "$target")"

  removeFile $targetFile

done
