. ./readSettings.ps1 "./settings.toml"

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
