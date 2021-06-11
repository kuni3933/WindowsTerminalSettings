function Write_Title($msg) {
  Write-Host "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
  Write-Host "┃$msg" -ForegroundColor Yellow
  Write-Host "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
}

function Install_msg {
  Write-Host "  インストールを開始します." -ForegroundColor Yellow
  Write-Host "  Start the installation of this application." -ForegroundColor Yellow
  Write-Host " "
}
function Already_Installed_msg {
  Write-Host "  インストール済みです." -ForegroundColor Green
  Write-Host "  This application is already installed." -ForegroundColor Green
  Write-Host " "
}

function  Update_msg {
  Write-Host "  インストール済みです. アップデートを行います." -ForegroundColor Cyan
  Write-Host "  This application is already installed. Update the pwsh." -ForegroundColor Cyan
  Write-Host " "
}
function br($times) {
  $tmp = 1
  while ($tmp -le $times) {
    Write-Output " ";
    $tmp += 1
  }
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
winget --Version
winget --info
winget  source update
br(2)


Write_Title " Git"
If (Test-Path $env:PROGRAMFILES/Git/bin/git.exe) {
  Update_msg
  git --version
  br(1)
  winget show --id Git.Git
  br(1)
  &"$env:GIT_INSTALL_ROOT/git-bash.exe" "$env:WindowsTerminalSettings/windows/winget/kill_gpg-agent.sh"
  br(1)
  git update-git-for-windows
  br(2)
}
ElseIf (-not(Test-Path $env:PROGRAMFILES/Git/bin/git.exe)) {
  Install_msg
  winget show --id Git.Git
  br(1)
  winget install -e --id Git.Git
  br(2)
}


Write_Title " Windows Terminal Preview"
If (Test-Path $env:LOCALAPPDATA/Microsoft/WindowsApps/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/wt.exe) {
  Already_Installed_msg
  winget show --id Microsoft.WindowsTerminalPreview --source winget
  br(2)
}
ElseIf (-not(Test-Path $env:LOCALAPPDATA/Microsoft/WindowsApps/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/wt.exe)) {
  Install_msg
  winget show --id Microsoft.WindowsTerminalPreview --source winget
  br(1)
  winget install -e --id Microsoft.WindowsTerminalPreview --source winget
  br(2)
}


Write_Title " Visual Studio Code"
If (Test-Path $env:LOCALAPPDATA/Programs/"Microsoft VS Code"/Code.exe) {
  Already_Installed_msg
  code --version
  br(1)
  winget show --id Microsoft.VisualStudioCode
  br(2)
}
ElseIf (-not(Test-Path $env:LOCALAPPDATA/Programs/"Microsoft VS Code"/Code.exe)) {
  Install_msg
  winget show --id Microsoft.VisualStudioCode --source winget
  br(1)
  winget install -e --id Microsoft.VisualStudioCode --source winget --override "/silent /mergetasks=""addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"""
  br(2)
}

Write_Title " Visual Studio Code Insiders"
If (Test-Path  $env:LOCALAPPDATA/Programs/"Microsoft VS Code Insiders/Code - Insiders.exe") {
  Already_Installed_msg
  code-insiders --version
  br(1)
  winget show --id Microsoft.VisualStudioCode.Insiders --source winget
  br(2)
}
ElseIf (-not(Test-Path  $env:LOCALAPPDATA/Programs/"Microsoft VS Code Insiders/Code - Insiders.exe")) {
  Install_msg
  winget show --id Microsoft.VisualStudioCode.Insiders --source winget
  br(1)
  winget install -e --id Microsoft.VisualStudioCode.Insiders --source winget --override "/silent /mergetasks=""addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"""
  br(2)
}

Write_Title " PowerToys"
If (Test-Path $env:PROGRAMFILES/PowerToys/PowerToys.exe) {
  Already_Installed_msg
  winget show --id Microsoft.PowerToys --source winget
  br(2)
}
ElseIf (-not(Test-Path $env:PROGRAMFILES/PowerToys/PowerToys.exe)) {
  Install_msg
  winget show --id Microsoft.PowerToys --source winget
  br(1)
  winget install -e --id Microsoft.PowerToys --source winget
  br(2)
}

Write_Title " PowerShellCore (pwsh)"
If (Test-Path  $env:PROGRAMFILES/PowerShell/7/pwsh.exe) {
  Update_msg
  winget show --id Microsoft.PowerShell --source winget
  br(1)
  winget install -e --id Microsoft.PowerShell --source winget
  br(2)
}
ElseIf (-not(Test-Path  $env:PROGRAMFILES/PowerShell/7/pwsh.exe)) {
  Install_msg
  winget show --id Microsoft.PowerShell --source winget
  br(1)
  winget install -ei --id Microsoft.PowerShell --source winget
  br(2)
}

Pause
Write_Title " 'install.ps1'が終了しました. / 'install.ps1' has finished."
