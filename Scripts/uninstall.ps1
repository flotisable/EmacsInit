$settingFile  = "./settings.toml"
$scriptDir    = "$(Split-Path $PSCommandPath )"

. ${scriptDir}/readSettings.ps1 ${settingFile}

ForEach( $target in $settings['target'].keys )
{
  If( $target -eq 'dir' )
  {
    Continue
  }
  $targetFile = Invoke-Expression "Write-Output `"$($settings['target']['dir'])/$($settings['target'][$target])`""

  Write-Host "remove $target"
  Remove-Item $targetFile
}
