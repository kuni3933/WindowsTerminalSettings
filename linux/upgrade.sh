#!/bin/bash
set -eu
title(){
  echo "-------------------------------------------------------------------------------------------"
  echo "     $1"
  echo "-------------------------------------------------------------------------------------------"
}
br(){
  echo ""
  echo ""
}

title 'sudo apt update -y && sudo apt upgrade -y'
sudo apt update -y && sudo apt upgrade -y
br

title 'sudo apt full-upgrade -y'
sudo apt full-upgrade -y
br

title 'sudo apt autoremove -y && sudo apt autoclean -y'
sudo apt autoremove -y
sudo apt autoclean -y
br

title 'sudo apt-get update -y && sudo apt-get upgrade -y'
sudo apt-get update -y && sudo apt-get upgrade -y
br

title 'sudo apt-get full-upgrade -y'
sudo apt-get full-upgrade -y
br

title 'sudo apt-get autoremove -y && sudo apt-get autoclean -y'
sudo apt-get autoremove -y
sudo apt-get autoclean -y
br

title 'sudo apt install -y $(check-language-support -l ja) language-pack-ja'
sudo apt install -y $(check-language-support -l ja) language-pack-ja
br

title 'sudo apt install fonts-noto-color-emoji'
sudo apt install -y fonts-noto-color-emoji
br

title 'sudo apt install fonts-symbola'
sudo apt install -y fonts-symbola
br

title 'sudo update-locale LANG=ja_JP.UTF-8'
sudo update-locale LANG=ja_JP.UTF-8
br

# Install ansible
# https://docs.ansible.com/ansible/latest/user_guide/windows_faq.html#can-ansible-run-on-windows
title 'sudo apt install -y  python3-pip'
sudo apt install -y  python3-pip
br

title 'sudo apt install -y  libffi-dev'
sudo apt install -y  libffi-dev
br

title 'sudo apt install -y  libssl-dev'
sudo apt install -y  libssl-dev
br

title 'pip3 install ansible pywinrm'
pip3 install ansible pywinrm
br

title 'sudo apt install -y git-all'
sudo apt show git-all
sudo apt install -y git-all
br

title 'sudo apt install -y vim'
sudo apt show vim
sudo apt install -y vim
br

title 'sudo apt install -y gnupg2'
sudo apt show gnupg2
sudo apt install -y gnupg2
br

title 'sudo apt install -y xclip'
sudo apt show xclip
sudo apt install -y xclip
br

title 'sudo apt install -y neofetch'
sudo apt show neofetch
sudo apt install -y neofetch
br

title 'sudo apt install -y wireless-tools'
sudo apt show wireless-tools
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

title 'sudo apt autoremove -y && sudo apt autoclean -y'
sudo apt autoremove -y
sudo apt autoclean -y
br

title 'sudo apt-get autoremove -y && sudo apt-get autoclean -y'
sudo apt-get autoremove -y
sudo apt-get autoclean -y
br

title 'upgrade.sh is Finished.'
