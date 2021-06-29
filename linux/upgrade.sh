#!/bin/bash
set -eu
title(){
  echo "------------------------------------------------------------------"
  echo "# $1"
  echo "------------------------------------------------------------------"
}
section(){
  echo "-------------------------------------------------------------------------------------------"
  echo "     $1"
  echo "-------------------------------------------------------------------------------------------"
}
br(){
  echo ""
  echo ""
}


#--------------------------------------------------------------------------------------------------"
section "PPA Setup"
#--------------------------------------------------------------------------------------------------"
title "sudo add-apt-repository -y ppa:regolith-linux/unstable"
#https://github.com/regolith-linux/i3-gaps-wm
sudo add-apt-repository -y ppa:regolith-linux/unstable
br


#--------------------------------------------------------------------------------------------------"
section "Package Update"
#--------------------------------------------------------------------------------------------------"
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


#--------------------------------------------------------------------------------------------------"
section "Font Install"
#--------------------------------------------------------------------------------------------------"
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



#--------------------------------------------------------------------------------------------------"
section "i3 & i3-gaps"
#--------------------------------------------------------------------------------------------------"
#title "sudo apt install -y i3"
#sudo apt install -y i3
#br

title "sudo apt install -y i3-gaps"
sudo apt install -y i3-gaps
br

title 'sudo apt install -y libxcb1-dev'
sudo apt install -y libxcb1-dev
br

title 'sudo apt install -y libxcb-keysyms1-dev'
sudo apt install -y libxcb-keysyms1-dev
br

title 'sudo apt install -y libpango1.0-dev'
sudo apt install -y libpango1.0-dev
br

title 'sudo apt install -y libxcb-util0-dev'
sudo apt install -y libxcb-util0-dev
br

title 'sudo apt install -y libxcb-icccm4-dev '
sudo apt install -y libxcb-icccm4-dev 
br

title 'sudo apt install -y libyajl-dev'
sudo apt install -y libyajl-dev
br
 
title 'sudo apt install -y libstartup-notification0-dev'
sudo apt install -y libstartup-notification0-dev
br

title 'sudo apt install -y libxcb-randr0-dev'
sudo apt install -y libxcb-randr0-dev
br

title 'sudo apt install -y libev-dev'
sudo apt install -y libev-dev
br

title 'sudo apt install -y libxcb-cursor-dev'
sudo apt install -y libxcb-cursor-dev
br

title 'sudo apt install -y libxcb-xinerama0-dev'
sudo apt install -y libxcb-xinerama0-dev
br

title 'sudo apt install -y libxcb-xkb-dev'
sudo apt install -y libxcb-xkb-dev
br

title 'sudo apt install -y libxkbcommon-dev'
sudo apt install -y libxkbcommon-dev
br

title 'sudo apt install -y libxkbcommon-x11-dev'
sudo apt install -y libxkbcommon-x11-dev
br

title 'sudo apt install -y autoconf libxcb-xrm0'
sudo apt install -y autoconf libxcb-xrm0
br

title 'sudo apt install -y libxcb-xrm-dev'
sudo apt install -y libxcb-xrm-dev
br

title 'sudo apt install -y automake'
sudo apt install -y automake
br

title 'sudo apt install -y libxcb-shape0-dev'
sudo apt install -y libxcb-shape0-dev
br

title 'sudo apt install -y libxcb-xrm-dev'
sudo apt install -y libxcb-xrm-dev
br


#--------------------------------------------------------------------------------------------------"
section "fcitx Install"
#--------------------------------------------------------------------------------------------------"
title 'sudo apt install -y fcitx-mozc'
sudo apt install -y fcitx-mozc
br

title 'sudo apt install -y fcitx-tools'
sudo apt install -y fcitx-tools
br

title  'sudo apt install fcitx-module-dbus'
sudo apt install fcitx-module-dbus
br

title 'sudo apt install -y yaru-theme-icon'
sudo apt install -y yaru-theme-icon
br

#https://unix.stackexchange.com/questions/490871/lubuntu-g-is-dbus-connection
#title 'sudo apt-get purge fcitx-module-dbus'
#sudo apt-get purge fcitx-module-dbus
#br


#--------------------------------------------------------------------------------------------------"
section "Language / Framework / MiddleWare"
#--------------------------------------------------------------------------------------------------"
#--------------------------------------------------------------------------------------------------"
section "C-build-essential Install"
#--------------------------------------------------------------------------------------------------"
title "sudo apt install -y build-essential"
sudo apt install -y build-essential
br

title "sudo apt install -y gdb"
sudo apt install -y gdb
br

title "sudo apt install -y libc6"
sudo apt install -y libc6
br

title "libc6-dev"
sudo apt install -y libc6-dev
br

#--------------------------------------------------------------------------------------------------"
section "Python Install"
#--------------------------------------------------------------------------------------------------"
# Install ansible
# https://docs.ansible.com/ansible/latest/user_guide/windows_faq.html#can-ansible-run-on-windows
title 'sudo apt install -y  python3-pip'
sudo apt install -y  python3-pip
/usr/bin/python3 -m pip install --upgrade pip
br

title 'sudo apt install -y  libffi-dev'
sudo apt install -y  libffi-dev
br

title 'sudo apt install -y  libssl-dev'
sudo apt install -y  libssl-dev
br

title 'pip3 install ansible'
pip3 install ansible
br

title 'pip3 install pywinrm'
pip3 install pywinrm
br


#--------------------------------------------------------------------------------------------------"
section "volta/npm Install"
#--------------------------------------------------------------------------------------------------"
title 'curl https://get.volta.sh | bash'
curl https://get.volta.sh | bash
volta setup
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

#--------------------------------------------------------------------------------------------------"
section "rust"
#--------------------------------------------------------------------------------------------------"
title "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
br


#--------------------------------------------------------------------------------------------------"
section "CLI tool Install"
#--------------------------------------------------------------------------------------------------"
title "sudo apt install -y apt-file"
sudo apt install -y apt-file
br

title "sudo apt install -y software-properties-common"
sudo apt install -y software-properties-common
br

title 'sudo apt install -y git-all'
sudo apt install -y git-all
br

title 'sudo apt install -y vim'
sudo apt install -y vim
br

title 'sudo apt install -y gnupg2'
sudo apt install -y gnupg2
br

title 'sudo apt install -y xclip'
sudo apt install -y xclip
br

title 'sudo apt install -y neofetch'
sudo apt install -y neofetch
br

title "cargo install onefetch --force"
cargo install onefetch --force
br

#title "sudo apt install -y zoxide"
title "curl -sS https://webinstall.dev/zoxide | bash"
#sudo apt install -y zoxide
curl -sS https://webinstall.dev/zoxide | bash
br

title 'sudo apt install -y wireless-tools'
sudo apt install -y wireless-tools
br


#--------------------------------------------------------------------------------------------------"
section "Package autoremove"
#--------------------------------------------------------------------------------------------------"
title 'sudo apt autoremove -y && sudo apt autoclean -y'
sudo apt autoremove -y
sudo apt autoclean -y
br

title 'sudo apt-get autoremove -y && sudo apt-get autoclean -y'
sudo apt-get autoremove -y
sudo apt-get autoclean -y
br


#--------------------------------------------------------------------------------------------------"
title 'upgrade.sh is Finished.'
#--------------------------------------------------------------------------------------------------"
