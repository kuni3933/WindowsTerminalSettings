. "./../Function.ps1"

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("PSGallery/install.ps1")


_Write_Title("Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force")
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
_br(1)

_Write_Title("Install-Module -Name PSReadLine -Scope CurrentUser -Force")
Install-Module -Name PSReadLine -Scope CurrentUser -Force
_br(1)

_Write_Title("Install-Module -Name PSFzf -Scope CurrentUser -Force")
Install-Module -Name PSFzf -Scope CurrentUser -Force
_br(1)

_Write_Title("iwr -useb get.scoop.sh | iex")
if (Test-Path ~/scoop/shims/scoop.cmd) {
  Write-Host "Already installed." -ForegroundColor Yellow
}
else{
  Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
}
_br(1)

_Write_Title("Chocolatey")
if(Test-Path "${env:PROGRAMDATA}/chocolatey/choco.exe"){
  Write-Host "Already installed." -ForegroundColor Yellow
}
else{
  Set-ExecutionPolicy Bypass -Scope Process -Force;[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

_Write_Title("Invoke-WebRequest dein.vim/master/bin/installer.ps1 -OutFile ~/installer.ps1")
Invoke-WebRequest https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.ps1 -OutFile installer.ps1
# Allow to run third-party script
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# For example, we just use `~/.cache/dein` as installation directory
./installer.ps1 ~/.cache/dein
Remove-Item ./installer.ps1
_br(1)


_Set_ExecutionPolicy
_br(2)

_Write_Section("# PSGallery/install.ps1 has finished.")
_br(2)

