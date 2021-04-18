Param( $os )

Switch( ${os} )
{
  Linux       { "$env:USERPROFILE"      }
  Windows_NT  { "$env:APPDATA\.emacs.d" }
  Darwin      { "$env:USERPROFILE"      }
}
