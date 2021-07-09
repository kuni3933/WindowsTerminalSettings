#!/bin/bash

# -----------------------------------------------------------------------#
#https://ytyaru.hatenablog.com/entry/2020/02/03/111111
readonly USERPROFILE=${HOME}
readonly CURRENT_DIR="$(
  cd "$(dirname "${BASH_SOURCE:-0}")"
  pwd
)"
readonly SRC_DIR="${CURRENT_DIR}/.config"
readonly SRC_FILES=(
	"$(find "${SRC_DIR}" -type f)"
)
readonly DEST_DIR="${USERPROFILE}/.config"
readonly dotfile_DIR=$(cd ${CURRENT_DIR} && cd ../../../ && pwd)
readonly Go_VER="1.16.5"
readonly Py_VER="3.9.6"
# ------------------------------------------------------------------------#
_title() {
  echo ""
  echo "-----------------------------------------------------------------#"
  echo "# $1"
  echo "-----------------------------------------------------------------#"
}
_section() {
  echo ""
  echo ""
  echo ""
  echo "###########################################################################################"
  echo "#    $1"
  echo "###########################################################################################"
}
_saptin() {
  if [ $# -ne 1 ]; then
    echo "Error : Argument Error/引数エラー"
    echo "       \"sudo apt install\" に必要な1個の引数が必要です。" 1>&2
    echo "       One argument required for \"sudo apt install\"." 1>&2
    exit 1
  else
    sudo apt install -y ${1}
  fi
}
_aptshow() {
  if [ $# -ne 1 ]; then
    echo "Error : Argument Error/引数エラー"
    echo "       \"sudo apt install\" に必要な1個の引数が必要です。" 1>&2
    echo "       One argument required for \"sudo apt install\"." 1>&2
    exit 1
  else
    apt show ${1}
  fi
}
_install_dein() {
  readonly DEIN_CACHE_DIR="${HOME}/.cache/dein"
  readonly DEIN_INSTALLER="/tmp/dein_installer.sh"
  curl -sL https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh >"${DEIN_INSTALLER}"
  chmod +x "${DEIN_INSTALLER}"
  "${DEIN_INSTALLER}" "${DEIN_CACHE_DIR}"
}
_install_packages() {
  :
  #sudo pacman -S --needed - <"${CURRENT_DIR}/PKGLIST"
}
_set_symlinks() {
  for src in ${SRC_FILES[@]}; do
    dest="${src/${SRC_DIR}/${DEST_DIR}/}"

    dest_dir="$(dirname "${dest}")"
    _verbose "Create directory: ${dest_dir}"
    mkdir -p "${dest_dir}"

    _verbose "Create symlink:   ${src} --> ${dest}"
    sudo ln -sf "${src}" "${dest}"
  done
}
_main() {
  #_banner "Install packages"
  #_install_packages
  #_info "Finished packages installation!"

  _banner "Install config files"
  _set_symlinks
  _info "Finished config files installation!"

  _banner "Install dein.vim"
  _install_dein
  _info "Finished dein.vim installation!"
}
_verbose() {
  printf "[ \e[34;1mVERBOSE\e[m ] %s\n" "${*}"
}
_info() {
  printf "[ \e[36;1mINFO\e[m ] %s\n" "${*}"
}
_err() {
  printf "[ \e[31;1mERR\e[m ] %s\n" "${*}"
}
_banner() {
  echo -e "
\e[1m#####################################\e[m
\e[1m# ${*} \e[m
\e[1m#####################################\e[m
"
}

#------------------------------------------------------------------------#
#_section"00"
#------------------------------------------------------------------------#
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
echo "SRC_FILES   : "
echo ${SRC_FILES}
echo "DEST_DIR    : ${DEST_DIR}"
echo "Go_VERSION  : ${Go_VER}"
echo "Py_VERSION  : ${Py_VER}"

_main "${@}"

#------------------------------------------------------------------------#
_section '01. Package Update'
#------------------------------------------------------------------------#
_title 'sudo apt update -y && sudo apt upgrade -y'
sudo apt update -y && sudo apt upgrade -y

_title 'sudo apt full-upgrade -y'
sudo apt full-upgrade -y

_title 'sudo apt autoremove -y && sudo apt autoclean -y'
sudo apt autoremove -y
sudo apt autoclean -y

_title 'sudo apt-get update -y && sudo apt-get upgrade -y'
sudo apt-get update -y && sudo apt-get upgrade -y

_title 'sudo apt-get full-upgrade -y'
sudo apt-get full-upgrade -y

_title 'sudo apt-get autoremove -y && sudo apt-get autoclean -y'
sudo apt-get autoremove -y
sudo apt-get autoclean -y

#------------------------------------------------------------------------#
_section '02. Core Setup'
#------------------------------------------------------------------------#
_title 'sudo dpkg-reconfigure tzdata'
sudo dpkg-reconfigure tzdata

_title 'sudo apt install -y aria2'
_saptin "aria2"

_title 'sudo apt install -y ubuntu-wsl'
_saptin "ubuntu-wsl"

_title 'sudo apt install -y curl'
_saptin "curl"

_title 'sudo apt install -y wget'
_saptin "wget"

_title 'sudo apt install -y make'
_saptin "make"

_title 'sudo apt install -y autoconf'
_saptin "autoconf"

_title 'sudo apt install -y automake'
_saptin "automake"

_title 'sudo apt install -y ntp'
_saptin "ntp"

_title 'sudo apt install -y apt-file'
_saptin "apt-file"

_title 'sudo apt install -y software-properties-common'
_saptin "software-properties-common"

_title 'sudo apt install -y git-all'
_saptin "git-all"

_title 'curl https://get.volta.sh | bash'
curl https://get.volta.sh | bash
volta setup

#------------------------------------------------------------------------#
_section '03. PPA Setup'
#------------------------------------------------------------------------#
_title 'sudo add-apt-repository -y ppa:regolith-linux/unstable'
#https://github.com/regolith-linux/i3-gaps-wm
sudo add-apt-repository -y ppa:regolith-linux/unstable

_title 'sudo add-apt-repository -y github/gh'
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null

_title 'sudo apt update -y && sudo apt upgrade -y'
sudo apt update -y && sudo apt upgrade -y

_title 'sudo apt-get update -y && sudo apt-get upgrade -y'
sudo apt-get update -y && sudo apt-get upgrade -y

#------------------------------------------------------------------------#
_section '04. Font Install'
#------------------------------------------------------------------------#
_title 'sudo apt install -y $(check-language-support -l ja) language-pack-ja'
sudo apt install -y $(check-language-support -l ja) language-pack-ja

_title 'sudo apt install -y manpages-ja'
_saptin "manpages-ja"

_title 'sudo apt install -y  manpages-ja-dev'
_saptin "manpages-ja-dev"

_title 'sudo apt install fonts-noto-color-emoji'
_saptin "fonts-noto-color-emoji"

_title 'sudo apt install fonts-symbola'
_saptin "fonts-symbola"

_title 'git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git'
if [ -e ${USERPROFILE}/.local/share/fonts/NerdFonts/"Sauce Code Pro Nerd Font Complete.ttf" ]; then
  echo "Already installed."
else
  sudo git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git /tmp/nerd-fonts
  /tmp/nerd-fonts/install.sh SourceCodePro
  sudo rm -rf /tmp/nerd-fonts/
fi

_title 'sudo update-locale LANG=ja_JP.UTF-8'
sudo update-locale LANG=ja_JP.UTF-8

#---------------------------------------------------------------------------------------#
_section '05. Language / Framework / MiddleWare'
#---------------------------------------------------------------------------------------#
#------------------------------------------------------------------------#
_section '# C-build-essential Install'
#------------------------------------------------------------------------#
_title 'gcc Build Tools & Library'
_saptin "
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

_title 'Clang Build Tools & Library'
_saptin "
clang 
llvm 
libclang-dev 
libboost-all-dev 
clang-format cmake 
"

#------------------------------------------------------------------------#
_section '# Golang'
#------------------------------------------------------------------------#
_title 'sudo rm -rf /usr/local/go'
sudo rm -rf /usr/local/go

_title "sudo wget -O /tmp/go${Go_VER}.linux-amd64.tar.gz https://dl.google.com/go/go${Go_VER}.linux-amd64.tar.gz"
sudo wget -O /tmp/go${Go_VER}.linux-amd64.tar.gz https://dl.google.com/go/go${Go_VER}.linux-amd64.tar.gz

_title "sudo tar -C /usr/local -xzf /tmp/go${Go_VER}.linux-amd64.tar.gz"
sudo tar -C /usr/local -xzf /tmp/go${Go_VER}.linux-amd64.tar.gz
sudo rm -rf "/tmp/go${Go_VER}.linux-amd64.tar.gz"

#------------------------------------------------------------------------#
_section '# Python Install'
#------------------------------------------------------------------------#
# Install ansible
# https://docs.ansible.com/ansible/latest/user_guide/windows_faq.html#can-ansible-run-on-windows
_title 'Build Tools & Library'
_saptin "
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

_title 'sudo apt install -y python3-venv'
_saptin "python3-venv"

_title 'git clone --depth 1 https://github.com/pyenv/pyenv.git ~/.pyenv'
if [ -e ${USERPROFILE}/.pyenv ]; then
  # 存在する場合
  pyenv update
else
  git clone --depth 1 https://github.com/pyenv/pyenv.git ${USERPROFILE}/.pyenv
fi

_title "pyenv install ${Py_VER}"
if [ -e ${USERPROFILE}/.pyenv/versions/${Py_VER} ]; then
  echo "Already Installed."
  _title 'pip install -U pip'
  pip install -U pip
else
  pyenv install ${Py_VER}
  pyenv global ${Py_VER}
fi

_title 'curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -'
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -

#------------------------------------------------------------------------#
_section '# rust'
#------------------------------------------------------------------------#
_title 'curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

_title 'rustup install nightly-x86_64-unknown-linux-gnu'
rustup install nightly-x86_64-unknown-linux-gnu

_title 'rustup install beta-x86_64-unknown-linux-gnu'
rustup install beta-x86_64-unknown-linux-gnu

_title 'rustup default beta-x86_64-unknown-linux-gnu'
rustup default beta-x86_64-unknown-linux-gnu

_title 'rustup self update'
rustup self update

_title 'rustup update'
rustup update

_title 'cargo install cargo-update'
cargo install cargo-update

_title 'cargo install-update --all'
cargo install-update -a

_title 'rustup component add'
rustup component add clippy rls rust-analysis rust-src rust-docs rustfmt

_title 'rustup default nightly-x86_64-unknown-linux-gnu'
rustup default nightly-x86_64-unknown-linux-gnu

#------------------------------------------------------------------------#
_section '# volta/npm Install'
#------------------------------------------------------------------------#
#_title 'curl https://get.volta.sh | bash'
#curl https://get.volta.sh | bash
#volta setup

_title 'volta install node@latest'
volta install node@latest

_title 'volta install yarn@latest'
volta install yarn@latest

_title 'sudo npm -g install typescript'
npm -g install typescript

_title 'sudo npm install -g npm-upgrade'
npm install -g npm-upgrade

_title 'npm install -g bash-language-server'
npm install -g bash-language-server

_title 'npm update *'
npm update *

_title 'volta list all'
volta list all


#------------------------------------------------------------------------#
_section '06. Terminal Setup'
#------------------------------------------------------------------------#
_title "sh -c "$(curl -fsSL https://starship.rs/install.sh)""
sh -c "$(curl -fsSL https://starship.rs/install.sh)"
sudo ln -sf ${CURRENT_DIR}/.config/starship.toml ${DEST_DIR}/

_title 'git clone https://github.com/Bash-it/bash-it.git ~/.bash_it'
if [ -e ${USERPROFILE}/.bash_it ]; then
  # 存在する場合
  echo 'Already Installed.'
else
  # 存在しない場合
  git clone https://github.com/Bash-it/bash-it.git ${USERPROFILE}/.bash_it
  ${USERPROFILE}/.bash_it/install.sh
fi

_title "ln -sf ${CURRENT_DIR}/.bash_it/themes/maman ${USERPROFILE}/.bash_it/themes/"
sudo ln -sf ${CURRENT_DIR}/.bash_it/themes/maman/ ${USERPROFILE}/.bash_it/themes/

_title "ln -sf ${CURRENT_DIR}/.bashrc ${USERPROFILE}/.bashrc.org"
if [ -e ${USERPROFILE}/.bashrc.org ]; then
  #既にある場合
  echo "Already Installed."
else
  sudo ln -sf ${CURRENT_DIR}/.bashrc ${USERPROFILE}/.bashrc.org
  echo '. ~/.bashrc.org' >>${USERPROFILE}/.bashrc
  _section 'Restart the shell'
  exit
fi

_title "ln -sf ${CURRENT_DIR}/.aliases ${USERPROFILE}/.aliases.org"
if [ -e ${USERPROFILE}/.aliases ]; then
  #既にある場合
  echo "Already Installed."
else
  sudo ln -sf ${CURRENT_DIR}/.aliases ${USERPROFILE}/.aliases
  echo '. ~/.aliases' >>${USERPROFILE}/.bashrc
  _section 'Restart the shell'
  exit
fi

_title 'sudo apt install cmatrix'
_saptin "cmatrix"

_title "ln -sf ${CURRENT_DIR}/.inputrc ${USERPROFILE}/.inputrc"
sudo ln -sf ${CURRENT_DIR}/.inputrc ${USERPROFILE}/

_title 'sudo apt install -y fzf'
_saptin "fzf"

_title 'sudo apt install -y tmux'
_saptin "tmux"

_title 'git clone --depth 1 https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack'
if [ -e ${USERPROFILE}/.tmux-themepack ]; then
  echo "Already Installed."
else
  git clone --depth 1 https://github.com/jimeh/tmux-themepack.git ${USERPROFILE}/.tmux-themepack
fi

_title "ln -sf ${CURRENT_DIR}/.tmux.conf ${USERPROFILE}/.tmux.conf"
sudo ln -sf ${CURRENT_DIR}/.tmux.conf ${USERPROFILE}/

_title 'git clone https://github.com/scop/bash-completion.git /usr/share/bash-completion'
sudo git clone https://github.com/scop/bash-completion.git /usr/share/bash-completion

_title 'cargo install alacritty'
cargo install alacritty
#_title "sudo ln -sf ${SRC_DIR}/alacritty/alacritty.yml ${DEST_DIR}/alacritty/"
#if [ -e ${DEST_DIR}/alacritty ]; then
#  :
#else
#  mkdir ${DEST_DIR}/alacritty
#  cd ${CURRENT_DIR}
#fi
#sudo ln -sf ${SRC_DIR}/alacritty/alacritty.yml ${DEST_DIR}/alacritty/


#------------------------------------------------------------------------#
_section '07. Editor/IDE'
#------------------------------------------------------------------------#
_title 'sudo apt install -y vim-gtk'
_saptin "vim-gtk"

_title 'git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim'
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
cd ${CURRENT_DIR}

_title "ln -sf ${CURRENT_DIR}/.vimrc ${USERPROFILE}/.vimrc"
sudo ln -sf ${CURRENT_DIR}/.vimrc ${USERPROFILE}/

_title "ln -sf ${dotfile_DIR}/mnt/common/.vim-snippets ${USERPROFILE}/.vim-snippets"
sudo ln -sf ${dotfile_DIR}/mnt/common/.vim-snippets/ ${USERPROFILE}/
_title 'pip install neovim'
pip install neovim
pip install -U neovim

#------------------------------------------------------------------------#
_section '08. i3 & i3-gaps'
#------------------------------------------------------------------------#
#https://blog.benjames.io/2017/09/03/installing-i3-gaps-on-ubuntu-16-04/

#_title 'sudo apt install -y i3'
#_saptin "i3"

#https://l-o-o-s-e-d.net/wsl2
#regolith-desktop-complete
_title 'sudo apt install -y i3-gaps'
_saptin "
i3-gaps 
i3xrocks-net-traffic 
i3xrocks-cpu-usage 
i3xrocks-time 
"
#_title "ln -sf ${SRC_DIR}/i3/ ${DEST_DIR}/i3"
#if [ -e ${DEST_DIR}/i3 ]; then
#  :
#else
#  mkdir ${DEST_DIR}/i3
#fi
#ln -sf ${SRC_DIR}/i3/autostart.sh ${DEST_DIR}/i3/
#ln -sf ${SRC_DIR}/i3/config ${DEST_DIR}/i3/

_title 'git clone https://github.com/tobi-wan-kenobi/bumblebee-status ~/.bumblebee-status'
if [ -e ${USERPROFILE}/.local/share/bumblebee-status ]; then
  :
else
  git clone https://github.com/tobi-wan-kenobi/bumblebee-status ~/.local/share/bumblebee-status
fi
sudo ln -sf ${CURRENT_DIR}/.local/share/bumblebee-status/themes/iceberg-darker-powerline.json ${USERPROFILE}/.local/share/bumblebee-status/themes/iceberg-darker-powerline.json

_title 'sudo apt install -y rofi'
_saptin "
rofi 
rofi-dev 
qalc 
libtool
"

_title 'rofi -modi calc'
git clone https://github.com/svenstaro/rofi-calc /tmp/rofi-calc
cd /tmp/rofi-calc
autoreconf -i
mkdir build
cd build/
../configure
sudo make
sudo make install
cd ${CURRENT_DIR}
sudo rm -rf /tmp/rofi-calc


_title 'Library'
_saptin "
dbus
dmenu
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
yaru-theme-icon 
"

#------------------------------------------------------------------------#
_section '09.  fcitx Install'
#------------------------------------------------------------------------#
_title 'sudo apt install -y fcitx-mozc'
_saptin "fcitx-mozc 
fcitx-tools 
fcitx-module-dbus 
ibus-mozc 
ibus-gtk 
ibus-gtk3 
"
#https://unix.stackexchange.com/questions/490871/lubuntu-g-is-dbus-connection
#_title 'sudo apt-get purge fcitx-module-dbus'
#sudo apt-get purge fcitx-module-dbus

#------------------------------------------------------------------------#
_section '10. CLI tool Install'
#------------------------------------------------------------------------#
_title 'sudo apt install -y gh'
_saptin "gh"

_title 'git clone https://github.com/x-motemen/ghq /tmp/ghq'
git clone https://github.com/x-motemen/ghq /tmp/ghq
cd /tmp/ghq
make install
cd ${CURRENT_DIR}
sudo rm -rf /tmp/ghq

_title 'pip install pywinrm'
pip install pywinrm
pip install -U pywinrm

_title 'pip install awscli'
pip install awscli
pip install -U awscli

_title 'pip install ansible'
pip install ansible
pip install -U ansible

_title 'curl -s https://sh.rustup.rs | bat'
cargo install bat

_title 'git clone https://github.com/sstephenson/bats.git /tmp/bats'
sudo git clone https://github.com/sstephenson/bats.git /tmp/bats
sudo /tmp/bats/install.sh /usr/local
sudo rm -rf /tmp/bats

_title 'cargo install broot'
cargo install broot
if [ -e ${DEST_DIR}/broot/launcher ]; then
  :
else
  broot
fi
broot --help

_title 'git clone --depth 1 https://github.com/universal-ctags/ctags.git /tmp/ctags'
sudo git clone https://github.com/universal-ctags/ctags.git /tmp/ctags
cd /tmp/ctags
sudo ./autogen.sh && ./configure --prefix=/usr/local && make && make install
cd ${CURRENT_DIR}
sudo rm -rf /tmp/ctags

_title 'cargo install git-delta'
cargo install git-delta
git config --global core.pager delta
git config --global core.whitespace cr-at-eol
git config --global delta.syntax-theme Monokai Extended
git config --global delta.line-number true
git config --global delta.side-by-side true
git config --global interactive.diffFilter delta --color-only

_title 'git clone https://github.com/skanehira/docui.git /tmp/docui'
git clone https://github.com/skanehira/docui.git /tmp/docui
cd /tmp/docui
GO111MODULE=on go install
cd ${CURRENT_DIR}
sudo rm -rf /tmp/docui

_title 'pip isntall docker/compose'
pip install docker-compose
pip install -U docker-compose

_title 'cargo install exa'
cargo install exa

_title 'cargo install fd-find'
cargo install fd-find

_title 'npm install -g fx'
npm install -g fx

_title 'pip install glances glances[docker,ip,web]'
pip install glances glances[docker,ip,web]

_title 'go get -u github.com/tadashi-aikawa/gowl'
GO111MODULE=on go get -u github.com/tadashi-aikawa/gowl

_title 'sudo apt install -y jq'
_saptin "jq"

_title 'sudo apt install -y ncdu'
_saptin "ncdu"

_title 'sudo apt install -y nkf'
_saptin "nkf"

_title 'sudo apt install -y translate-shell'
_saptin "translate-shell"

_title 'sudo apt install -y w3m'
_saptin "w3m"

_title 'cargo install ripgrep'
cargo install ripgrep

_title 'GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt'
GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt

_title 'git clone https://github.com/jonas/tig.git /tmp/tig'
sudo git clone https://github.com/jonas/tig.git /tmp/tig
cd /tmp/tig
sudo make
sudo make install
cd ${CURRENT_DIR}
sudo rm -rf /tmp/tig
_title "sudo ln -sf ${CURRENT_DIR}/.tigrc ${USERPROFILE}/"
sudo ln -sf ${CURRENT_DIR}/.tigrc ${USERPROFILE}/

_title 'git clone https://github.com/facebook/zstd.git ~/zstd'
git clone https://github.com/facebook/zstd.git ${USERPROFILE}/zstd
cd ${USERPROFILE}/zstd
sudo make install
cd ${USERPROFILE}/zstd/contrib/pzstd
sudo make install
cd ${CURRENT_DIR}

_title 'git clone git@github.com:rupa/z.git /usr/bin/z'
if [ -e /usr/bin/z ]; then
  echo 'Already installed.'
else
  sudo git clone https://github.com/rupa/z.git /usr/bin/z
fi

_title 'sudo apt install -y gnupg2'
_saptin "gnupg2"

_title 'sudo apt install -y xclip'
_saptin "xclip"

_title 'sudo apt install -y neofetch'
_saptin "neofetch"

_title 'sudo apt install -y shellcheck'
_saptin "shellcheck"

_title 'sudo apt install -y wireless-tools'
_saptin "wireless-tools"

#_title 'sudo apt install -y zoxide'
_title 'curl -sS https://webinstall.dev/zoxide | bash'
#sudo apt install -y zoxide
curl -sS https://webinstall.dev/zoxide | bash

_title 'cargo install onefetch'
cargo install onefetch

_title 'sudo apt install ccze'
_saptin "ccze"

#------------------------------------------------------------------------#
_section '11. Package autoremove'
#------------------------------------------------------------------------#
_title 'sudo apt autoremove -y && sudo apt autoclean -y'
sudo apt autoremove -y
sudo apt autoclean -y

_title 'sudo apt-get autoremove -y && sudo apt-get autoclean -y'
sudo apt-get autoremove -y
sudo apt-get autoclean -y

#------------------------------------------------------------------------#
_section 'upgrade.sh is Finished.'
#------------------------------------------------------------------------#
