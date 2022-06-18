$settingFile = "./settings.toml"

$scriptDir = "$(Split-Path $PSCommandPath)"

. ${scriptDir}/readSettings.ps1 $settingFile

ForEach( $target in $settings['target'].keys )
{
  If( $target -eq 'dir' )
  {
    Continue
  }

  $targetFile = Invoke-Expression "Write-Output `"$($settings['target']['dir'])/$($settings['target'][$target])`""
  $sourceFile = Invoke-Expression "Write-Output $($settings['source'][$target])"

  Write-Host "copy $targetFile to $sourceFile"
  Copy-Item $targetFile $sourceFile
}
