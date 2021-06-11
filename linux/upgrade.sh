#!/bin/bash
title(){
  echo "-------------------------------------------------------------------------------------------"
  echo "     $1"
  echo "-------------------------------------------------------------------------------------------"
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

title 'sudo apt install git-all'
sudo apt install -y git-all
br

title 'sudo apt instal -y gnupg2'
sudo apt install -y gnupg2
br

title 'sudo apt install -y xclip'
sudo apt install -y xclip
br

title 'sudo apt install -y neofetch'
sudo apt install -y neofetch
br

title 'sudo apt install -y wireless-tools'
sudo apt install -y wireless-tools
br

title 'curl https://get.volta.sh | bash'
curl https://get.volta.sh | bash
volta -v
br

title 'volta install node@latest'
volta install node@latest
br

title 'volta install yarn@latest'
volta install yarn@latest
br

title 'npm install -g npm-upgrade'
npm install -g npm-upgrade
br

title 'npm update *'
npm update *
br

title 'volta list all'
volta list all
br

title 'upgrade.sh is Finished.'
