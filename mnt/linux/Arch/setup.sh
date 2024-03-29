#!/bin/bash
readonly USERPROFILE=${HOME}
readonly CURRENT_DIR="$(
  cd "$(dirname "${BASH_SOURCE:-0}")"
  pwd
)"
readonly SRC_DIR="${CURRENT_DIR}/.config"
readonly SRC_FILES=(
    "$(find "${SRC_DIR}" -type f -or -type l)"
)
readonly DEST_DIR="${USERPROFILE}/.config"
readonly dotfile_DIR=$(cd ${CURRENT_DIR} && cd ../../../ && pwd)

function _update_packages(){
    sudo pacman -Syyu
    sudo pacman -S --needed aria2 curl wget make autoconf automake ntp git gnupg openssh base-devel

    #yay 
    git clone https://aur.archlinux.org/yay-bin /tmp/yay-bin
    cd /tmp/yay-bin
    makepkg -si
    cd ${CURRENT_DIR}
    sudo rm -rf /tmp/yay-bin

    #yay_update https://furuya7.hatenablog.com/entry/2020/05/06/180426
    yay -Syyu

    #volta
    yay -S volta-bin
    volta setup
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
 
        #NerdFont
        if [ -e ${USERPROFILE}/.local/share/fonts/NerdFonts/"Sauce Code Pro Nerd Font Complete.ttf" ]; then
            echo "Already installed."
        else
            sudo git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git /tmp/nerd-fonts
            /tmp/nerd-fonts/install.sh SourceCodePro
            sudo rm -rf /tmp/nerd-fonts/
        fi
        
        #gcc clang
        sudo pacman -S --needed base-devel gdb binutils bc bison pkgconf clang llvm lldb cmake 
        
        #Golang
        sudo pacman -S --needed go 
        GO111MODULE=on go get -u github.com/tadashi-aikawa/gowl
        GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt

        #Python
        sudo pacman -S --needed python ninja 
        sudo pip3 install --upgrade awscli glances glances[docker,ip,web]

        #rustup / rust
        sudo pacman -S --needed rustup
        rustup install nightly-x86_64-unknown-linux-gnu
        rustup install beta-x86_64-unknown-linux-gnu
        rustup default beta-x86_64-unknown-linux-gnu
        rustup update
        cargo install-update -a
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
        ln -sf ${dotfile_DIR}/mnt/common/.vim-snippets/ ${USERPROFILE}/

        if [ -e /usr/bin/z ]; then
            echo 'Already installed.'
        else
            sudo git clone https://github.com/rupa/z.git /usr/bin/z
        fi

        git clone https://github.com/sheepla/fzpac /tmp/fzpac
        cd /tmp/fzpac
        sudo make install
        cd ${CURRENT_DIR}
        sudo rm -rf /tmp/fzpac

        git clone https://github.com/sheepla/fzman /tmp/fzman
        cd /tmp/fzman
        sudo make install
        cd ${CURRENT_DIR}
        sudo rm -rf /tmp/fzman
 
        sudo pacman -S --needed jq zstd z 
        
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
	sudo pacman -S --needed - <"${CURRENT_DIR}/PKGLIST.kuni"
    yay -S --needed - <"${CURRENT_DIR}/PKGLIST_AUR"
    yay -S --needed - <"${CURRENT_DIR}/PKGLIST_AUR.kuni"
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

    _banner "Update packages"
    _update_packages
    _info "The package has been updated."
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

_main "${@}"
