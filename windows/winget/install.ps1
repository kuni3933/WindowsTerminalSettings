function Write_Title($msg) {
  Write-Output "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  Write-Output "┃$msg"
  Write-Output "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
$bit = "null"
If ($env:PROCESSOR_ARCHITECTURE -ceq "AMD64" -or "X64" -or "IA64" -or "ARM64") {
  $bit = "x64"
}
ElseIf ($env:PROCESSOR_ARCHITECTURE -ceq "X86") {
  $bit = "x86"
}
$msg = " Install the $bit version."
Write_Title $msg

Write_Title " Git"
If (Test-Path $env:PROGRAMFILES/Git/bin/git.exe) {
  Write-Output "インストール済みです。"
  Write-Output "This application is already installed."
  Write-Output " "
  git --version
  Write-Output " "
  winget show --id Git.Git
  Write-Output " "
  git update-git-for-windows
  Write-Output " "
}
ElseIf (-not(Test-Path $env:PROGRAMFILES/Git/bin/git.exe)) {
  winget show --id Git.Git
  winget install -e --id Git.Git
}

Write_Title " Windows Terminal Preview"
If (Test-Path $env:LOCALAPPDATA/Microsoft/WindowsApps/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/wt.exe) {
  Write-Output "インストール済みです。"
  Write-Output "This application is already installed."
  Write-Output " "
  winget show --id Microsoft.WindowsTerminalPreview
  Write-Output " "
}
ElseIf (-not(Test-Path $env:LOCALAPPDATA/Microsoft/WindowsApps/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/wt.exe)) {
  winget show --id Microsoft.WindowsTerminalPreview
  winget install -e --id Microsoft.WindowsTerminalPreview
}

Write_Title " Visual Studio Code (User Installer - $bit)"
If (Test-Path $env:LOCALAPPDATA/Programs/"Microsoft VS Code"/Code.exe) {
  Write-Output "インストール済みです。"
  Write-Output "This application is already installed."
  Write-Output " "
  code --version
  Write-Output " "
  winget show --id Microsoft.VisualStudioCode-User-x64
  Write-Output " "
}
ElseIf (-not(Test-Path $env:LOCALAPPDATA/Programs/"Microsoft VS Code"/Code.exe) -and $bit -eq "x64") {
  winget show --id Microsoft.VisualStudioCode-User-x64
  Write-Output " "
  winget install -e --id Microsoft.VisualStudioCode-User-x64
  Write-Output " "
}
ElseIf (-not(Test-Path $env:LOCALAPPDATA/Programs/"Microsoft VS Code"/Code.exe) -and $bit -eq "x86") {
  winget show --id Microsoft.VisualStudioCode-User-x86
  Write-Output " "
  winget install -e --id Microsoft.VisualStudioCode-User-x86
  Write-Output " "
}

Write_Title " Visual Studio Code Insiders (User Installer - $bit)"
If (Test-Path  $env:LOCALAPPDATA/Programs/"Microsoft VS Code Insiders/Code - Insiders.exe") {
  Write-Output "インストール済みです。"
  Write-Output "This application is already installed."
  Write-Output " "
  code-insiders --version
  Write-Output " "
  winget show --id Microsoft.VisualStudioCodeInsiders-User-x64
  Write-Output " "
}
ElseIf (-not(Test-Path  $env:LOCALAPPDATA/Programs/"Microsoft VS Code Insiders/Code - Insiders.exe") -and $bit -eq "x64") {
  winget show --id Microsoft.VisualStudioCodeInsiders-User-x64
  Write-Output " "
  winget install -e --id Microsoft.VisualStudioCodeInsiders-User-x64
  Write-Output " "
}
ElseIf (-not(Test-Path  $env:LOCALAPPDATA/Programs/"Microsoft VS Code Insiders/Code - Insiders.exe") -and $bit -eq "x86") {
  winget show --id Microsoft.VisualStudioCodeInsiders-User-x86
  Write-Output " "
  winget install -e --id Microsoft.VisualStudioCodeInsiders-User-x86
  Write-Output " "
}

Write_Title " PowerShellCore (pwsh)"
Write-Output "インストール又はアップデートを行います。"
Write-Output "Install or update the software."
Write-Output " "
winget show --id Microsoft.PowerShell
Write-Output " "
winget install -e --id Microsoft.PowerShell
Write-Output " "

Read-Host "ENTERを押して終了します。 `r`n Press ENTER to exit. `r`n"
Write_Title " 'install.ps1' has finished."
