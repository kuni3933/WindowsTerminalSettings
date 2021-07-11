function Write_Title($msg) {
  Write-Host ""
  Write-Host "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
  Write-Host "┃$msg" -ForegroundColor White
  Write-Host "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
}
${Arch} = "Arch"
${USERNAME} = wsl -- whoami
if (${USERNAME} -eq "root"){
    Write_Title "既定ユーザーをroot以外にしてから実行してください. / Set the default user to something other than root, and then run it."
    exit
}
Write_Title "Arch_USERNAME : ${USERNAME}"
wsl --terminate "${Arch}"

# Arch
# 等性はないので注意
# 実行後に編集が必要なファイルもある
Write_Title "cp $USERPROFILE\.gitconfig \\wsl$\${Arch}\home\${USERNAME}\"
if (Test-Path $home/.gitconfig) {
  if (Test-Path "\\wsl$\${Arch}\home\${USERNAME}\.gitconfig") {
    Write-Host "Already installed." -ForegroundColor Yellow
  }
  else {
    cp "$home\.gitconfig" "\\wsl$\${Arch}\tmp\"
    wsl -- mv /tmp/.gitconfig ~/
    Write-Host "Installation is complete." -ForegroundColor Green
  }
}
else {
  Write-Host "$home/.gitconfig IS NOT FOUND." -ForegroundColor Red
}

# root/browserなどpathの変更が必要
Write_Title "cp $USERPROFILE\.gowlconfig \\wsl$\${Arch}\home\${USERNAME}\"
if (Test-Path $home/.gowlconfig) {
  if (Test-Path "\\wsl$\${Arch}\home\${USERNAME}\.gowlconfig") {
    Write-Host "Already installed." -ForegroundColor Yellow
  }
  else {
    cp "$home\.gowlconfig" "\\wsl$\${Arch}\tmp"
    wsl -- mv /tmp/.gowlconfig ~/
    Write-Host "Installation is complete." -ForegroundColor Green
  }
}
else {
  Write-Host "$home/.gowlconfig IS NOT FOUND." -ForegroundColor Red
}

# pathの変更が必要かも..
Write_Title "cp $USERPROFILE\.ssh \\wsl$\${Arch}\home\${USERNAME}\"
if (Test-Path $home/.ssh) {
  if (Test-Path "\\wsl$\${Arch}\home\${USERNAME}\.ssh") {
    Write-Host "Already installed." -ForegroundColor Yellow
  }
  else {
    cp -r "$home\.ssh" "\\wsl$\${Arch}\tmp\"
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
Write_Title "cp -r $USERPROFILE\.gnupg \\wsl$\${Arch}\home\${USERNAME}\"
if (Test-Path $home/.gnupg) {
  if (Test-Path "\\wsl$\${Arch}\home\${USERNAME}\.gnupg") {
    Write-Host "Already installed." -ForegroundColor Yellow
  }
  else {
    cp -r "$home\.gnupg" "\\wsl$\${Arch}\tmp\"
    wsl -- rm -rf ~/.gnupg
    wsl -- mv /tmp/.gnupg ~/
    wsl -- chmod 600 ~/.gnupg/*
    Write-Host "Installation is complete." -ForegroundColor Green
  }
}
else {
  Write-Host "$home/.gnupg IS NOT FOUND." -ForegroundColor Red
}

Write_Title "cp $USERPROFILE\WindowsTerminalSettings\windows\Arch\wsl.conf \\wsl$\${Arch}\etc\"
cp "$home\WindowsTerminalSettings\windows\Arch\wsl.conf" "\\wsl$\${Arch}\tmp\"
wsl -- sudo mv /tmp/wsl.conf  /etc
wsl -- sudo chmod 600 /etc/wsl.conf
Write-Host "Installation is complete." -ForegroundColor Green

Write_Title 'sudo pacman -S git gnupg openssh'
wsl -- sudo pacman -g
wsl -- sudo pacman -Syy
wsl -- sudo pacman -Syyu
wsl -- sudo pacman -Sc
#------------------------------------------------------------------------#
wsl -- sudo pacman -S git gnupg openssh
Write-Host "Installation is complete." -ForegroundColor Green

Write_Title "Installation is complete."
wsl --terminate "${Arch}"
