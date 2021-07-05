#!/bin/bash
#set -eu
#https://ytyaru.hatenablog.com/entry/2020/02/03/111111
readonly USERPROFILE=${HOME}
readonly CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE:-0}")"; pwd)"
readonly SRC_DIR="${CURRENT_DIR}/.config"
readonly SRC_FILES=$(
	"$(find "${SRC_DIR}" -type f)"
)
readonly DEST_DIR="${HOME}/.config"
readonly dotfile_DIR=${CURRENT_DIR}/../../
readonly pyver="3.9.6"

title(){
  echo ""
  echo "------------------------------------------------------------------"
  echo "# $1"
  echo "------------------------------------------------------------------"
}
section(){
  echo ""
  echo ""
  echo "-------------------------------------------------------------------------------------------"
  echo "     $1"
  echo "-------------------------------------------------------------------------------------------"
}

cd ${CURRENT_DIR}
echo "USERPROFILE : ${USERPROFILE}"
echo "CURRENT_DIR : ${CURRENT_DIR}"
echo "SRC_DIR     : ${SRC_DIR}"
echo "SRC_FILES   : ${SRC_FILES}"
echo "DEST_DIR    : ${DEST_DIR}"
echo ""
echo "py_version  : ${pyver}"
#--------------------------------------------------------------------------------------------------"
section '01. Package Update'
#--------------------------------------------------------------------------------------------------"
title 'sudo apt update -y && sudo apt upgrade -y'
sudo apt update -y && sudo apt upgrade -y

title 'sudo apt full-upgrade -y'
sudo apt full-upgrade -y

title 'sudo apt autoremove -y && sudo apt autoclean -y'
sudo apt autoremove -y
sudo apt autoclean -y

title 'sudo apt-get update -y && sudo apt-get upgrade -y'
sudo apt-get update -y && sudo apt-get upgrade -y

title 'sudo apt-get full-upgrade -y'
sudo apt-get full-upgrade -y

title 'sudo apt-get autoremove -y && sudo apt-get autoclean -y'
sudo apt-get autoremove -y
sudo apt-get autoclean -y


#--------------------------------------------------------------------------------------------------"
section '02. Core Setup'
#--------------------------------------------------------------------------------------------------"
title 'sudo apt install -y ubuntu-wsl'
sudo apt install -y ubuntu-wsl

title 'sudo dpkg-reconfigure tzdata'
sudo dpkg-reconfigure tzdata

title 'sudo apt install -y curl'
sudo apt install -y curl

title 'sudo apt install -y wget'
sudo apt install -y wget

title 'sudo apt install -y make'
sudo apt install -y make

title 'sudo apt install -y ntp'
sudo apt install -y ntp

title 'sudo apt install -y apt-file'
sudo apt install -y apt-file

title 'sudo apt install -y software-properties-common'
sudo apt install -y software-properties-common

title 'sudo apt install -y git-all'
sudo apt install -y git-all

title 'sudo apt install -y gh'
sudo apt install -y gh

title 'curl https://get.volta.sh | bash'
curl https://get.volta.sh | bash
volta setup


#--------------------------------------------------------------------------------------------------"
section '03. PPA Setup'
#--------------------------------------------------------------------------------------------------"
title 'sudo add-apt-repository -y ppa:regolith-linux/unstable'
#https://github.com/regolith-linux/i3-gaps-wm
sudo add-apt-repository -y ppa:regolith-linux/unstable

title 'sudo add-apt-repository -y github/gh'
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

title 'sudo apt update -y && sudo apt upgrade -y'
sudo apt update -y && sudo apt upgrade -y

title 'sudo apt-get update -y && sudo apt-get upgrade -y'
sudo apt-get update -y && sudo apt-get upgrade -y


#--------------------------------------------------------------------------------------------------"
section '04. Font Install'
#--------------------------------------------------------------------------------------------------"
title 'sudo apt install -y $(check-language-support -l ja) language-pack-ja'
sudo apt install -y $(check-language-support -l ja) language-pack-ja

title 'sudo apt install -y manpages-ja'
sudo apt install -y manpages-ja

title 'sudo apt install -y  manpages-ja-dev'
sudo apt install -y  manpages-ja-dev

title 'sudo apt install fonts-noto-color-emoji'
sudo apt install -y fonts-noto-color-emoji

title 'sudo apt install fonts-symbola'
sudo apt install -y fonts-symbola

title 'git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git'
if [ -e /usr/share/fonts/truetype/source-code-pro-ttf ]; then
  echo "Already installed."
else
  git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git /tmp/nerd-fonts
  /tmp/nerd-fonts/install.sh SourceCodePro
  sudo rm -rf /tmp/nerd-fonts/
fi

title 'sudo update-locale LANG=ja_JP.UTF-8'
sudo update-locale LANG=ja_JP.UTF-8


#--------------------------------------------------------------------------------------------------"
section '05. Terminal Setup'
#--------------------------------------------------------------------------------------------------"
title 'git clone https://github.com/Bash-it/bash-it.git'
if [ -e ${USERPROFILE}/.bash_it ]; then
    # 存在する場合
    echo 'Already Installed.'
else
    # 存在しない場合
    git clone https://github.com/Bash-it/bash-it.git ${USERPROFILE}/.bash-it
    ${USERPROFILE}/.bash_it/install.sh
fi

title 'ln -sf ${CURRENT_DIR}/.bash_it/themes/maman'
if [ -e ${USERPROFILE}/.bash_it/themes/maman ]; then
    # 存在する場合
    echo "Already Installed."
else
    # 存在しない場合
    sudo ln -sf ${CURRENT_DIR}/.bash_it/themes/maman/ ${USERPROFILE}/.bash_it/themes/
fi

title 'ln -sf ${CURRENT_DIR}/.bashrc ~/.bashrc.org'
if [ -e ${USERPROFILE}/.bashrc.org ]; then
  #既にある場合
  echo "Already Installed."
else
  sudo ln -sf ${CURRENT_DIR}/.bashrc ${USERPROFILE}/.bashrc.org
  echo '. ~/.bashrc.org' >> ${USERPROFILE}/.bashrc
  section 'Restart the shell'
fi

title 'ln -sf ${CURRENT_DIR}/.inputrc ~/.inputrc'
sudo ln -sf ${CURRENT_DIR}/.inputrc ${USERPROFILE}/

title 'sudo apt install -y fzf'
sudo apt install -y fzf

title 'sudo apt install -y tmux'
sudo apt install -y tmux

title 'git clone --depth 1 https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack'
if [ -e ${USERPROFILE}/.tmux-themepack ]; then
  echo "Already Installed."
else
  git clone --depth 1 https://github.com/jimeh/tmux-themepack.git ${USERPROFILE}/.tmux-themepack
fi

title 'ln -sf ${CURRENT_DIR}/.tmux.conf ~/.tmux.conf'
sudo ln -sf ${CURRENT_DIR}/.tmux.conf ${USERPROFILE}/


#-------------------------------------------------------------------------------------------------------"
section '06. Language / Framework / MiddleWare'
#-------------------------------------------------------------------------------------------------------"
#--------------------------------------------------------------------------------------------------"
section '# C-build-essential Install'
#--------------------------------------------------------------------------------------------------"
title 'Build Tools & Library'
sudo apt install -y build-essential libc6 libc6-dev

title 'sudo apt install -y gdb'
sudo apt install -y gdb

#--------------------------------------------------------------------------------------------------"
section '# Go'
#--------------------------------------------------------------------------------------------------"
title 'sudo ./mnt/linux/ubuntu/update-golang/update-golang.sh'
#sudo ${CURRENT_DIR}/update-golang/update-golang.sh

#--------------------------------------------------------------------------------------------------"
section '# Python Install'
#--------------------------------------------------------------------------------------------------"
# Install ansible
# https://docs.ansible.com/ansible/latest/user_guide/windows_faq.html#can-ansible-run-on-windows
title 'Build Tools & Library'
sudo apt install -y build-essential libbz2-dev libdb-dev libreadline-dev libffi-dev libgdbm-dev liblzma-dev libncursesw5-dev libsqlite3-dev libssl-dev zlib1g-dev uuid-dev tk-dev

title 'sudo apt install -y python3-distutils'
sudo apt install -y python3-distutils

title 'sudo apt install -y python3-venv'
sudo apt install -y python3-venv

title 'git clone --depth 1 https://github.com/pyenv/pyenv.git ~/.pyenv'
if [ -e ${USERPROFILE}/.pyenv ]; then
    # 存在する場合
    pyenv update
else
  git clone --depth 1 https://github.com/pyenv/pyenv.git ${USERPROFILE}/.pyenv
fi

title "pyenv install ${pyver}"
if [ -e ${USERPROFILE}/.pyenv/versions/${pyver} ]; then
  echo "Already Installed."
  title 'pip install -U pip'
  pip install -U pip
else
  pyenv install ${pyver}
  pyenv global ${pyver}
fi
title 'curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -'
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -

#--------------------------------------------------------------------------------------------------"
section '# rust'
#--------------------------------------------------------------------------------------------------"
title 'curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

title 'rustup install nightly-x86_64-unknown-linux-gnu'
rustup install nightly-x86_64-unknown-linux-gnu

title 'rustup default nightly-x86_64-unknown-linux-gnu'
rustup default nightly-x86_64-unknown-linux-gnu

title 'rustup self update'
rustup self update

title 'rustup update'
rustup update

title 'cargo install cargo-update'
cargo install cargo-update

title 'rustup component add'
rustup component add clippy rls rust-analysis rust-src rust-docs rustfmt

title 'cargo install-update --all'
cargo install-update -a

#--------------------------------------------------------------------------------------------------"
section '# volta/npm Install'
#--------------------------------------------------------------------------------------------------"
#title 'curl https://get.volta.sh | bash'
#curl https://get.volta.sh | bash
#volta setup

title 'volta install node@latest'
volta install node@latest

title 'volta install yarn@latest'
volta install yarn@latest

title 'sudo npm -g install typescript'
npm -g install typescript

title 'sudo npm install -g npm-upgrade'
npm install -g npm-upgrade

title 'npm install -g bash-language-server'
npm install -g bash-language-server

title 'npm update *'
npm update *

title 'volta list all'
volta list all


#--------------------------------------------------------------------------------------------------"
section '07. Editor/IDE'
#--------------------------------------------------------------------------------------------------"
title 'sudo apt install -y vim'
sudo apt install -y vim

title 'sudo apt install -y vim-gtk'
sudo apt install -y vim-gtk

title 'git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git'
if [ -e ${USERPROFILE}/.vim ]; then
    # 存在する場合
    if [ -e ${USERPROFILE}/.vim/Vundle.vim ]; then
      echo "Already Installed."↲
    else
      git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git
    fi
else
    # 存在しない場合
    cd ${USERPROFILE}/
    mkdir .vim
    git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git
fi

title 'ln -sf ${CURRENT_DIR}/.vimrc ~/.vimrc'
sudo ln -sf ${CURRENT_DIR}/.vimrc ${USERPROFILE}/

title 'ln -sf /mnt/common/.vim-snippets ~/.vim-snippets'
sudo ln -s ${dotfile_DIR}/mnt/common/.vim-snippets/ ${USERPROFILE}/

title 'pip install neovim'
pip install neovim
pip install -U neovim

#--------------------------------------------------------------------------------------------------"
section '08. i3 & i3-gaps'
#--------------------------------------------------------------------------------------------------"
#https://blog.benjames.io/2017/09/03/installing-i3-gaps-on-ubuntu-16-04/

#title 'sudo apt install -y i3'
#sudo apt install -y i3

title 'sudo apt install -y i3-gaps'
sudo apt install -y i3-gaps

title 'sudo apt install -y libxcb1-dev'
sudo apt install -y libxcb1-dev

title 'sudo apt install -y libxcb-keysyms1-dev'
sudo apt install -y libxcb-keysyms1-dev

title 'sudo apt install -y libpango1.0-dev'
sudo apt install -y libpango1.0-dev

title 'sudo apt install -y libxcb-util0-dev'
sudo apt install -y libxcb-util0-dev

title 'sudo apt install -y libxcb-icccm4-dev '
sudo apt install -y libxcb-icccm4-dev

title 'sudo apt install -y libyajl-dev'
sudo apt install -y libyajl-dev
 
title 'sudo apt install -y libstartup-notification0-dev'
sudo apt install -y libstartup-notification0-dev

title 'sudo apt install -y libxcb-randr0-dev'
sudo apt install -y libxcb-randr0-dev

title 'sudo apt install -y libev-dev'
sudo apt install -y libev-dev

title 'sudo apt install -y libxcb-cursor-dev'
sudo apt install -y libxcb-cursor-dev

title 'sudo apt install -y libxcb-xinerama0-dev'
sudo apt install -y libxcb-xinerama0-dev

title 'sudo apt install -y libxcb-xkb-dev'
sudo apt install -y libxcb-xkb-dev

title 'sudo apt install -y libxkbcommon-dev'
sudo apt install -y libxkbcommon-dev

title 'sudo apt install -y libxkbcommon-x11-dev'
sudo apt install -y libxkbcommon-x11-dev

title 'sudo apt install -y xutils-dev'
sudo apt install -y xutils-dev

title 'sudo apt install -y autoconf'
sudo apt install -y autoconf

title 'sudo apt install -y libxcb-xrm0'
sudo apt install -y libxcb-xrm0

title 'sudo apt install -y libxcb-xrm-dev'
sudo apt install -y libxcb-xrm-dev

title 'sudo apt install -y automake'
sudo apt install -y automake

title 'sudo apt install -y libxcb-shape0-dev'
sudo apt install -y libxcb-shape0-dev


#--------------------------------------------------------------------------------------------------"
section '09.  fcitx Install'
#--------------------------------------------------------------------------------------------------"
title 'sudo apt install -y fcitx-mozc'
sudo apt install -y fcitx-mozc

title 'sudo apt install -y fcitx-tools'
sudo apt install -y fcitx-tools

title  'sudo apt install fcitx-module-dbus'
sudo apt install -y fcitx-module-dbus

title 'sudo apt install -y yaru-theme-icon'
sudo apt install -y yaru-theme-icon

#https://unix.stackexchange.com/questions/490871/lubuntu-g-is-dbus-connection
#title 'sudo apt-get purge fcitx-module-dbus'
#sudo apt-get purge fcitx-module-dbus


#--------------------------------------------------------------------------------------------------"
section '10. CLI tool Install'
#--------------------------------------------------------------------------------------------------"
title 'pip install pywinrm'
pip install pywinrm
pip install -U pywinrm

title 'pip install awscli'
pip install awscli
pip install -U awscli

title 'pip install ansible'
pip install ansible
pip install -U ansible

title 'cargo install --locked bat'
cargo install --locked bat

title 'git clone https://github.com/sstephenson/bats.git /tmp/bats'
git clone https://github.com/sstephenson/bats.git /tmp/bats
sudo /tmp/bats/install.sh /usr/local
sudo rm -rf /tmp/bats

title 'cargo install broot'
cargo install broot
broot --help
if [ -e ${SRC_DIR}/broot ]; then
  sudo ln -sf ${CURRENT_DIR}/.config/broot/conf.toml ${USERPROFILE}/.config/broot/conf.toml
else
  cd ${SRC_DIR}
  mkdir broot
  sudo ln -sf ${CURRENT_DIR}/.config/broot/conf.toml ${USERPROFILE}/.config/broot/conf.toml
  cd ${CURRENT_DIR}
fi

title 'git clone --depth 1 https://github.com/universal-ctags/ctags.git /tmp/ctags'
git clone https://github.com/universal-ctags/ctags.git /tmp/ctags
cd /tmp/ctags
sudo ./autogen.sh && ./configure --prefix=/usr/local && sudo make && sudo make install
cd ${CURRENT_DIR}
sudo rm -rf /tmp/ctags

title 'cargo install git-delta'
cargo install git-delta
git config --global core.pager delta
git config --global core.whitespace cr-at-eol
git config --global delta.syntax-theme Monokai Extended
git config --global delta.line-number true
git config --global delta.side-by-side true
git config --global interactive.diffFilter delta --color-only

title 'git clone https://github.com/skanehira/docui.git /tmp/docui'
git clone https://github.com/skanehira/docui.git /tmp/docui
cd /tmp/docui
GO111MODULE=on go install
cd ${CURRENT_DIR}
sudo rm -rf /tmp/docui

title 'pip isntall docker/compose'
pip install docker-compose
pip install -U docker-compose

title 'cargo install exa'
cargo install exa

title 'cargo install fd-find'
cargo install fd-find

title 'npm install -g fx'
npm install -g fx

title 'pip install glances glances[docker,ip,web]'
pip install glances glances[docker,ip,web]

title 'go get -u github.com/tadashi-aikawa/gowl'
go get -u github.com/tadashi-aikawa/gowl

title 'sudo apt install jq'
sudo apt install -y jq

title 'sudo apt install ncdu'
sudo apt install -y ncdu

title 'sudo apt install nkf'
sudo apt install -y nkf

title 'cargo install ripgrep'
cargo install ripgrep

title 'GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt'
GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt

title 'git clone https://github.com/jonas/tig.git /tmp/tig'
git clone https://github.com/jonas/tig.git /tmp/tig
cd /tmp/tig
sudo make
sudo make install
cd ${CURRENT_DIR}
sudo rm -rf /tmp/tig
sudo ln -sf ${CURRENT_DIR}/.tigrc ${USERPROFILE}/

title 'git clone https://github.com/facebook/zstd.git ~/zstd'
git clone https://github.com/facebook/zstd.git ${USERPROFILE}/zstd
cd ${USERPROFILE}/zstd
sudo make install
cd ${USERPROFILE}/zstd/contrib/pzstd
sudo make install

title 'git clone git@github.com:rupa/z.git ~/z'
git clone git@github.com:rupa/z.git ${USERPROFILE}/z
cd ${USERPROFILE}/z
sudo make
cd ${CURRENT_DIR}
sudo rm -rf ${USERPROFILE}/z

title 'sudo apt install -y gnupg2'
sudo apt install -y gnupg2

title 'sudo apt install -y xclip'
sudo apt install -y xclip

title 'sudo apt install -y neofetch'
sudo apt install -y neofetch

title 'sudo apt install -y shellcheck'
sudo apt install -y shellcheck

title 'sudo apt install -y wireless-tools'
sudo apt install -y wireless-tools

#title 'sudo apt install -y zoxide'
title 'curl -sS https://webinstall.dev/zoxide | bash'
#sudo apt install -y zoxide
curl -sS https://webinstall.dev/zoxide | bash

title 'cargo install onefetch'
cargo install onefetch

#--------------------------------------------------------------------------------------------------"
section '11. Package autoremove'
#--------------------------------------------------------------------------------------------------"
title 'sudo apt autoremove -y && sudo apt autoclean -y'
sudo apt autoremove -y
sudo apt autoclean -y

title 'sudo apt-get autoremove -y && sudo apt-get autoclean -y'
sudo apt-get autoremove -y
sudo apt-get autoclean -y


#--------------------------------------------------------------------------------------------------"
title 'upgrade.sh is Finished.'
#--------------------------------------------------------------------------------------------------"
