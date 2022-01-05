. "./../Function.ps1"

${USERNAME} = wsl -- whoami
if (${USERNAME} -eq "root"){
    _Write_Title "既定ユーザーをroot以外にしてから実行してください. / Set the default user to something other than root, and then run it."
    exit
}
${now} = Get-Location
${MyPath} = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location "${MyPath}/../../"
${WindowsTerminalSettings} = Get-Location
Set-Location ${now}
_Write_Title "USERNAME : ${USERNAME}"
wsl --terminate "Distrod"

#--------------------------------------------------------------------------------------------------
# 等性はないので注意
# 実行後に編集が必要なファイルもある
_Write_Title "cp ${env:USERPROFILE}\.gitconfig \\wsl$\Distrod\home\${USERNAME}\"
if (Test-Path ${env:USERPROFILE}/.gitconfig) {
  if (Test-Path "\\wsl$\Distrod\home\${USERNAME}\.gitconfig") {
    Write-Host "Already installed." -ForegroundColor Yellow
  }
  else {
    Copy-Item "${env:USERPROFILE}\.gitconfig" "\\wsl$\Distrod\tmp\"
    wsl -- mv /tmp/.gitconfig ~/
    Write-Host "Installation is complete." -ForegroundColor Green
  }
}
else {
  Write-Host "${env:USERPROFILE}/.gitconfig IS NOT FOUND." -ForegroundColor Red
}

# root/browserなどpathの変更が必要
_Write_Title "cp ${env:USERPROFILE}\.gowlconfig \\wsl$\Distrod\home\${USERNAME}\"
if (Test-Path ${env:USERPROFILE}/.gowlconfig) {
  if (Test-Path "\\wsl$\Distrod\home\${USERNAME}\.gowlconfig") {
    Write-Host "Already installed." -ForegroundColor Yellow
  }
  else {
    Copy-Item "${env:USERPROFILE}\.gowlconfig" "\\wsl$\Distrod\tmp"
    wsl -- mv /tmp/.gowlconfig ~/
    Write-Host "Installation is complete." -ForegroundColor Green
  }
}
else {
  Write-Host "${env:USERPROFILE}/.gowlconfig IS NOT FOUND." -ForegroundColor Red
}

# pathの変更が必要かも..
_Write_Title "cp ${USERPROFILE}\.ssh \\wsl$\Distrod\home\${USERNAME}\"
if (Test-Path ${env:USERPROFILE}/.ssh) {
  if (Test-Path "\\wsl$\Distrod\home\${USERNAME}\.ssh") {
    Write-Host "Already installed." -ForegroundColor Yellow
  }
  else {
    Copy-Item -r "${env:USERPROFILE}\.ssh" "\\wsl$\Distrod\tmp\"
    wsl -- rm -rf ~/.ssh
    wsl -- mv /tmp/.ssh ~/
    wsl -- chmod 600 ~/.ssh/*
    Write-Host "Installation is complete." -ForegroundColor Green
  }
}
else {
  Write-Host "${env:USERPROFILE}/.ssh IS NOT FOUND." -ForegroundColor Red
}

# pathの変更が必要かも..
_Write_Title "cp -r ${env:USERPROFILE}\.gnupg \\wsl$\Distrod\home\${USERNAME}\"
if (Test-Path ${env:USERPROFILE}/.gnupg) {
  if (Test-Path "\\wsl$\Distrod\home\${USERNAME}\.gnupg") {
    Write-Host "Already installed." -ForegroundColor Yellow
  }
  else {
    Copy-Item -r "${env:USERPROFILE}\.gnupg" "\\wsl$\Distrod\tmp\"
    wsl -- rm -rf ~/.gnupg
    wsl -- mv /tmp/.gnupg ~/
    wsl -- chmod 600 ~/.gnupg/*
    Write-Host "Installation is complete." -ForegroundColor Green
  }
}
else {
  Write-Host "${env:USERPROFILE}/.gnupg IS NOT FOUND." -ForegroundColor Red
}

_Write_Title "cp ${WindowsTerminalSettings}/windows\Distrod\wsl.conf \\wsl$\Distrod\etc\"
Copy-Item "${WindowsTerminalSettings}\windows\Distrod\wsl.conf" "\\wsl$\Distrod\tmp\"
wsl -- sudo mv /tmp/wsl.conf  /etc
wsl -- sudo chmod 600 /etc/wsl.conf
Write-Host "Installation is complete." -ForegroundColor Green

_Write_Title "Installation is complete."
wsl --terminate "Distrod"

_Set_ExecutionPolicy
_br(2)

