#!/bin/bash

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
readonly genie_VER="1.42"

function _update_packages(){
    sudo pacman -g
    sudo pacman -Syy
    sudo pacman -Syyu  
    sudo pacman -Sc
    sudo pacman -S aria2 curl wget make autoconf automake ntp git gnupg openssh

    #yay
    pacman -S --Needed git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si
    cd ${CURRENT_DIR}
    sudo rm -rf /tmp/yay

    #yay_update
    yay -Syu
    yay -Yc

    #volta
    curl https://get.volta.sh | bash
    volta setup
}

function _genie(){
    yay -S daemonize
    wget -O "/tmp/genie-systemd-${genie_VER}-1-x86_64.pkg.tar.zst" "https://github.com/arkane-systems/genie/releases/download/v${genie_VER}/genie-systemd-${genie_VER}-1-x86_64.pkg.tar.zst"
    cd /tmp
    sudo pacman -U "./genie-systemd-${genie_VER}-1-x86_64.pkg.tar.zst"
    sudo rm -rf "./genie-systemd-${genie_VER}-1-x86_64.pkg.tar.zst"
    cd ${CURRENT_DIR}
}

function _other_packages(){
        git config --global core.pager delta
        git config --global core.whitespace cr-at-eol
        git config --global delta.syntax-theme Monokai Extended
        git config --global delta.line-number true
        git config --global delta.side-by-side true
        git config --global interactive.diffFilter delta --color-only
        
        #clipboard
        curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
        unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
        chmod +x /tmp/win32yank.exe
        mv /tmp/win32yank.exe ~/.local/bin
        sudo rm -rf /tmp/win32yank.zip

        #symbola
        yay -S font-symbola
        #NerdFont
        if [ -e ${USERPROFILE}/.local/share/fonts/NerdFonts/"Sauce Code Pro Nerd Font Complete.ttf" ]; then
            echo "Already installed."
        else
            sudo git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git /tmp/nerd-fonts
            /tmp/nerd-fonts/install.sh SourceCodePro
            sudo rm -rf /tmp/nerd-fonts/
        fi
        
        #gcc clang
        sudo pacman -S base-devel gdb binutils bc bison pkgconf clang llvm cmake 
        
        #Golang
        sudo pacman -S go 
        GO111MODULE=on go get -u github.com/tadashi-aikawa/gowl
        GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt
        
        go get -d github.com/skanehira/docui
        cd $GOPATH/src/github.com/skanehira/docui
        GO111MODULE=on go install
        cd ${CURRENT_DIR}

        #Python
        sudo pacman -S python ninja
        pip3 install meson pywinrm awscli ansible
        pip3 install glances glances[docker,ip,web]

        #rustup / rust
        sudo pacman -S rustup
        rustup install nightly-x86_64-unknown-linux-gnu
        rustup install beta-x86_64-unknown-linux-gnu
        rustup default beta-x86_64-unknown-linux-gnu
        rustup self update
        rustup update
        cargo install cargo-update
        cargo install-update -a
        rustup component add clippy rls rust-analysis rust-src rust-docs rustfmt
        rustup default nightly-x86_64-unknown-linux-gnu

        #volta/npm
        volta install node@latest
        volta install yarn@latest
        npm -g install typescript
        npm install -g npm-upgrade
        npm install -g bash-language-server
        npm install -g fx
        npm update *
        volta list all

        if [ -e ${USERPROFILE}/.tmux-themepack ]; then
            echo "Already Installed."
        else
            git clone --depth 1 https://github.com/jimeh/tmux-themepack.git ${USERPROFILE}/.tmux-themepack
        fi
        sudo ln -sf ${dotfile_DIR}/mnt/common/.vim-snippets/ ${USERPROFILE}/

        if [ -e /usr/bin/z ]; then
            echo 'Already installed.'
        else
            sudo git clone https://github.com/rupa/z.git /usr/bin/z
        fi

        sudo git clone https://github.com/sstephenson/bats.git /tmp/bats
        sudo /tmp/bats/install.sh /usr/local
        sudo rm -rf /tmp/bats

        sudo pacman -S broot ctags docker-compose jq ncdu ripgrep zstd z wireless_tools onefetch
        
        if [ -e ${DEST_DIR}/broot/launcher ]; then
            :
        else
            broot
        fi
        broot --help
}

function _set_init_files_symlinks() {
    ln -sf ${CURRENT_DIR}/.Xresources ${USERPROFILE}/
    ln -sf ${CURRENT_DIR}/.aliases ${USERPROFILE}/
    ln -sf ${CURRENT_DIR}/.bashrc ${USERPROFILE}/.bashrc.org
    ln -sf ${CURRENT_DIR}/.bashrc.kuni ${USERPROFILE}/
    ln -sf ${CURRENT_DIR}/.gtkrc-2.0 ${USERPROFILE}/
    ln -sf ${CURRENT_DIR}/.gtkrc-2.0.mine ${USERPROFILE}/
    ln -sf ${CURRENT_DIR}/.profile ${USERPROFILE}/
    ln -sf ${CURRENT_DIR}/.vimrc ${USERPROFILE}/
    ln -sf ${CURRENT_DIR}/.xinitrc ${USERPROFILE}/
    ln -sf ${CURRENT_DIR}/.xprofile ${USERPROFILE}/
    ln -sf ${CURRENT_DIR}/.zshrc ${USERPROFILE}/
}

function _install_dein() {
	readonly DEIN_CACHE_DIR="${HOME}/.cache/dein"
	readonly DEIN_INSTALLER="/tmp/dein_installer.sh"
	curl -sL https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh >"${DEIN_INSTALLER}"
	chmod +x "${DEIN_INSTALLER}"
	"${DEIN_INSTALLER}" "${DEIN_CACHE_DIR}"
}

function _install_packages() {
    :
	sudo pacman -S --needed - <"${CURRENT_DIR}/PKGLIST"
}

function _other_install_packages() {
    :
}

function _set_symlinks() {
	for src in ${SRC_FILES[@]}; do
		dest="${src/${SRC_DIR}/${DEST_DIR}/}"

		dest_dir="$(dirname "${dest}")"
		_verbose "Create directory: ${dest_dir}"
		mkdir -p "${dest_dir}"

		_verbose "Create symlink:   ${src} --> ${dest}"
		ln -sf "${src}" "${dest}"
	done
}

function _main() {
    _banner "Update packages"
    _update_packages
    _info "The package has been updated."

    _banner "Install genie"
    _genie
    _info "Finished genie installation!"

    _banner "Install packages"
	_install_packages
	_info "Finished packages installation!"
    
    _banner "Install Other_packages"
    _other_packages
    _info "Finished Other_packages installation!"

    _banner "Install init_files"
    _set_init_files_symlinks
    _info "Finished init files installation!"
    _banner "Install config files"
	_set_symlinks
	_info "Finished config files installation!"

    _banner "Install dein.vim"
	_install_dein
	_info "Finished dein.vim installation!"
}

function _verbose() {
	printf "[ \e[34;1mVERBOSE\e[m ] %s\n" "${*}"
}

function _info() {
	printf "[ \e[36;1mINFO\e[m ] %s\n" "${*}"
}

function _err() {
	printf "[ \e[31;1mERR\e[m ] %s\n" "${*}"
}

function _banner() {
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
