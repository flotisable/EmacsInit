. ./readSettings.ps1 "./settings.toml"

ForEach( $target in $settings['target'].keys )
{
  If( $target -eq 'dir' )
  {
    Continue
  }
  $targetFile = Invoke-Expression "Write-Output `"$($settings['target']['dir'])/$($settings['target'][$target])`""
  $sourceFile = Invoke-Expression "Write-Output $($settings['source'][$target])"

  Write-Host "install $target"
  Copy-Item $sourceFile $targetFile
}
