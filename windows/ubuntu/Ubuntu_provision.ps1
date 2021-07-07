function Write_Title($msg) {
  Write-Host ""
  Write-Host "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
  Write-Host "┃$msg" -ForegroundColor White
  Write-Host "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
}
${Ubuntu} = "Ubuntu"
#${Ubuntu} = "Ubuntu-20.04"
${USERNAME} = wsl -- whoami
Write_Title "Ubuntu_USERNAME : ${USERNAME}"
wsl --terminate "${Ubuntu}"

# Ubuntu
# 等性はないので注意
# 実行後に編集が必要なファイルもある
Write_Title "cp $USERPROFILE\.gitconfig \\wsl$\${Ubuntu}\home\${USERNAME}\"
if (Test-Path $home/.gitconfig) {
  if (Test-Path "\\wsl$\${Ubuntu}\home\${USERNAME}\.gitconfig") {
    Write-Host "Already installed." -ForegroundColor Yellow
  }
  else {
    cp "$home\.gitconfig" "\\wsl$\${Ubuntu}\tmp\"
    wsl -- mv /tmp/.gitconfig ~/
    Write-Host "Installation is complete." -ForegroundColor Green
  }
}
else {
  Write-Host "$home/.gitconfig IS NOT FOUND." -ForegroundColor Red
}

# root/browserなどpathの変更が必要
Write_Title "cp $USERPROFILE\.gowlconfig \\wsl$\${Ubuntu}\home\${USERNAME}\"
if (Test-Path $home/.gowlconfig) {
  if (Test-Path "\\wsl$\${Ubuntu}\home\${USERNAME}\.gowlconfig") {
    Write-Host "Already installed." -ForegroundColor Yellow
  }
  else {
    cp "$home\.gowlconfig" "\\wsl$\${Ubuntu}\tmp"
    wsl -- mv /tmp/.gowlconfig ~/
    Write-Host "Installation is complete." -ForegroundColor Green
  }
}
else {
  Write-Host "$home/.gowlconfig IS NOT FOUND." -ForegroundColor Red
}

# pathの変更が必要かも..
Write_Title "cp $USERPROFILE\.ssh \\wsl$\${Ubuntu}\home\${USERNAME}\"
if (Test-Path $home/.ssh) {
  if (Test-Path "\\wsl$\${Ubuntu}\home\${USERNAME}\.ssh") {
    Write-Host "Already installed." -ForegroundColor Yellow
  }
  else {
    cp -r "$home\.ssh" "\\wsl$\${Ubuntu}\tmp\"
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
Write_Title "cp -r $USERPROFILE\.gnupg \\wsl$\${Ubuntu}\home\${USERNAME}\"
if (Test-Path $home/.gnupg) {
  if (Test-Path "\\wsl$\${Ubuntu}\home\${USERNAME}\.gnupg") {
    Write-Host "Already installed." -ForegroundColor Yellow
  }
  else {
    cp -r "$home\.gnupg" "\\wsl$\${Ubuntu}\tmp\"
    wsl -- rm -rf ~/.gnupg
    wsl -- mv /tmp/.gnupg ~/
    wsl -- chmod 600 ~/.gnupg/*
    Write-Host "Installation is complete." -ForegroundColor Green
  }
}
else {
  Write-Host "$home/.gnupg IS NOT FOUND." -ForegroundColor Red
}

Write_Title "cp $USERPROFILE\WindowsTerminalSettings\windows\ubuntu\wsl.conf \\wsl$\${Ubuntu}\etc\"
cp "$home\WindowsTerminalSettings\windows\ubuntu\wsl.conf" "\\wsl$\${Ubuntu}\tmp\"
wsl -- sudo mv /tmp/wsl.conf  /etc
wsl -- sudo chmod 600 /etc/wsl.conf
Write-Host "Installation is complete." -ForegroundColor Green

Write_Title 'sudo apt install -y git-all'
wsl -- sudo apt update -y
wsl -- sudo apt upgrade -y
wsl -- sudo apt full-upgrade -y
wsl -- sudo apt autoremove -y
wsl -- sudo apt autoclean -y
#------------------------------------------------------------------------#
wsl -- sudo apt-get update -y
wsl -- sudo apt-get upgrade -y
wsl -- sudo apt-get full-upgrade -y
wsl -- sudo apt-get autoremove -y
wsl -- sudo apt-get autoclean -y
#------------------------------------------------------------------------#
wsl -- sudo apt install -y git-all
Write-Host "Installation is complete." -ForegroundColor Green

Write_Title "Installation is complete."
