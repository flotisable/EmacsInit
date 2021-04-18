. ./readSettings.ps1 "./settings"

if( $targetDir -eq "" )
{
  $targetDir = $(./default.ps1 $env:OS)
}

Write-Host "install emacs init file"
Copy-Item ${initSourceName} ${targetDir}/${initTargetName}
