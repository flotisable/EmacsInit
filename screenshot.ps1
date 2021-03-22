param( $file )

$snippingTool = "$env:windir/system32/SnippingTool.exe"

Start-Process -Wait -NoNewWindow 'powershell' "-NoProfile -WindowStyle Hidden -Command $snippingTool /clip"

$image = Get-Clipboard -Format Image

$image.save( "$file" )
