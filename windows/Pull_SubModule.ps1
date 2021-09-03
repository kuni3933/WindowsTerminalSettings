function Write_Title($msg) {
  Write-Host "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
  Write-Host "┃$msg" -ForegroundColor Yellow
  Write-Host "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
}
function Write_Section($msg) {
  Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
  Write-Host "  $msg" -ForegroundColor Green
  Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
}
function br($times) {
  $tmp = 1
  while ($tmp -le $times) {
    Write-Output " ";
    $tmp += 1
  }
}
function pull($module,$branch){
    Set-Location "$env:USERPROFILE/WindowsTerminalSettings/$module"
    git pull origin $branch
    br(1)
}


# Path
$now = Get-Location
$WindowsTerminalSettings = "$env:USERPROFILE/WindowsTerminalSettings"
$MyPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$WINDOWS="$MyPath/../windows"

$owl_playbook_WINDOWS="$MyPath/../owl-playbook/windows"

$WINDOWS_MNT="$MyPath/../mnt/windows"
$LINUX_MNT="$MyPath/../mnt/linux"
$COMMON_MNT="$MyPath/../mnt/common"

$dotfiles="$MyPath/../dotfiles"

$owl_playbook_WINDOWS_MNT="$MyPath/../owl-playbook/mnt/windows"
$owl_playbook_LINUX_MNT="$MyPath/../owl-playbook/mnt/linux"
$owl_playbook_COMMON_MNT="$MyPath/../owl-playbook/mnt/common"


# Update_Function
function copy_Windows(){
  Copy-Item "$owl_playbook_WINDOWS/idea-files.txt"                 "$WINDOWS/" -Force
  Copy-Item "$owl_playbook_WINDOWS/vscode-extensions.txt"    "$WINDOWS/" -Force
  Copy-Item "$owl_playbook_WINDOWS/windows-home-dots.txt" "$WINDOWS/" -Force
}

function copy_Windows_MNT(){
  Copy-Item "$owl_playbook_WINDOWS_MNT/keypirinha" -Recurse "$WINDOWS_MNT/" -Force
  Copy-Item "$owl_playbook_WINDOWS_MNT/.bashrc"                   "$WINDOWS_MNT/" -Force
  Copy-Item "$owl_playbook_WINDOWS_MNT/.minttyrc"                "$WINDOWS_MNT/" -Force
  Copy-Item "$owl_playbook_WINDOWS_MNT/.oh-my-posh.json"   "$WINDOWS_MNT/" -Force
  Copy-Item "$owl_playbook_WINDOWS_MNT/broot.toml"              "$WINDOWS_MNT/" -Force
  Copy-Item "$dotfiles/.vimrc"                                                       "$WINDOWS_MNT/" -Force
}

function copy_linux_MNT(){
# Copy-Item "dotfiles/" "LINUX_MNT/Arch/"
  Copy-Item "$dotfiles/.config"   -Recurse "$LINUX_MNT/Arch/" -Force
  Copy-Item "$dotfiles/.local"     -Recurse "$LINUX_MNT/Arch/" -Force
  Copy-Item "$dotfiles/.w3m"    -Recurse "$LINUX_MNT/Arch/" -Force
  Copy-Item "$dotfiles/bin"        -Recurse "$LINUX_MNT/Arch/" -Force
  Copy-Item "$dotfiles/st"         -Recurse "$LINUX_MNT/Arch/" -Force
  Copy-Item "$dotfiles/.aliases"               "$LINUX_MNT/Arch/" -Force
  Copy-Item "$dotfiles/.bashrc"               "$LINUX_MNT/Arch/" -Force
  Copy-Item "$dotfiles/.gtkrc-2.0"            "$LINUX_MNT/Arch/" -Force
  Copy-Item "$dotfiles/.gtkrc-2.0.mine"    "$LINUX_MNT/Arch/" -Force
  Copy-Item "$dotfiles/.profile"                "$LINUX_MNT/Arch/" -Force
  Copy-Item "$dotfiles/.vimrc"                  "$LINUX_MNT/Arch/" -Force
  Copy-Item "$dotfiles/.xinitrc"                 "$LINUX_MNT/Arch/" -Force
  Copy-Item "$dotfiles/.xprofile"               "$LINUX_MNT/Arch/" -Force
  Copy-Item "$dotfiles/.Xresources"         "$LINUX_MNT/Arch/" -Force
  Copy-Item "$dotfiles/.zshrc"                 "$LINUX_MNT/Arch/" -Force
  Copy-Item "$dotfiles/PKGLIST"             "$LINUX_MNT/Arch/" -Force
  Copy-Item "$dotfiles/PKGLIST_AUR"     "$LINUX_MNT/Arch/" -Force
  Copy-Item "$dotfiles/update-pkglist.sh" "$LINUX_MNT/Arch/" -Force
}

function copy_Common_MNT(){
  Copy-Item "$owl_playbook_COMMON_MNT/.vim-snippets"                          -Recurse "$COMMON_MNT/" -Force
  Copy-Item "$owl_playbook_COMMON_MNT/IntelliJIdea"                              -Recurse "$COMMON_MNT/" -Force
  Copy-Item "$owl_playbook_COMMON_MNT/VSCode/User/snippets"              -Recurse "$COMMON_MNT/VSCode/User/" -Force
  Copy-Item "$owl_playbook_COMMON_MNT/VSCode/User/keybindings.json"                "$COMMON_MNT/VSCode/User/" -Force
}


#------------------------------------------------------------------------------------------------------------------------------------------------
# submodule_list
$module = git config --file .gitmodules --get-regexp path | awk '{print $ 2}'
Write-Host $module
# Repositoryが存在しない場合
if(!(Test-Path $WindowsTerminalSettings)){
    Write-Host  "Repository:WindowsTerminalSettings が%USERPROFILE%に存在しないないためサブモジュールのpullが出来ません."
    Write-Host  "Repository:WindowsTerminalSettings を%USERPROFILE%にgit cloneして配置してください."
    Write-Host  "Cannot pull submodules because Repository:WindowsTerminalSettings does not exist in %USERPROFILE%."
    Write-Host  "Git clone Repository:WindowsTerminalSettings to %USERPROFILE% and place it there."
    Write-Host  "Reference:https://github.com/kuni3933/WindowsTerminalSettings"
    exit
}
# Repositoryが存在する場合
if(Test-Path $WindowsTerminalSettings){
    # -------------------------------------------------------------------------git submodule foreach git pull
    Set-Location "$env:USERPROFILE/WindowsTerminalSettings"
    Write_Title "現在のサブモジュールステータス / Current submodule status"
    git submodule status
    br(2)

    Write_Title "Pull後のサブモジュールステータス / Submodule status after Pull"
    pull "dotfiles" "master"
    pull "owl-playbook" "master"
    pull "pipes.sh" "master"
    Set-Location "$env:USERPROFILE/WindowsTerminalSettings"
    br(2)

    git submodule status
    br(1)
    Write-Host  Pull is complete.

    Set-Location $now
    br(2)


    $input = Read-Host "Do you want to perform Update & Overwrite? (Y/n)"
    if(($input -eq "Y") -or ($input -eq "y") -or ($input -eq "Yes") -or ($input -eq "yes")){
        # ---------------------------------------------------------------------Update&Overwrite
        Write_Section("copy_Windows")
        copy_Windows

        Write_Section("copy_Windows_MNT")
        copy_Windows_MNT

        Write_Section("copy_linux_MNT")
        copy_linux_MNT

        Write_Section("copy_Common_MNT")
        copy_Common_MNT

        br(2)
    }
    else{}
}


Write_Section "このPull_SubModule.batが終了した後にprovision.batを実行してください."
Write_Section "After this Pull_SubModule.bat is finished, please run provision.bat."
Write_Section "'Pull_SubModule.ps1' has finished."


