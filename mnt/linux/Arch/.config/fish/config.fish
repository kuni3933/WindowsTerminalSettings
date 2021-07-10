#!/usr/bin/env fish

# 起動時のメッセージを無効に
set fish_greeting

# プロンプトを設定
if which starship &>/dev/null
    eval (starship init fish)
end

if which exa &>/dev/null
    alias ls 'exa --classify --icons'
    alias l  'exa -all --classify --icons'
    alias ll 'exa -all --long --classify --icons'
    alias lt 'exa -all --tree --classify --icons'
end

if which bat &>/dev/null
    alias cat 'bat'
end

alias cls clear
alias c clear

if which ranger &>/dev/null
    alias r 'ranger'
end

# fzf (jethrokuan/fzf)
set -U FZF_LEGACY_KEYBINDINGS 0
# set -U FZF_REVERSE_ISEARCH_OPTS "--reverse --height=100%"
set -U FZF_REVERSE_ISEARCH_OPTS "--reverse --height=50%"

if which enhancd &>/dev/null
    alisa cd enhancd
end
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
