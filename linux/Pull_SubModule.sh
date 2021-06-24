#!/bin/bash
set -eu
title(){
  echo "-------------------------------------------------------------------------------------------"
  echo "  $1"
  echo "-------------------------------------------------------------------------------------------"
}
br(){
  echo ""
  echo ""
}

# 参考 - https://devconnected.com/how-to-check-if-file-or-directory-exists-in-bash/
if [[! -d "~/WindowsTerminalSettings/" ]]
then
  title "Error"
  echo "Repository:WindowsTerminalSettings が $home に存在しないないためサブモジュールのpullが出来ません."
  echo "Repository:WindowsTerminalSettings を $home に git cloneして配置してください."
  echo "Cannot pull submodules because Repository:WindowsTerminalSettings does not exist in $home."
  echo "Git clone Repository:WindowsTerminalSettings to $home and place it there."
  echo "参考-Reference:https://github.com/kuni3933/WindowsTerminalSettings"
else
  cd ~/WindowsTerminalSettings/

fi

