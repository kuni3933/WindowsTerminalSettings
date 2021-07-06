#!/bin/bash
#set -eu
title() {
  echo ""
  echo "------------------------------------------------------------------"
  echo "# $1"
  echo "------------------------------------------------------------------"
}
section() {
  echo ""
  echo ""
  echo ""
  echo "-------------------------------------------------------------------------------------------"
  echo "     $1"
  echo "-------------------------------------------------------------------------------------------"
}
saptin() {
  if [ $# -ne 1 ]; then
    echo "Error : Argument Error/引数エラー"
    echo "       \"sudo apt install\" に必要な1個の引数が必要です。" 1>&2
    echo "       One argument required for \"sudo apt install\"." 1>&2
    exit 1
  else
    sudo apt install -y ${1}
  fi
}
aptshow() {
  if [ $# -ne 1 ]; then
    echo "Error : Argument Error/引数エラー"
    echo "       \"sudo apt install\" に必要な1個の引数が必要です。" 1>&2
    echo "       One argument required for \"sudo apt install\"." 1>&2
    exit 1
  else
    apt show ${1}
  fi
}
# -------------------------------------------------------------------------------------------------
#https://ytyaru.hatenablog.com/entry/2020/02/03/111111
readonly USERPROFILE=${HOME}
readonly CURRENT_DIR="$(
  cd "$(dirname "${BASH_SOURCE:-0}")"
  pwd
)"
readonly SRC_DIR="${CURRENT_DIR}/.config"
readonly SRC_FILES=$(
  "$(find "${SRC_DIR}" -type f)"
)
readonly DEST_DIR="${USERPROFILE}/.config"
readonly dotfile_DIR=$(cd ${CURRENT_DIR} && cd ../../../ && pwd)
readonly Go_VER="1.16.5"
readonly Py_VER="3.9.6"
# -------------------------------------------------------------------------------------------------
if [ -e ${USERPROFILE}/.config ]; then
  :
else
  cd ${USERPROFILE}
  mkdir .config
  cd ${CURRENT_DIR}
fi
cd ${CURRENT_DIR}
echo "USERPROFILE : ${USERPROFILE}"
echo "dotfile_DIR : ${dotfile_DIR}"
echo "CURRENT_DIR : ${CURRENT_DIR}"
echo "SRC_DIR     : ${SRC_DIR}"
echo "SRC_FILES   : ${SRC_FILES}"
echo "DEST_DIR    : ${DEST_DIR}"
echo "Go_VERSION  : ${Go_VER}"
echo "Py_VERSION  : ${Py_VER}"

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
title 'sudo dpkg-reconfigure tzdata'
sudo dpkg-reconfigure tzdata

title 'sudo apt install -y aria2'
saptin "aria2"

title 'sudo apt install -y ubuntu-wsl'
saptin "ubuntu-wsl"

title 'sudo apt install -y curl'
saptin "curl"

title 'sudo apt install -y wget'
saptin "wget"

title 'sudo apt install -y make'
saptin "make"

title 'sudo apt install -y autoconf'
saptin "autoconf"

title 'sudo apt install -y automake'
saptin "automake"

title 'sudo apt install -y ntp'
saptin "ntp"

title 'sudo apt install -y apt-file'
saptin "apt-file"

title 'sudo apt install -y software-properties-common'
saptin "software-properties-common"

title 'sudo apt install -y git-all'
saptin "git-all"

title 'sudo apt install -y gh'
saptin "gh"

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
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null

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
saptin "manpages-ja"

title 'sudo apt install -y  manpages-ja-dev'
saptin "manpages-ja-dev"

title 'sudo apt install fonts-noto-color-emoji'
saptin "fonts-noto-color-emoji"

title 'sudo apt install fonts-symbola'
saptin "fonts-symbola"

title 'git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git'
if [ -e ${USERPROFILE}/.local/share/fonts/NerdFonts/"Sauce Code Pro Nerd Font Complete.ttf" ]; then
  echo "Already installed."
else
  sudo git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git /tmp/nerd-fonts
  /tmp/nerd-fonts/install.sh SourceCodePro
  sudo rm -rf /tmp/nerd-fonts/
fi

title 'sudo update-locale LANG=ja_JP.UTF-8'
sudo update-locale LANG=ja_JP.UTF-8

#--------------------------------------------------------------------------------------------------"
section '05. Terminal Setup'
#--------------------------------------------------------------------------------------------------"
title 'git clone https://github.com/Bash-it/bash-it.git ~/.bash_it'
if [ -e ${USERPROFILE}/.bash_it ]; then
  # 存在する場合
  echo 'Already Installed.'
else
  # 存在しない場合
  git clone https://github.com/Bash-it/bash-it.git ${USERPROFILE}/.bash_it
  ${USERPROFILE}/.bash_it/install.sh
fi

title "ln -sf ${CURRENT_DIR}/.bash_it/themes/maman ${USERPROFILE}/.bash_it/themes/"
sudo ln -sf ${CURRENT_DIR}/.bash_it/themes/maman/ ${USERPROFILE}/.bash_it/themes/

title "ln -sf ${CURRENT_DIR}/.bashrc ${USERPROFILE}/.bashrc.org"
if [ -e ${USERPROFILE}/.bashrc.org ]; then
  #既にある場合
  echo "Already Installed."
else
  sudo ln -sf ${CURRENT_DIR}/.bashrc ${USERPROFILE}/.bashrc.org
  echo '. ~/.bashrc.org' >>${USERPROFILE}/.bashrc
  section 'Restart the shell'
  exit
fi

title 'sudo apt install cmatrix'
saptin "cmatrix"

title "ln -sf ${CURRENT_DIR}/.inputrc ${USERPROFILE}/.inputrc"
sudo ln -sf ${CURRENT_DIR}/.inputrc ${USERPROFILE}/

title 'sudo apt install -y fzf'
saptin "fzf"

title 'sudo apt install -y tmux'
saptin "tmux"

title 'git clone --depth 1 https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack'
if [ -e ${USERPROFILE}/.tmux-themepack ]; then
  echo "Already Installed."
else
  git clone --depth 1 https://github.com/jimeh/tmux-themepack.git ${USERPROFILE}/.tmux-themepack
fi

title "ln -sf ${CURRENT_DIR}/.tmux.conf ${USERPROFILE}/.tmux.conf"
sudo ln -sf ${CURRENT_DIR}/.tmux.conf ${USERPROFILE}/

title 'git clone https://github.com/scop/bash-completion.git /usr/share/bash-completion'
sudo git clone https://github.com/scop/bash-completion.git /usr/share/bash-completion

title 'cargo install alacritty'
cargo install alacritty
title "sudo ln -sf ${SRC_DIR}/alacritty/alacritty.yml ${DEST_DIR}/alacritty/"
if [ -e ${DEST_DIR}/alacritty ]; then
  :
else
  mkdir ${DEST_DIR}/alacritty
  cd ${CURRENT_DIR}
fi
sudo ln -sf ${SRC_DIR}/alacritty/alacritty.yml ${DEST_DIR}/alacritty/

#-------------------------------------------------------------------------------------------------------"
section '06. Language / Framework / MiddleWare'
#-------------------------------------------------------------------------------------------------------"
#--------------------------------------------------------------------------------------------------"
section '# C-build-essential Install'
#--------------------------------------------------------------------------------------------------"
title 'gcc Build Tools & Library'
saptin "
build-essential 
gdb 
binutils 
bc 
bison 
pkg-config 
libc6 
libc6-dev 
libfreetype6-dev 
libfontconfig1-dev 
libjansson-dev 
libseccomp-dev 
libxcb-xfixes0-dev 
libxml2-dev 
libyaml-dev 
"

title 'Clang Build Tools & Library'
saptin "
clang 
llvm 
libclang-dev 
libboost-all-dev 
clang-format cmake 
"

#--------------------------------------------------------------------------------------------------"
section '# Go'
#--------------------------------------------------------------------------------------------------"
title 'sudo rm -rf /usr/local/go'
sudo rm -rf /usr/local/go

title "sudo wget -O /tmp/go${Go_VER}.linux-amd64.tar.gz https://dl.google.com/go/go${Go_VER}.linux-amd64.tar.gz"
sudo wget -O /tmp/go${Go_VER}.linux-amd64.tar.gz https://dl.google.com/go/go${Go_VER}.linux-amd64.tar.gz

title "sudo tar -C /usr/local -xzf /tmp/go${Go_VER}.linux-amd64.tar.gz"
sudo tar -C /usr/local -xzf /tmp/go${Go_VER}.linux-amd64.tar.gz

#--------------------------------------------------------------------------------------------------"
section '# Python Install'
#--------------------------------------------------------------------------------------------------"
# Install ansible
# https://docs.ansible.com/ansible/latest/user_guide/windows_faq.html#can-ansible-run-on-windows
title 'Build Tools & Library'
saptin "
build-essential 
libbz2-dev 
libdb-dev 
libreadline-dev 
libffi-dev 
libgdbm-dev 
liblzma-dev 
libncursesw5-dev 
libsqlite3-dev 
libssl-dev 
zlib1g-dev 
uuid-dev 
tk-dev 
python3-distutils 
python3-docutils 
"

title 'sudo apt install -y python3-venv'
saptin "python3-venv"

title 'git clone --depth 1 https://github.com/pyenv/pyenv.git ~/.pyenv'
if [ -e ${USERPROFILE}/.pyenv ]; then
  # 存在する場合
  pyenv update
else
  git clone --depth 1 https://github.com/pyenv/pyenv.git ${USERPROFILE}/.pyenv
fi

title "pyenv install ${Py_VER}"
if [ -e ${USERPROFILE}/.pyenv/versions/${Py_VER} ]; then
  echo "Already Installed."
  title 'pip install -U pip'
  pip install -U pip
else
  pyenv install ${Py_VER}
  pyenv global ${Py_VER}
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
saptin "vim"

title 'sudo apt install -y vim-gtk'
saptin "vim-gtk"

title 'git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim'
if [ -e ${USERPROFILE}/.vim ]; then
  # 存在する場合
  if [ -e ${USERPROFILE}/.vim/bundle ]; then
    if [ -e ${USERPROFILE}/.vim/bundle/Vundle.vim ]; then
      echo "Already Installed."
    else
      git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git ${USERPROFILE}/.vim/bundle/"Vundle.vim"
    fi
  else
    cd ${USERPROFILE}/.vim
    mkdir bundle
    git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git ${USERPROFILE}/.vim/bundle/"Vundle.vim"
  fi
else
  # 存在しない場合
  cd ${USERPROFILE}
  mkdir .vim
  cd .vim
  mkdir bundle
  git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git ${USERPROFILE}/.vim/bundle/"Vundle.vim"
fi

title "ln -sf ${CURRENT_DIR}/.vimrc ${USERPROFILE}/.vimrc"
sudo ln -sf ${CURRENT_DIR}/.vimrc ${USERPROFILE}/

title "ln -sf ${dotfile_DIR}/mnt/common/.vim-snippets ${USERPROFILE}/.vim-snippets"
sudo ln -sf ${dotfile_DIR}/mnt/common/.vim-snippets/ ${USERPROFILE}/
title 'pip install neovim'
pip install neovim
pip install -U neovim

#--------------------------------------------------------------------------------------------------"
section '08. i3 & i3-gaps'
#--------------------------------------------------------------------------------------------------"
#https://blog.benjames.io/2017/09/03/installing-i3-gaps-on-ubuntu-16-04/

#title 'sudo apt install -y i3'
#saptin "i3"

title 'sudo apt install -y i3-gaps'
saptin "i3-gaps"

title 'Library'
saptin "
arandr
libxcb1-dev 
libxcb-keysyms1-dev 
libpango1.0-dev 
libxcb-util0-dev 
libxcb-icccm4-dev 
libyajl-dev 
libstartup-notification0-dev 
libxcb-randr0-dev 
libev-dev 
libxcb-cursor-dev 
libxcb-xinerama0-dev 
libxcb-xkb-dev 
libxkbcommon-dev 
libxkbcommon-x11-dev 
xutils-dev 
libxcb-xrm0 
libxcb-xrm-dev 
libxcb-shape0-dev 
"

#--------------------------------------------------------------------------------------------------"
section '09.  fcitx Install'
#--------------------------------------------------------------------------------------------------"
title 'sudo apt install -y fcitx-mozc'
saptin "fcitx-mozc"

title 'sudo apt install -y fcitx-tools'
saptin "fcitx-tools"

title 'sudo apt install fcitx-module-dbus'
saptin "fcitx-module-dbus"

title 'sudo apt install -y yaru-theme-icon'
saptin "yaru-theme-icon"

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

title 'curl -s https://sh.rustup.rs | bat'
cargo install --locked bat

title 'git clone https://github.com/sstephenson/bats.git /tmp/bats'
sudo git clone https://github.com/sstephenson/bats.git /tmp/bats
sudo /tmp/bats/install.sh /usr/local
sudo rm -rf /tmp/bats

title 'cargo install broot'
cargo install broot
broot
broot --help
title "sudo ln -sf ${SRC_DIR}/broot/conf.toml ${DEST_DIR}/broot/"
if [ -e ${DEST_DIR}/broot ]; then
  :
else
  mkdir ${DEST_DIR}/broot
  cd ${CURRENT_DIR}
fi
sudo ln -sf ${SRC_DIR}/broot/conf.toml ${DEST_DIR}/broot/

title 'git clone --depth 1 https://github.com/universal-ctags/ctags.git /tmp/ctags'
sudo git clone https://github.com/universal-ctags/ctags.git /tmp/ctags
cd /tmp/ctags
sudo ./autogen.sh && ./configure --prefix=/usr/local && make && make install
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
saptin "jq"

title 'sudo apt install ncdu'
saptin "ncdu"

title 'sudo apt install nkf'
saptin "nkf"

title 'cargo install ripgrep'
cargo install ripgrep

title 'GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt'
GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt

title 'git clone https://github.com/jonas/tig.git /tmp/tig'
sudo git clone https://github.com/jonas/tig.git /tmp/tig
cd /tmp/tig
sudo make
sudo make install
cd ${CURRENT_DIR}
sudo rm -rf /tmp/tig
title "sudo ln -sf ${CURRENT_DIR}/.tigrc ${USERPROFILE}/"
sudo ln -sf ${CURRENT_DIR}/.tigrc ${USERPROFILE}/

title 'git clone https://github.com/facebook/zstd.git ~/zstd'
git clone https://github.com/facebook/zstd.git ${USERPROFILE}/zstd
cd ${USERPROFILE}/zstd
sudo make install
cd ${USERPROFILE}/zstd/contrib/pzstd
sudo make install

title 'git clone git@github.com:rupa/z.git /usr/bin/z'
if [ -e /usr/bin/z ]; then
  echo 'Already installed.'
else
  sudo git clone https://github.com/rupa/z.git /usr/bin/z
fi

title 'sudo apt install -y gnupg2'
saptin "gnupg2"

title 'sudo apt install -y xclip'
saptin "xclip"

title 'sudo apt install -y neofetch'
saptin "neofetch"

title 'sudo apt install -y shellcheck'
saptin "shellcheck"

title 'sudo apt install -y wireless-tools'
saptin "wireless-tools"

#title 'sudo apt install -y zoxide'
title 'curl -sS https://webinstall.dev/zoxide | bash'
#sudo apt install -y zoxide
curl -sS https://webinstall.dev/zoxide | bash

title 'cargo install onefetch'
cargo install onefetch

title 'sudo apt install ccze'
saptin "ccze"

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
