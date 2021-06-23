#Ubuntu-20.04-LTS
# 冪等性はないので注意
# 実行後に編集が必要なファイルもある
cp $home\.gitconfig \\wsl$\Ubuntu-20.04\tmp\
wsl -- mv /tmp/.gitconfig ~/
# root/browserなどpathの変更が必要
cp $home\.gowlconfig \\wsl$\Ubuntu-20.04\tmp
wsl -- mv /tmp/.gowlconfig ~/

# pathの変更が必要かも..
cp -r $home\.ssh \\wsl$\Ubuntu-20.04\tmp\
wsl -- rm -rf ~/.ssh
wsl -- mv /tmp/.ssh ~/
wsl -- chmod 600 ~/.ssh/*

# pathの変更が必要かも..
cp -r $home\.gnupg \\wsl$\Ubuntu-20.04\tmp\
wsl -- rm -rf ~/.gnupg
wsl -- mv /tmp/.gnupg ~/
wsl -- chmod 600 ~/.gnupg/*

cp $home\WindowsTerminalSettings\windows\ubuntu\wsl.conf \\wsl$\Ubuntu\tmp\
wsl -- sudo mv /tmp/wsl.conf  /etc
wsl -- sudo chmod 600 /etc/wsl.conf

cp $home\WindowsTerminalSettings\windows\ubuntu\.bashrc \\wsl$\Ubuntu\tmp\
wsl -- sudo mv --force /tmp/.bashrc  ~/

# Install類
wsl -- sh ./linux/upgrade.sh
wsl -- rm -rf ~/.volta
