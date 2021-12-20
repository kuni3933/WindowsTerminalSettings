. "./../Function.ps1"

${USERNAME} = wsl -- whoami
if (${USERNAME} -eq "root"){
    Write_Title "既定ユーザーをroot以外にしてから実行してください. / Set the default user to something other than root, and then run it."
    exit
}
$now = Get-Location
$MyPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location "$MyPath/../../"
$WindowsTerminalSettings = Get-Location
Set-Location ${now}
Write_Title "USERNAME : ${USERNAME}"
wsl --terminate "Distrod"

#--------------------------------------------------------------------------------------------------
# 等性はないので注意
# 実行後に編集が必要なファイルもある
Write_Title "cp $USERPROFILE\.gitconfig \\wsl$\Distrod\home\${USERNAME}\"
if (Test-Path $home/.gitconfig) {
  if (Test-Path "\\wsl$\Distrod\home\${USERNAME}\.gitconfig") {
    Write-Host "Already installed." -ForegroundColor Yellow
  }
  else {
    Copy-Item "$home\.gitconfig" "\\wsl$\Distrod\tmp\"
    wsl -- mv /tmp/.gitconfig ~/
    Write-Host "Installation is complete." -ForegroundColor Green
  }
}
else {
  Write-Host "$home/.gitconfig IS NOT FOUND." -ForegroundColor Red
}

# root/browserなどpathの変更が必要
Write_Title "cp $USERPROFILE\.gowlconfig \\wsl$\Distrod\home\${USERNAME}\"
if (Test-Path $home/.gowlconfig) {
  if (Test-Path "\\wsl$\Distrod\home\${USERNAME}\.gowlconfig") {
    Write-Host "Already installed." -ForegroundColor Yellow
  }
  else {
    Copy-Item "$home\.gowlconfig" "\\wsl$\Distrod\tmp"
    wsl -- mv /tmp/.gowlconfig ~/
    Write-Host "Installation is complete." -ForegroundColor Green
  }
}
else {
  Write-Host "$home/.gowlconfig IS NOT FOUND." -ForegroundColor Red
}

# pathの変更が必要かも..
Write_Title "cp $USERPROFILE\.ssh \\wsl$\Distrod\home\${USERNAME}\"
if (Test-Path $home/.ssh) {
  if (Test-Path "\\wsl$\Distrod\home\${USERNAME}\.ssh") {
    Write-Host "Already installed." -ForegroundColor Yellow
  }
  else {
    Copy-Item -r "$home\.ssh" "\\wsl$\Distrod\tmp\"
    wsl -- rm -rf ~/.ssh
    wsl -- mv /tmp/.ssh ~/
    wsl -- chmod 600 ~/.ssh/*
    Write-Host "Installation is complete." -ForegroundColor Green
  }
}
else {
  Write-Host "$home/.ssh IS NOT FOUND." -ForegroundColor Red
}

# pathの変更が必要かも..
Write_Title "cp -r $USERPROFILE\.gnupg \\wsl$\Distrod\home\${USERNAME}\"
if (Test-Path $home/.gnupg) {
  if (Test-Path "\\wsl$\Distrod\home\${USERNAME}\.gnupg") {
    Write-Host "Already installed." -ForegroundColor Yellow
  }
  else {
    Copy-Item -r "$home\.gnupg" "\\wsl$\Distrod\tmp\"
    wsl -- rm -rf ~/.gnupg
    wsl -- mv /tmp/.gnupg ~/
    wsl -- chmod 600 ~/.gnupg/*
    Write-Host "Installation is complete." -ForegroundColor Green
  }
}
else {
  Write-Host "$home/.gnupg IS NOT FOUND." -ForegroundColor Red
}

Write_Title "cp $WindowsTerminalSettings/windows\Distrod\wsl.conf \\wsl$\Distrod\etc\"
Copy-Item "$WindowsTerminalSettings\windows\Distrod\wsl.conf" "\\wsl$\Distrod\tmp\"
wsl -- sudo mv /tmp/wsl.conf  /etc
wsl -- sudo chmod 600 /etc/wsl.conf
Write-Host "Installation is complete." -ForegroundColor Green

Write_Title "Installation is complete."
wsl --terminate "Distrod"

Set_ExecutionPolicy
br(2)

