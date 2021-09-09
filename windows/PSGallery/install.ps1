function Write_Title($msg) {
  Write-Host "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
  Write-Host "┃$msg" -ForegroundColor Yellow
  Write-Host "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
}
function Write_Section($msg) {
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
    Write-Host "     $msg" -ForegroundColor Green
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
}
function br($times) {
  $tmp = 1
  while ($tmp -le $times) {
    Write-Output " ";
    $tmp += 1
  }
}


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
  iwr -useb get.scoop.sh | iex
}
br(1)

Write_Title("Invoke-WebRequest dein.vim/master/bin/installer.ps1 -OutFile ~/installer.ps1")
Invoke-WebRequest https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.ps1 -OutFile installer.ps1
# Allow to run third-party script
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# For example, we just use `~/.cache/dein` as installation directory
./installer.ps1 ~/.cache/dein
rm ./installer.ps1
br(1)

Write_Title("Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force")
Set-ExecutionPolicy Undefined -Force
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
br(1)

Write_Section("# PSGallery/install.ps1 has finished.")
Get-ExecutionPolicy -List
br(2)
