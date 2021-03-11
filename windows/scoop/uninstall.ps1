#uninstall
scoop uninstall `
  gcc `


./install.bat
scoop update git -g
scoop update *
scoop cleanup *
scoop status

$input_tmp = Read-Host "ENTERを押して終了します。 `r`n Press ENTER to exit. `r`n"
echo "'uninstall.ps1' has finished."
