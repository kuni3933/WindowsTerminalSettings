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
if(Test-Path "$env:USERPROFILE/WindowsTerminalSettings"){
  Set-Location $env:USERPROFILE/WindowsTerminalSettings
}
else{
  exit
}

Write_Section("PSGallery/install.ps1")
./windows/PSGallery/install.ps1
br(2)

Write_Section("winget/install.ps1")
./windows/winget/install.ps1
br(2)

Write_Section("scoop/install.ps1")
./windows/scoop/install.ps1
br(2)

Write_Section("volta-npm/install.ps1")
./windows/volta-npm/install.ps1
br(2)

Write_Section("go/install.ps1")
./windows/go/install.ps1
br(2)

Write_Section("cargo/install.ps1")
./windows/cargo/install.ps1
br(2)

Write_Section("Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force")
Set-ExecutionPolicy Undefined -Force
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
br(2)

Write_Section("isntall.ps1 is Finished.")
Get-ExecutionPolicy -List
br(2)
