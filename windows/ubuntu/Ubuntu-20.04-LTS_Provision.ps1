function Write_Title($msg) {
  Write-Host ""
  Write-Host "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
  Write-Host "┃$msg" -ForegroundColor Yellow
  Write-Host "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
}

# Ubuntu
# 等性はないので注意
# 実行後に編集が必要なファイルもある
Write_Title 'cp $USERPROFILE\.gitconfig \\wsl$\Ubuntu-20.04\$home\'
if (Test-Path $home/.gitconfig) {
  cp $home\.gitconfig \\wsl$\Ubuntu-20.04\tmp\
  wsl -- mv /tmp/.gitconfig ~/
}

# root/browserなどpathの変更が必要
Write_Title 'cp $USERPROFILE\.gowlconfig \\wsl$\Ubuntu-20.04\$home\'
if (Test-Path $home/.gowlconfig) {
  cp $home\.gowlconfig \\wsl$\Ubuntu-20.04\tmp
  wsl -- mv /tmp/.gowlconfig ~/
}

# pathの変更が必要かも..
Write_Title 'cp $USERPROFILE\.ssh \\wsl$\Ubuntu-20.04\$home\'
if (Test-Path $home/.ssh) {
  cp -r $home\.ssh \\wsl$\Ubuntu-20.04\tmp\
  wsl -- rm -rf ~/.ssh
  wsl -- mv /tmp/.ssh ~/
  wsl -- chmod 600 ~/.ssh/*
}

# pathの変更が必要かも..
Write_Title 'cp -r $USERPROFILE\.gnupg \\wsl$\Ubuntu-20.04\$home\'
if (Test-Path $home/.gnupg) {
  cp -r $home\.gnupg \\wsl$\Ubuntu-20.04\tmp\
  wsl -- rm -rf ~/.gnupg
  wsl -- mv /tmp/.gnupg ~/
  wsl -- chmod 600 ~/.gnupg/*
}

Write_Title 'cp $USERPROFILE\WindowsTerminalSettings\windows\ubuntu\wsl.conf \\wsl$\Ubuntu-20.04\etc\'
cp $home\WindowsTerminalSettings\windows\ubuntu\wsl.conf \\wsl$\Ubuntu-20.04\tmp\
wsl -- sudo mv /tmp/wsl.conf  /etc
wsl -- sudo chmod 600 /etc/wsl.conf

Write_Title 'sudo apt install -y git-all'
wsl -- sudo apt update -y
wsl -- sudo apt upgrade -y
wsl -- sudo apt install -y git-all
