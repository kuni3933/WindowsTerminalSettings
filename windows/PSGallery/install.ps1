function Write_Title($msg) {
  Write-Host "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
  Write-Host "┃$msg" -ForegroundColor Yellow
  Write-Host "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
}
function br($times) {
  $tmp = 1
  while ($tmp -le $times) {
    Write-Output " ";
    $tmp += 1
  }
}


Write_Title "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force"
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
br(1)

Write_Title "Install-Module -Name PSReadLine -Scope CurrentUser -Force"
Install-Module -Name PSReadLine -Scope CurrentUser -Force
br(1)

Write_Title "Install-Module -Name PSFzf -Scope CurrentUser -Force"
Install-Module -Name PSFzf -Scope CurrentUser -Force
br(1)

Write_Title "iwr -useb get.scoop.sh | iex"
iwr -useb get.scoop.sh | iex
br(1)

Write_Title "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force"
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
Get-ExecutionPolicy -l
Write_Title " 'install.ps1'が終了しました. / 'install.ps1' has finished."
