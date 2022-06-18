$settingFile  = "./settings.toml"
$scriptDir    = "$(Split-Path $PSCommandPath )"

. ${scriptDir}/readSettings.ps1 ${settingFile}

ForEach( $target in $settings['target'].keys )
{
  $targetFile = Invoke-Expression "Write-Output `"$($settings['dir']['target'])/$($settings['target'][$target])`""
  $sourceFile = Invoke-Expression "Write-Output $($settings['source'][$target])"

  Write-Host "install $target"
  Copy-Item $sourceFile $targetFile
}
