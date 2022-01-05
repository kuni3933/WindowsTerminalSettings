. "./Function.ps1"
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Path
${now} = Get-Location
${MyPath} = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location "$MyPath/../"
${WindowsTerminalSettings} = Get-Location

${WINDOWS} = "${WindowsTerminalSettings}/windows/"
${WINDOWS_MNT} = "{$WindowsTerminalSettings}/mnt/windows/"
${LINUX_MNT} = "${WindowsTerminalSettings}/mnt/linux/"
${COMMON_MNT} = "${WindowsTerminalSettings}/mnt/common/"

${owl_playbook_WINDOWS} = "${WindowsTerminalSettings}/owl-playbook/windows/"
${owl_playbook_WINDOWS_MNT} = "${WindowsTerminalSettings}/owl-playbook/mnt/windows/"
${owl_playbook_COMMON_MNT} = "${WindowsTerminalSettings}/owl-playbook/mnt/common/"

${dotfiles} = "{$WindowsTerminalSettings}/dotfiles/"

#Pull_Function
function _pull($module,$branch){
    Set-Location "${WindowsTerminalSettings}/${module}"
    git pull origin $branch
    _br(1)
}

# Update_Function
function _copy_Windows(){
  Copy-Item "${owl_playbook_WINDOWS}/idea-files.txt"                 "${WINDOWS}/" -Force
  Copy-Item "${owl_playbook_WINDOWS}/vscode-extensions.txt"    "${WINDOWS}/" -Force
  Copy-Item "${owl_playbook_WINDOWS}/windows-home-dots.txt" "${WINDOWS}/" -Force
}

function _copy_Windows_MNT(){
  Copy-Item "${owl_playbook_WINDOWS_MNT}/keypirinha" -Recurse "${WINDOWS_MNT}/" -Force
  Copy-Item "${owl_playbook_WINDOWS_MNT}/.bashrc"                   "${WINDOWS_MNT}/" -Force
  Copy-Item "${owl_playbook_WINDOWS_MNT}/.minttyrc"                "${WINDOWS_MNT}/" -Force
  Copy-Item "${owl_playbook_WINDOWS_MNT}/.oh-my-posh.json"   "${WINDOWS_MNT}/" -Force
  Copy-Item "${owl_playbook_WINDOWS_MNT}/broot.toml"              "${WINDOWS_MNT}/" -Force
  Copy-Item "${dotfiles}/.vimrc.old" "${WINDOWS_MNT}/.vimrc" -Force
}

function _copy_linux_MNT(){
# Copy-Item "dotfiles/" "LINUX_MNT/Arch/"
  Copy-Item "${dotfiles}/.config"   -Recurse "${LINUX_MNT}/Arch/" -Force
  Copy-Item "${dotfiles}/.local"     -Recurse "${LINUX_MNT}/Arch/" -Force
  Copy-Item "${dotfiles}/.w3m"    -Recurse "${LINUX_MNT}/Arch/" -Force
  Copy-Item "${dotfiles}/bin"        -Recurse "${LINUX_MNT}/Arch/" -Force
  Copy-Item "${dotfiles}/st"         -Recurse "${LINUX_MNT}/Arch/" -Force
  Copy-Item "${dotfiles}/.aliases"               "${LINUX_MNT}/Arch/" -Force
  Copy-Item "${dotfiles}/.bashrc"               "${LINUX_MNT}/Arch/" -Force
  Copy-Item "${dotfiles}/.gtkrc-2.0"            "${LINUX_MNT}/Arch/" -Force
  Copy-Item "${dotfiles}/.gtkrc-2.0.mine"    "${LINUX_MNT}/Arch/" -Force
  Copy-Item "${dotfiles}/.profile"                "${LINUX_MNT}/Arch/" -Force
  Copy-Item "${dotfiles}/.vimrc"                  "${LINUX_MNT}/Arch/" -Force
  Copy-Item "${dotfiles}/.xinitrc"                 "${LINUX_MNT}/Arch/" -Force
  Copy-Item "${dotfiles}/.xprofile"               "${LINUX_MNT}/Arch/" -Force
  Copy-Item "${dotfiles}/.Xresources"         "${LINUX_MNT}/Arch/" -Force
  Copy-Item "${dotfiles}/.zshrc"                 "${LINUX_MNT}/Arch/" -Force
  Copy-Item "${dotfiles}/PKGLIST"             "${LINUX_MNT}/Arch/" -Force
  Copy-Item "${dotfiles}/PKGLIST_AUR"     "${LINUX_MNT}/Arch/" -Force
  Copy-Item "${dotfiles}/update-pkglist.sh" "${LINUX_MNT}/Arch/" -Force
}

function _copy_Common_MNT(){
  Copy-Item "${owl_playbook_COMMON_MNT}/.vim-snippets"                          -Recurse "${COMMON_MNT}/" -Force
  Copy-Item "${owl_playbook_COMMON_MNT}/IntelliJIdea"                              -Recurse "${COMMON_MNT}/" -Force
  Copy-Item "${owl_playbook_COMMON_MNT}/VSCode/User/snippets"              -Recurse "${COMMON_MNT}/VSCode/User/" -Force
  Copy-Item "${owl_playbook_COMMON_MNT}/VSCode/User/keybindings.json"                "${COMMON_MNT}/VSCode/User/" -Force
}


#------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("Pull_SubModule.ps1")

# submodule_list
${module} = git config --file .gitmodules --get-regexp path | awk '{print $ 2}'
Write-Host ${module}

# Repositoryが存在しない場合
if(!(Test-Path ${WindowsTerminalSettings})){
    Write-Host  "Repository:WindowsTerminalSettings が%USERPROFILE%に存在しないないためサブモジュールのpullが出来ません."
    Write-Host  "Repository:WindowsTerminalSettings を%USERPROFILE%にgit cloneして配置してください."
    Write-Host  "Cannot pull submodules because Repository:WindowsTerminalSettings does not exist in %USERPROFILE%."
    Write-Host  "Git clone Repository:WindowsTerminalSettings to %USERPROFILE% and place it there."
    Write-Host  "Reference:https://github.com/kuni3933/WindowsTerminalSettings"
    exit
}
# Repositoryが存在する場合
if(Test-Path ${WindowsTerminalSettings}){
    # -------------------------------------------------------------------------git submodule foreach git pull
    Set-Location "$WindowsTerminalSettings"
    _Write_Title "現在のサブモジュールステータス / Current submodule status"
    git submodule status
    _br(2)

    _Write_Title "Pull後のサブモジュールステータス / Submodule status after Pull"
    _pull "dotfiles" "master"
    _pull "owl-playbook" "master"
    _pull "pipes.sh" "master"
    Set-Location "$WindowsTerminalSettings"
    _br(2)

    git submodule status
    _br(1)
    Write-Host  Pull is complete.

    Set-Location $now
    _br(2)


    ${tmp} = Read-Host "Do you want to perform Update & Overwrite? (Y/n)"
    if((${tmp} -eq "Y") -or (${tmp} -eq "y") -or (${tmp} -eq "Yes") -or (${tmp} -eq "yes")){
        # ---------------------------------------------------------------------Update&Overwrite
        _Write_Section("copy_Windows")
        _copy_Windows

        _Write_Section("copy_Windows_MNT")
        _copy_Windows_MNT

        _Write_Section("copy_linux_MNT")
        _copy_linux_MNT

        _Write_Section("copy_Common_MNT")
        _copy_Common_MNT

        _br(2)
    }
    else{}
}


_Write_Section "このPull_SubModule.batが終了した後にprovision.batを実行してください."
_Write_Section "After this Pull_SubModule.bat is finished, please run provision.bat."
_Write_Section "'Pull_SubModule.ps1' has finished."


