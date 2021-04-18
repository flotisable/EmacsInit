. ./readSettings.ps1 "./settings"

if( $targetDir -eq "" )
{
  $targetDir = $(./default.ps1 $env:OS)
}

Write-Host "uninstall emacs init file"

Remove-Item ${targetDir}/${initTargetName}
