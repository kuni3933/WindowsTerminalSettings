#!/bin/bash
set -eu
_subtitle(){
  echo "---------------------------------------------"
  echo "  $1"
  echo "---------------------------------------------"
}
_title(){
  echo "-------------------------------------------------------------------------------------------"
  echo "  $1"
  echo "-------------------------------------------------------------------------------------------"
}
_section(){
  echo "-------------------------------------------------------------------------------------------"
  echo "     $1"
  echo "-------------------------------------------------------------------------------------------"
}
_br(){
    for i in `seq $1`
    do  
        echo ""
    done
}
_pull(){
    cd "${WindowsTerminalSettings}/$1"
    _subtitle "$1"
    git pull origin "$2"
    cd "${WindowsTerminalSettings}"
    _br 1
}

# 参考 - https://devconnected.com/how-to-check-if-file-or-directory-exists-in-bash/
USERNAME=$(whoami)
now=$(pwd)
MyPath=$(cd $(dirname $0); pwd)
cd "${MyPath}/../"
WindowsTerminalSettings=$(pwd)
echo "USERNAME                : ${USERNAME}"
echo "Current_DIR             : ${now}"
echo "WindowsTerminalSettings : ${WindowsTerminalSettings}"
if [ -e "${WindowsTerminalSettings}/../WindowsTerminalSettings" ]; then
    _section "Start"
    cd "${WindowsTerminalSettings}"
    _title "現在のサブモジュールステータス / Current submodule status"
    git submodule status
    _br 2

    _title "git submodule foreach git fetch"
    git submodule foreach git fetch
    _br 2

    _title "git submodule foreach git pull origin master"
    _pull "dotfiles" "master"
    _pull "owl-playbook" "master"
    _pull "pipes.sh" "master"
    _pull "mnt/linux/Arch/.config/ranger/plugins/ranger_devicons" "main"
    cd "${WindowsTerminalSettings}"
    _br 2

    _title "Pull後のサブモジュールステータス / Submodule status after Pull"
    git submodule status
    _br 2

    cd $now
    _section "Pull_SubModule.sh is complete."
else
    _section "Error"
    echo "Repository:WindowsTerminalSettings が $HOME に存在しないないためサブモジュールのpullが出来ません."
    echo "Repository:WindowsTerminalSettings を $HOME に git cloneして配置してください."
    echo "Cannot pull submodules because Repository:WindowsTerminalSettings does not exist in $HOME."
    echo "Git clone Repository:WindowsTerminalSettings to $HOME and place it there."
    echo "参考-Reference:https://github.com/kuni3933/WindowsTerminalSettings"
fi

