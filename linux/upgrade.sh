#!/bin/bash
title(){
  echo "-------------------------------------------------------------------------------------------------"
  echo $1
  echo "-------------------------------------------------------------------------------------------------"
}
br(){
  echo ""
  echo ""
}
title 'sudo apt update && sudo apt upgrade'
sudo apt update && sudo apt upgrade
br

title 'sudo apt-get update && sudo apt-get upgrade'
sudo apt-get update && sudo apt-get upgrade
br

title 'sudo apt-get install git-all'
sudo apt-get install -y git-all
br

title 'sudo apt-get- instal -y gnupg2'
sudo apt-get install -y gnupg2
br

title 'sudo apt-get install -y xclip'
sudo apt-get install -y xclip
br

title 'sudo apt-get install -y neofetch'
sudo apt-get install -y neofetch
br

title 'curl https://get.volta.sh | bash'
curl https://get.volta.sh | bash
volta -v
volta install node@latest
volta install yarn@latest
npm install -g npm-upgrade
npm update *
volta list all
br

#title 'cp $HOME/WindowsTerminalSettings/mnt/linux/ubuntu/.bashrc $HOME/.bashrc'
#cp $HOME/WindowsTerminalSettings/mnt/linux/ubuntu/.bashrc $HOME/.bashrc
#br
