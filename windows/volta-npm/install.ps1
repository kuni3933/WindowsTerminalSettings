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

Write_Title("# volta")
volta -v
volta list all
br(1)

Write_Title("# volta install node@latest")
if(Test-Path "$env:LOCALAPPDATA/Volta/tools/image/node"){
  Remove-Item -Recurse $env:LOCALAPPDATA/Volta/tools/image/node
}
volta install node@latest
br(1)

Write_Title("volta install yarn@latest")
if(Test-Path "$env:LOCALAPPDATA/Volta/tools/image/yarn"){
  Remove-Item -Recurse $env:LOCALAPPDATA/Volta/tools/image/yarn
}
volta install yarn@latest
br(1)

Write_Title("# npm update *")
npm update *
br(1)

Write_Title("# npm-upgrade")
npm install -g npm-upgrade
br(1)

Write_Title("# volta list all")
volta list all
br(1)

Write_Section("# volta-npm/install.ps1 has finished.")
br(2)
