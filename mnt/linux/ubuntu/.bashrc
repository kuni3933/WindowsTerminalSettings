# shellcheck disable=SC1090,SC2012
export PATH="$PATH:/usr/local/go/bin:~/go/bin:~/.pyenv/bin:~/.local/share/umake/ide/idea/bin"
export GOPATH="$HOME/go"
#WindowsTerminalSettings_Original
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
export GPG_TTY=$(tty)
alias lla='exa -al --icons --git'
neofetch
#-----------------------------------------------------------------------------------------------------------------------------------------------

# 日本語入力
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export DefaultIMModule=fcitx

# クリップボード連携 (For WSL2)
LOCAL_IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
export DISPLAY=$LOCAL_IP:0

# Ctrl+Sの画面ロックを無効
stty stop undef

# z
. /usr/bin/z

# [fzf] 設定
export FZF_DEFAULT_OPTS="--reverse --border --height 50%"
# デフォルトコマンドfd
export FZF_DEFAULT_COMMAND='fd -HL --exclude ".git" .'
# fzfのCtrl+T設定 ファイルの中身を表示して200行をプレビュー
# export FZF_CTRL_T_OPTS="--preview 'bat --color \"always\" {}' --height 90%"
export FZF_CTRL_T_OPTS="--height 90%"
# fzfのALt+C設定 ツリー表示して200行をプレビュー
# export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200' --height 90%"
export FZF_ALT_C_OPTS="--height 90%"

# [fzf] オートコンプリートのデフォルトコマンド
_fzf_compgen_path() {
  fd -HL --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fd --type d -HL --exclude ".git" . "$1"
}

# alias
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias cdr='cd $(fd -H -t d | fzf)'
alias cdz='cd $(z -l | cut -c 12- | fzf)'
alias cdg='cd $(gowl list | fzf)'

alias ga='git add'
alias gaa='git add --all'
alias gb='git checkout $(git branch -l | grep -vE "^\*" | tr -d " " | fzf)'
alias gbc='git checkout -b'
alias gco='git commit -m'
alias gbr='git branch -rl | grep -vE "HEAD|master" | tr -d " " | sed -r "s@origin/@@g" | fzf | xargs -i git checkout -b {} origin/{}'
alias gd='git diff'
alias gds='git diff --staged'
alias gf='git fetch --all'
alias gl='git log'
alias gll='git log -10 --oneline --all --graph --decorate'
alias gls='git log -3'
alias glll="git log --graph --all --date=format:'%Y-%m-%d %H:%M' --pretty=format:'%C(auto)%d%Creset %C(yellow reverse)%h%Creset %C(magenta)%ae%Creset %C(cyan)%ad%Creset%n%C(white bold)%w(80)%s%Creset%n%b'"
alias glls="git log --graph --all --date=format:'%Y-%m-%d %H:%M' --pretty=format:'%C(auto)%d%Creset %C(yellow reverse)%h%Creset %C(magenta)%ae%Creset %C(cyan)%ad%Creset%n%C(white bold)%w(80)%s%Creset%n%b' -10"
alias gbm='git merge --no-ff $(git branch -l | grep -vE "^\*" | tr -d " " | fzf)'
alias gs='git status --short'
alias gss='git status -v'

alias ll='exa -l --icons --git'
alias tree='exa -lT --icons --git'

alias pj='pipenv run python jumeaux/executor.py'

alias vimn='vim -u NONE -N'
alias vimr='vim $(fd -H | fzf)'
alias vimz='vim $(grep "^>" ~/.viminfo | cut -c 3- | sed "s@~@$HOME@" | fzf)'


# pyenv
eval "$(pyenv init -)"

#------------------------------------------------------------------------------------------------------------------------------------------------
#bash_it
# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# Path to the bash it configuration
export BASH_IT="/home/kuni3933/.bash_it"

# Lock and Load a custom theme file.
# Leave empty to disable theming.
# location /.bash_it/themes/
export BASH_IT_THEME='maman'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# (Advanced): Change this to the name of the main development branch if
# you renamed it or if it was changed for some reason
# export BASH_IT_DEVELOPMENT_BRANCH='master'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true
# Set to actual location of gitstatus directory if installed
#export SCM_GIT_GITSTATUS_DIR="$HOME/gitstatus"
# per default gitstatus uses 2 times as many threads as CPU cores, you can change this here if you must
#export GITSTATUS_NUM_THREADS=8

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# If your theme use command duration, uncomment this to
# enable display of last command duration.
#export BASH_IT_COMMAND_DURATION=true
# You can choose the minimum time in seconds before
# command duration is displayed.
#export COMMAND_DURATION_MIN_SECONDS=1

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Uncomment this to make Bash-it create alias reload.
# export BASH_IT_RELOAD_LEGACY=1

# Load Bash It
source "$BASH_IT"/bash_it.sh
#----------------------------------------------------------------------------------------------------------------------------------------------
export LC_ALL=en_US.UTF8
. ~/.bashrc.org

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

source /home/kuni3933/.config/broot/launcher/bash/br
