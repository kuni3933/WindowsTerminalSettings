function Write_Section($msg) {
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
    Write-Host "     $msg" -ForegroundColor Green
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
}

function br($times) {
  $tmp = 1
  while ($tmp -le $times) {
    Write-Output " ";
    $tmp += 1
  }
}

#
$WINDOWS="$PSScriptRoot..\windows"

$owl_playbook_WINDOWS="$PSScriptRoot..\owl-playbook\windows"

$WINDOWS_MNT="$PSScriptRoot..\mnt\windows"
$LINUX_MNT="$PSScriptRoot..\mnt\linux"
$COMMON_MNT="$PSScriptRoot..\mnt\common"

$dotfiles="$PSScriptRoot..\dotfiles"

$owl_playbook_WINDOWS_MNT="$PSScriptRoot..\owl-playbook\mnt\windows"
$owl_playbook_LINUX_MNT="$PSScriptRoot..\owl-playbook\mnt\linux"
$owl_playbook_COMMON_MNT="$PSScriptRoot..\owl-playbook\mnt\common"


#Function
# Update_Function
function copy_Windows(){
  xcopy "$owl_playbook_WINDOWS\idea-files.txt"                 "$WINDOWS\idea-files.txt"
  xcopy "$owl_playbook_WINDOWS\vscode-extensions.txt"    "$WINDOWS\vscode-extensions.txt"
  xcopy "$owl_playbook_WINDOWS\windows-home-dots.txt" "$WINDOWS\windows-home-dots.txt"
  exit
}

function copy_Windows_MNT(){
  xcopy "$owl_playbook_WINDOWS_MNT\keypirinha"           "$WINDOWS_MNT\keypirinha" /E /H /S /I
  xcopy "$owl_playbook_WINDOWS_MNT\.bashrc"                "$WINDOWS_MNT\.bashrc"
  xcopy "$owl_playbook_WINDOWS_MNT\.minttyrc"             "$WINDOWS_MNT\.minttyrc"
  xcopy "$owl_playbook_WINDOWS_MNT\.oh-my-posh.json" "$WINDOWS_MNT\.oh-my-posh.json"
  xcopy "$owl_playbook_WINDOWS_MNT\broot.toml"           "$WINDOWS_MNT\broot.toml"
  exit
}

function copy_linux_MNT(){
# xcopy "dotfiles\" "LINUX_MNT\Arch\"
  xcopy "$dotfiles\.config"                 "$LINUX_MNT\Arch\.config" /E /H /S /I
  xcopy "$dotfiles\.local"                    "$LINUX_MNT\Arch\.local" /E /H /S /I
  xcopy "$dotfiles\.w3m"                   "$LINUX_MNT\Arch\.w3m" /E /H /S /I
  xcopy "$dotfiles\bin"                      "$LINUX_MNT\Arch\bin" /E /H /S /I
  xcopy "$dotfiles\st"                       "$LINUX_MNT\Arch\st" /E /H /S /I
  xcopy "$dotfiles\.aliases"               "$LINUX_MNT\Arch\.aliases"
  xcopy "$dotfiles\.bashrc"               "$LINUX_MNT\Arch\.bashrc"
  xcopy "$dotfiles\.gtkrc-2.0"            "$LINUX_MNT\Arch\.gtkrc-2.0"
  xcopy "$dotfiles\.gtkrc-2.0.mine"    "$LINUX_MNT\Arch\.gtkrc-2.0.mine"
  xcopy "$dotfiles\.profile"                "$LINUX_MNT\Arch\.profile"
  xcopy "$dotfiles\.vimrc"                  "$LINUX_MNT\Arch\.vimrc"
  xcopy "$dotfiles\.xinitrc"                 "$LINUX_MNT\Arch\.xinitrc"
  xcopy "$dotfiles\.xprofile"               "$LINUX_MNT\Arch\.xprofile"
  xcopy "$dotfiles\.Xresources"         "$LINUX_MNT\Arch\.Xresources"
  xcopy "$dotfiles\.zshrc"                 "$LINUX_MNT\Arch\.zshrc"
  xcopy "$dotfiles\PKGLIST"             "$LINUX_MNT\Arch\PKGLIST"
  xcopy "$dotfiles\PKGLIST_AUR"     "$LINUX_MNT\Arch\PKGLIST_AUR"
  xcopy "$dotfiles\update-pkglist.sh" "$LINUX_MNT\Arch\update-pkglist.sh"
  exit
}

function copy_Common_MNT(){
  xcopy "$owl_playbook_COMMON_MNT\.vim-snippets"                          "$COMMON_MNT\.vim-snippets" /E /H /S /I
  xcopy "$owl_playbook_COMMON_MNT\IntelliJIdea"                              "$COMMON_MNT\IntelliJIdea" /E /H /S /I
  xcopy "$owl_playbook_COMMON_MNT\VSCode\User\snippets"             "$COMMON_MNT\VSCode\User\snippets" /E /H /S /I
  xcopy "$owl_playbook_COMMON_MNT\VSCode\User\keybindings.json" "$COMMON_MNT\VSCode\User\keybindings.json"
  exit
}

# ------------------------------------------------------------------------------------------------------更新処理
Write_Section("copy_Windows")
copy_Windows

Write_Section("copy_Windows_MNT")
copy_Windows_MNT

Write_Section("copy_linux_MNT")
copy_linux_MNT

Write_Section("copy_Common_MNT")
copy_Common_MNT
