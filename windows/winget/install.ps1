function Write_Title($msg){
  echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "┃$msg"
  echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Write_Title "Git"
If(Test-Path $env:PROGRAMFILES/Git/bin/git.exe){
  echo "インストール済みです。"
  echo "This application is already installed."
  echo " "
  git --version
  echo " "
  winget show --id Git.Git
  echo " "
  git update-git-for-windows
  echo " "
}
ElseIf(-not(Test-Path $env:PROGRAMFILES/Git/bin/git.exe)){
  winget show --id Git.Git
  winget install -e --id Git.Git
}

Write_Title "WindowsTerminalPreview"
If(Test-Path $env:LOCALAPPDATA/Microsoft/WindowsApps/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/wt.exe){
  echo "インストール済みです。"
  echo "This application is already installed."
  echo " "
  winget show --id Microsoft.WindowsTerminalPreview
  echo " "
}
ElseIf(-not(Test-Path $env:LOCALAPPDATA/Microsoft/WindowsApps/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/wt.exe)){
  winget show --id Microsoft.WindowsTerminalPreview
  winget install -e --id Microsoft.WindowsTerminalPreview
}

Write_Title "VSCode"
If(Test-Path $env:LOCALAPPDATA/Programs/"Microsoft VS Code"/Code.exe){
  echo "インストール済みです。"
  echo "This application is already installed."
  echo " "
  code --version
  echo " "
  winget show --id Microsoft.VisualStudioCode-User-x64
  echo " "

}
ElseIf(-not(Test-Path $env:LOCALAPPDATA/Programs/"Microsoft VS Code"/Code.exe)){
  winget show --id Microsoft.VisualStudioCode-User-x64
  echo " "
  winget install -e --id Microsoft.VisualStudioCode-User-x64
  echo " "
}

Write_Title "VSCode-Insiders"
If(Test-Path  $env:LOCALAPPDATA/Programs/"Microsoft VS Code Insiders/Code - Insiders.exe"){
  echo "インストール済みです。"
  echo "This application is already installed."
  echo " "
  code-insiders --version
  echo " "
  winget show --id Microsoft.VisualStudioCodeInsiders-User-x64
  echo " "

}
ElseIf(-not(Test-Path  $env:LOCALAPPDATA/Programs/"Microsoft VS Code Insiders/Code - Insiders.exe")){
  winget show --id Microsoft.VisualStudioCodeInsiders-User-x64
  echo " "
  winget install -e --id Microsoft.VisualStudioCodeInsiders-User-x64
  echo " "
}

Write_Title "pwsh"
echo "インストール又はアップデートを行います。"
echo "Install or update the software."
echo " "
winget show --id Microsoft.PowerShell
echo " "
winget install -e --id Microsoft.PowerShell
echo " "

$input_tmp = Read-Host "ENTERを押して終了します。 `r`n Press ENTER to exit. `r`n"
echo "'install.ps1' has finished."
