function Write_Title($msg) {
  Write-Host "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
  Write-Host "┃$msg" -ForegroundColor Yellow
  Write-Host "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
}

function Installed_msg {
  Write-Host "  インストール済みです." -ForegroundColor Green
  Write-Host "  This application is already installed." -ForegroundColor Green
  Write-Host " "
}

function  Update_msg {
  Write-Host "  インストール済みです. アップデートを行います." -ForegroundColor Cyan
  Write-Host "  This application is already installed. Update the pwsh." -ForegroundColor Cyan
  Write-Host " "
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
  Update_msg
  git --version
  Write-Host " "
  winget show --id Git.Git
  Write-Host " "
  git update-git-for-windows
  Write-Host " "
}
ElseIf (-not(Test-Path $env:PROGRAMFILES/Git/bin/git.exe)) {
  winget show --id Git.Git
  winget install -e --id Git.Git
}

Write_Title " Windows Terminal Preview"
If (Test-Path $env:LOCALAPPDATA/Microsoft/WindowsApps/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/wt.exe) {
  Installed_msg
  winget show --id Microsoft.WindowsTerminalPreview
  Write-Host " "
}
ElseIf (-not(Test-Path $env:LOCALAPPDATA/Microsoft/WindowsApps/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/wt.exe)) {
  winget show --id Microsoft.WindowsTerminalPreview
  winget install -e --id Microsoft.WindowsTerminalPreview
}

Write_Title " Visual Studio Code (User Installer - $bit)"
If (Test-Path $env:LOCALAPPDATA/Programs/"Microsoft VS Code"/Code.exe) {
  Installed_msg
  code --version
  Write-Host " "
  winget show --id Microsoft.VisualStudioCode-User-x64
  Write-Host " "
}
ElseIf (-not(Test-Path $env:LOCALAPPDATA/Programs/"Microsoft VS Code"/Code.exe) -and $bit -eq "x64") {
  winget show --id Microsoft.VisualStudioCode-User-x64
  Write-Host " "
  winget install -e --id Microsoft.VisualStudioCode-User-x64
  Write-Host " "
}
ElseIf (-not(Test-Path $env:LOCALAPPDATA/Programs/"Microsoft VS Code"/Code.exe) -and $bit -eq "x86") {
  winget show --id Microsoft.VisualStudioCode-User-x86
  Write-Host " "
  winget install -e --id Microsoft.VisualStudioCode-User-x86
  Write-Host " "
}

Write_Title " Visual Studio Code Insiders (User Installer - $bit)"
If (Test-Path  $env:LOCALAPPDATA/Programs/"Microsoft VS Code Insiders/Code - Insiders.exe") {
  Installed_msg
  code-insiders --version
  Write-Host " "
  winget show --id Microsoft.VisualStudioCodeInsiders-User-x64
  Write-Host " "
}
ElseIf (-not(Test-Path  $env:LOCALAPPDATA/Programs/"Microsoft VS Code Insiders/Code - Insiders.exe") -and $bit -eq "x64") {
  winget show --id Microsoft.VisualStudioCodeInsiders-User-x64
  Write-Host " "
  winget install -e --id Microsoft.VisualStudioCodeInsiders-User-x64
  Write-Host " "
}
ElseIf (-not(Test-Path  $env:LOCALAPPDATA/Programs/"Microsoft VS Code Insiders/Code - Insiders.exe") -and $bit -eq "x86") {
  winget show --id Microsoft.VisualStudioCodeInsiders-User-x86
  Write-Host " "
  winget install -e --id Microsoft.VisualStudioCodeInsiders-User-x86
  Write-Host " "
}

Write_Title " PowerShellCore (pwsh)"
If (Test-Path  $env:PROGRAMFILES/PowerShell/7/pwsh.exe) {
  Update_msg
}
winget show --id Microsoft.PowerShell
Write-Host " "
winget install -e --id Microsoft.PowerShell
Write-Host " "

Write_Title " ENTERを押して終了します. / Press ENTER to exit."
Read-Host " "
Write_Title " 'install.ps1'が終了しました. / 'install.ps1' has finished."
