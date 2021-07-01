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
readonly CURRENT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
readonly SRC_DIR="${CURRENT_DIR}/.config"
readonly SRC_FILES=("$(find "${SRC_DIR}" -type f)")
readonly DEST_DIR="${HOME}/.config"


#--------------------------------------------------------------------------------------------------"
section "1. PPA Setup"
#--------------------------------------------------------------------------------------------------"
title "sudo add-apt-repository -y ppa:regolith-linux/unstable"
#https://github.com/regolith-linux/i3-gaps-wm
sudo add-apt-repository -y ppa:regolith-linux/unstable
br

title ''
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh



#--------------------------------------------------------------------------------------------------"
section "2. Package Update"
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
section "3. Core Setup"
#--------------------------------------------------------------------------------------------------"
title "sudo dpkg-reconfigure tzdata"
sudo dpkg-reconfigure tzdata
br

title "sudo apt install -y curl"
sudo apt install -y curl
br

title "sudo apt install -y wget"
sudo apt install -y wget
br

title "sudo apt install -y make"
sudo apt install -y make
br

title "sudo apt install -y ntp"
sudo apt install -y ntp
br

title 'sudo apt install -y git-all'
sudo apt install -y git-all
br

title 'curl https://get.volta.sh | bash'
curl https://get.volta.sh | bash
volta setup
br


#--------------------------------------------------------------------------------------------------"
section "4. Font Install"
#--------------------------------------------------------------------------------------------------"
title 'sudo apt install -y $(check-language-support -l ja) language-pack-ja'
sudo apt install -y $(check-language-support -l ja) language-pack-ja
br

title "manpages-ja"
sudo apt install -y manpages-ja
br

title "manpages-ja-dev"
sudo apt install -y  manpages-ja-dev
br

title 'sudo apt install fonts-noto-color-emoji'
sudo apt install -y fonts-noto-color-emoji
br

title 'sudo apt install fonts-symbola'
sudo apt install -y fonts-symbola
br

title 'git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git'
cd ~/
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
~/nerd-fonts/install.sh
rm -rf nerd-fonts/
br

title 'sudo update-locale LANG=ja_JP.UTF-8'
sudo update-locale LANG=ja_JP.UTF-8
br


#--------------------------------------------------------------------------------------------------"
section "5. Terminal Setup"
#--------------------------------------------------------------------------------------------------"
title 'git clone https://github.com/Bash-it/bash-it.git'
if [ -e {~/.bash_it} ]; then
    # 存在する場合
    echo 'Already Installed.'
else
    # 存在しない場合
    git clone https://github.com/Bash-it/bash-it.git ~/bash-it
    ~/.bash_it/install.sh
fi

title 'ln -sf "${CURRENT_DIR}/.bash_it/themes/maman'
if [ -e {~/.bash_it/themes/maman} ]; then
    # 存在する場合
    echo "Already Installed."
else
    # 存在しない場合
    ln -sf "${CURRENT_DIR}/.bash_it/themes/maman/maman.theme.bash" ~/.bash_it/themes/maman/maman.theme.bash
fi

title 'ln -sf "${CURRENT_DIR}/.bashrc ~/.bashrc.org'
ln -sf "${CURRENT_DIR}/.bashrc" ~/.bashrc.org
echo '. ~/.bashrc.org' >> ~/.bashrc
br

title "ln -sf "${CURRENT_DIR}/.inputrc" ~/.inputrc"
ln -sf "${CURRENT_DIR}/.inputrc" ~/.inputrc
br

title "sudo apt install -y fzf"
sudo apt install -y fzf
br

title "sudo apt install -y tmux"
sudo apt install -y tmux
br

title "git clone --depth 1 https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack"
git clone --depth 1 https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
br

title ""
ln -sf "${CURRENT_DIR}/.tmux.conf" ~/.tmux.conf
br


#-------------------------------------------------------------------------------------------------------"
section "5. Language / Framework / MiddleWare"
#-------------------------------------------------------------------------------------------------------"
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
section "Go"
#--------------------------------------------------------------------------------------------------"
title 'sudo ~/WindowsTerminalSettings/mnt/linux/ubuntu/update-golang/update-golang.sh'
sudo ${CURRENT_DIR}/update-golang/update-golang.sh
br

#--------------------------------------------------------------------------------------------------"
section "Python Install"
#--------------------------------------------------------------------------------------------------"
# Install ansible
# https://docs.ansible.com/ansible/latest/user_guide/windows_faq.html#can-ansible-run-on-windows
title 'sudo apt install -y  libffi-dev'
sudo apt install -y  libffi-dev
br

title 'sudo apt install -y  libssl-dev'
sudo apt install -y  libssl-dev
br

title "sudo apt install -y libbz2-dev"
sudo apt install -y libbz2-dev
br

title "sudo apt install -y libdb-dev"
sudo apt install -y libdb-dev
br

title "sudo apt install -y python3-venv"
sudo apt install -y python3-venv
br

tit;e "git clone --depth 1 https://github.com/pyenv/pyenv.git ~/.pyenv"
if [ -e {~/.pyenv} ]; then
    # 存在する場合
    rm -rf ~/.pyenv
fi
if [ -e {/usr/bin/python3} ]; then
  # 存在する場合
     sudo apt remove -y python3
fi
git clone --depth 1 https://github.com/pyenv/pyenv.git ~/.pyenv
ln -sf '/usr/bin/python3' '/usr/bin/python'
br

title "pyenv install 3.9.5"
pyenv install 3.9.5
br

title "curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -
"
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -
br

title 'pip3 install ansible'
pip3 install ansible
br

title 'pip3 install pywinrm'
pip3 install pywinrm
br

title "pip3 install -- user pipenv"
br

#--------------------------------------------------------------------------------------------------"
section "rust"
#--------------------------------------------------------------------------------------------------"
title "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
br

#--------------------------------------------------------------------------------------------------"
section "volta/npm Install"
#--------------------------------------------------------------------------------------------------"
#title 'curl https://get.volta.sh | bash'
#curl https://get.volta.sh | bash
#volta setup
#br

title 'volta install node@latest'
volta install node@latest
br

title 'volta install yarn@latest'
volta install yarn@latest
br

title 'sudo npm -g install typescript'
npm -g install typescript
br

title 'sudo npm install -g npm-upgrade'
npm install -g npm-upgrade
br

title "npm install -g bash-language-server"
npm install -g bash-language-server
br

title 'npm update *'
npm update *
br

title 'volta list all'
volta list all
br


#--------------------------------------------------------------------------------------------------"
section "Editor/IDE"
#--------------------------------------------------------------------------------------------------"
title 'sudo apt install -y vim'
sudo apt install -y vim
br

title 'git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git'
if [ -e {~/.vim} ]; then
    # 存在する場合
    cd ~/.vim
    git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git
else
    # 存在しない場合
    cd ~/
    mkdir .vim
    git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git
fi
br

title 'pip3 install neovim'
pip3 install neovim
br
#

#--------------------------------------------------------------------------------------------------"
section "i3 & i3-gaps"
#--------------------------------------------------------------------------------------------------"
#https://blog.benjames.io/2017/09/03/installing-i3-gaps-on-ubuntu-16-04/

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

title 'sudo apt install -y xutils-dev'
sudo apt install -y xutils-dev 
br

title 'sudo apt install -y autoconf'
sudo apt install -y autoconf 
br

title 'sudo apt install -y libxcb-xrm0'
sudo apt install -y libxcb-xrm0
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
section "CLI tool Install"
#--------------------------------------------------------------------------------------------------"
title "sudo apt install -y apt-file"
sudo apt install -y apt-file
br

title "sudo apt install -y software-properties-common"
sudo apt install -y software-properties-common
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

title "sudo apt install -y shellcheck"
sudo apt install -y shellcheck
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
