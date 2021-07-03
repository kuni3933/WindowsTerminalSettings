#!/bin/bash
#set -eu
readonly CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE:-0}")"; pwd)/$(basename "${BASH_SOURCE:-0}")"
readonly SRC_DIR="${CURRENT_DIR}/.config"
readonly SRC_FILES=$(
	"$(find "${SRC_DIR}" -type f)"
)
readonly DEST_DIR="${HOME}/.config"

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


#--------------------------------------------------------------------------------------------------"
section '01. PPA Setup'
#--------------------------------------------------------------------------------------------------"
title 'sudo add-apt-repository -y ppa:regolith-linux/unstable'
#https://github.com/regolith-linux/i3-gaps-wm
sudo add-apt-repository -y ppa:regolith-linux/unstable

title 'sudo add-apt-repository -y github/gh'
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

#--------------------------------------------------------------------------------------------------"
section '02. Package Update'
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
section '03. Core Setup'
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

title 'sudo apt install -y git-all'
sudo apt install -y git-all

title 'sudo apt install -y gh'
sudo apt install -y gh

title 'curl https://get.volta.sh | bash'
curl https://get.volta.sh | bash
volta setup


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
if [ -e {/usr/share/fonts/truetype/source-code-pro-ttf} ]; then
  exho "Already installed."
else
  cd ~/
  git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
  ~/nerd-fonts/install.sh SourceCodePro
  rm -rf nerd-fonts/
fi

title 'sudo update-locale LANG=ja_JP.UTF-8'
sudo update-locale LANG=ja_JP.UTF-8


#--------------------------------------------------------------------------------------------------"
section '05. Terminal Setup'
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

title 'ln -sf ${CURRENT_DIR}/.bash_it/themes/maman'
if [ -e {~/.bash_it/themes/maman} ]; then
    # 存在する場合
    echo "Already Installed."
else
    # 存在しない場合
    ln -sf "${CURRENT_DIR}/.bash_it/themes/maman/maman.theme.bash" "~/.bash_it/themes/maman/maman.theme.bash"
fi

title 'ln -sf "${CURRENT_DIR}/.bashrc ~/.bashrc.org'
ln -sf "${CURRENT_DIR}/.bashrc" "~/.bashrc.org"
echo '. ~/.bashrc.org' >> ~/.bashrc

title 'ln -sf ${CURRENT_DIR}/.inputrc ~/.inputrc'
ln -sf "${CURRENT_DIR}/.inputrc" "~/.inputrc"

title 'sudo apt install -y fzf'
sudo apt install -y fzf

title 'sudo apt install -y tmux'
sudo apt install -y tmux

title 'git clone --depth 1 https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack'
if [ -e {~/.tmux-themepack} ]; then↲
  echo "Already Installed."
else
  git clone --depth 1 https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
fi

title 'ln -sf ${CURRENT_DIR}/.tmux.conf ~/.tmux.conf'
ln -sf "${CURRENT_DIR}/.tmux.conf" "~/.tmux.conf"


#-------------------------------------------------------------------------------------------------------"
section '06. Language / Framework / MiddleWare'
#-------------------------------------------------------------------------------------------------------"
#--------------------------------------------------------------------------------------------------"
section '# C-build-essential Install'
#--------------------------------------------------------------------------------------------------"
title 'sudo apt install -y build-essential'
sudo apt install -y build-essential

title 'sudo apt install -y gdb'
sudo apt install -y gdb

title 'sudo apt install -y libc6'
sudo apt install -y libc6

title 'libc6-dev'
sudo apt install -y libc6-dev

#--------------------------------------------------------------------------------------------------"
section '# Go'
#--------------------------------------------------------------------------------------------------"
title 'sudo ~/WindowsTerminalSettings/mnt/linux/ubuntu/update-golang/update-golang.sh'
sudo ${CURRENT_DIR}/update-golang/update-golang.sh

#--------------------------------------------------------------------------------------------------"
section '# Python Install'
#--------------------------------------------------------------------------------------------------"
# Install ansible
# https://docs.ansible.com/ansible/latest/user_guide/windows_faq.html#can-ansible-run-on-windows
title 'sudo apt install -y  libffi-dev'
sudo apt install -y  libffi-dev

title 'sudo apt install -y  libssl-dev'
sudo apt install -y  libssl-dev

title 'sudo apt install -y libbz2-dev'
sudo apt install -y libbz2-dev

title 'sudo apt install -y libdb-dev'
sudo apt install -y libdb-dev

title 'sudo apt install -y python3-venv'
sudo apt install -y python3-venv

title 'git clone --depth 1 https://github.com/pyenv/pyenv.git ~/.pyenv'
if [ -e {~/.pyenv} ]; then
    # 存在する場合
    rm -rf ~/.pyenv
fi
if [ -e {/usr/bin/python3} ]; then
  # 存在する場合
     sudo apt remove -y python3
fi
git clone --depth 1 https://github.com/pyenv/pyenv.git ~/.pyenv
ln -sf "/usr/bin/python3" "/usr/bin/python"

title 'pyenv install 3.9.5'
pyenv install 3.9.5

title 'curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -'
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -

#--------------------------------------------------------------------------------------------------"
section '# rust'
#--------------------------------------------------------------------------------------------------"
title 'curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup install nightly-x86_64-unknown-linux-gnu
rustup default nightly-x86_64-unknown-linux-gnu
rustup self update
rustup update
rustup component add clippy rls rust-analysis rust-src rust-docs rustfmt

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

title 'ln -sf ${CURRENT_DIR}/.vimrc ~/.vimrc'
ln -sf "${CURRENT_DIR}/.vimrc" "~/.vimrc"

title 'ln -sf ${CURRENT_DIR}/.vim-snippets ~/.vim-snippets'
ln -sf "${CURRENT_DIR}/.vim-snippets" "~/.vim-snippets"

title 'pip3 install neovim'
pip3 install neovim


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
sudo apt install fcitx-module-dbus

title 'sudo apt install -y yaru-theme-icon'
sudo apt install -y yaru-theme-icon

#https://unix.stackexchange.com/questions/490871/lubuntu-g-is-dbus-connection
#title 'sudo apt-get purge fcitx-module-dbus'
#sudo apt-get purge fcitx-module-dbus


#--------------------------------------------------------------------------------------------------"
section '10. CLI tool Install'
#--------------------------------------------------------------------------------------------------"
title 'pip3 install ansible'
pip3 install ansible

title 'pip3 install pywinrm'
pip3 install pywinrm

title 'pip3 install awscli'
pip3 install awscli

title 'cargo install --locked bat'
cargo install --locked bat

title 'git clone https://github.com/sstephenson/bats.git /tmp/bats'
git clone https://github.com/sstephenson/bats.git /tmp/bats
sudo /tmp/bats/install.sh /usr/local
sudo rm -rf /tmp/bats

title 'cargo install broot'
cargo install broot
broot --help
ln -sf "${CURRENT_DIR}/.config/broot/conf.toml" "~/.config/broot/conf.toml"

title 'git clone --depth 1 https://github.com/universal-ctags/ctags.git /tmp/ctags'
git clone https://github.com/universal-ctags/ctags.git /tmp/ctags
cd /tmp/ctags
sudo ./autogen.sh && ./configure --prefix=/usr/local && make && make install
cd
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
cd /tmp/docui
GO111MODULE=on go install
cd
sudo rm -rf /tmp/docui

title 'pip3 isntall docker/compose'
pip3 install docker-compose

title 'cargo install exa'
cargo install exa

title 'cargo install fd-find'
cargo install fd-find

title 'npm install -g fx'
npm install -g fx

title 'pip3 install glances glances[docker,ip,web]'
pip3 install glances glances[docker,ip,web]

title 'go get -u github.com/tadashi-aikawa/gowl'
go get -u github.com/tadashi-aikawa/gowl

title 'sudo apt install jq'
sudo apt install jq

title 'sudo apt install ncdu'
sudo apt install ncdu

title 'sudo apt install nkf'
sudo apt install nkf

title 'cargo install ripgrep'
cargo install ripgrep

title 'GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt'
GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt

title 'git clone https://github.com/jonas/tig.git /tmp/tig↲'
git clone https://github.com/jonas/tig.git /tmp/tig
cd /tmp/tig
make
make install
cd
sudo rm -rf /tmp/tig
ln -sf "${CURRENT_DIR}/.tigrc" "~/.tigrc"

title 'git clone https://github.com/facebook/zstd.git ~/zstd'
git clone https://github.com/facebook/zstd.git ~/zstd
cd ~/zstd
make install
cd ~/zstd/contrib/pzstd
make install

title 'git clone git@github.com:rupa/z.git ~/z'
git clone git@github.com:rupa/z.git ~/z
sudo ~/z/z.sh
sudo rm -rf ~/z

title 'sudo apt install -y apt-file'
sudo apt install -y apt-file

title 'sudo apt install -y software-properties-common'
sudo apt install -y software-properties-common

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

title 'cargo install onefetch --force'
cargo install onefetch --force

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
