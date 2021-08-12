#!/bin/bash
set -eu
title(){
  echo "-------------------------------------------------------------------------------------------"
  echo "  $1"
  echo "-------------------------------------------------------------------------------------------"
}
section(){
  echo "-------------------------------------------------------------------------------------------"
  echo "     $1"
  echo "-------------------------------------------------------------------------------------------"
}
br(){
    for i in `seq $1`
    do  
        echo ""
    done
}
pull(){
    cd "/home/${USERNAME}/WindowsTerminalSettings/$1"
    git pull origin "$2"
    br 1
}

# 参考 - https://devconnected.com/how-to-check-if-file-or-directory-exists-in-bash/
USERNAME=$(whoami)
if [ -e "/home/${USERNAME}/WindowsTerminalSettings" ]; then
    echo true
    cd "/home/${USERNAME}/WindowsTerminalSettings"
    title "現在のサブモジュールステータス / Current submodule status"
    git submodule status
    br 2

    title "git submodule foreach git fetch"
    git submodule foreach git fetch
    br 2

    title "git submodule foreach git pull origin master"
    pull "dotfiles" "master"
    pull "owl-playbook" "master"
    pull "pipes.sh" "master"
    cd "/home/${USERNAME}/WindowsTerminalSettings"
    br 2

    title "Pull後のサブモジュールステータス / Submodule status after Pull"
    git submodule status
    br 2

    section "Pull_SubModule.sh is complete."
else
    section "Error"
    echo "Repository:WindowsTerminalSettings が $HOME に存在しないないためサブモジュールのpullが出来ません."
    echo "Repository:WindowsTerminalSettings を $HOME に git cloneして配置してください."
    echo "Cannot pull submodules because Repository:WindowsTerminalSettings does not exist in $HOME."
    echo "Git clone Repository:WindowsTerminalSettings to $HOME and place it there."
    echo "参考-Reference:https://github.com/kuni3933/WindowsTerminalSettings"
fi

