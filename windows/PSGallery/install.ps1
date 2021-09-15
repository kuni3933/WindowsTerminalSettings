. "./../Function.ps1"

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Write_Section("PSGallery/install.ps1")


Write_Title("Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force")
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
br(1)

Write_Title("Install-Module -Name PSReadLine -Scope CurrentUser -Force")
Install-Module -Name PSReadLine -Scope CurrentUser -Force
br(1)

Write_Title("Install-Module -Name PSFzf -Scope CurrentUser -Force")
Install-Module -Name PSFzf -Scope CurrentUser -Force
br(1)

Write_Title("iwr -useb get.scoop.sh | iex")
if (Test-Path ~/scoop/shims/scoop.cmd) {
  Write-Host "Already installed." -ForegroundColor Yellow
}
else{
  Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
}
br(1)

Write_Title("Invoke-WebRequest dein.vim/master/bin/installer.ps1 -OutFile ~/installer.ps1")
Invoke-WebRequest https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.ps1 -OutFile installer.ps1
# Allow to run third-party script
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# For example, we just use `~/.cache/dein` as installation directory
./installer.ps1 ~/.cache/dein
Remove-Item ./installer.ps1
br(1)


Write_Section("# PSGallery/install.ps1 has finished.")
br(2)
