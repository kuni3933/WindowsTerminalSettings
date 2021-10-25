. "./../Function.ps1"

function Install_msg($ID){
  Write-Host "  インストールを開始します." -ForegroundColor Yellow
  Write-Host "  Start the installation of this application." -ForegroundColor Yellow
  Write-Host " "
  Write-Host " "
  winget show --id "$ID" --source winget
  Write-Host " "
  Write-Host " "
}

function  Update_msg($ID) {
  Write-Host "  インストール済みです. アップデートを行います." -ForegroundColor Cyan
  Write-Host "  This application is already installed. Update the pwsh." -ForegroundColor Cyan
  Write-Host " "
  Write-Host " "
  winget show -e --id "$ID" --source winget
  Write-Host " "
  Write-Host " "
  winget upgrade -e --id "$ID" --source winget
}

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Write_Section("winget/install.ps1")


$MyPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$bit = "null"
If (${env:PROCESSOR_ARCHITECTURE} -ceq "AMD64" -or "X64" -or "IA64" -or "ARM64") {
  $bit = "x64"
}
ElseIf (${env:PROCESSOR_ARCHITECTURE} -ceq "X86") {
  $bit = "x86"
}
$msg = "# Install the $bit version."
Write_Title($msg)
winget --Version
winget --info
winget  source update
br(2)


Write_Title("# Git")
$ID = "Git.Git"
If (Test-Path "${env:PROGRAMFILES}/Git/bin/git.exe") {
  git --version
  &"$env:GIT_INSTALL_ROOT/git-bash.exe" "$MyPath/kill_gpg-agent.sh"
  br(1)
  Update_msg("$ID")
  git update-git-for-windows
}
ElseIf (-not(Test-Path "${env:PROGRAMFILES}/Git/bin/git.exe")) {
  Install_msg("$ID")
  winget install -e --id "$ID" --source winget
}
br(2)


Write_Title("# Windows Terminal Preview")
$ID = "Microsoft.WindowsTerminal.Preview"
If (Test-Path "${env:LOCALAPPDATA}/Microsoft/WindowsApps/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/wt.exe") {
  Update_msg("$ID")
}
ElseIf (-not(Test-Path "${env:LOCALAPPDATA}/Microsoft/WindowsApps/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/wt.exe")) {
  Install_msg("$ID")
  winget install -e --id "$ID" --source winget
}
br(2)


Write_Title("# Microsoft VisualStudio 2019 BuildTools")
$ID = "Microsoft.VisualStudio.2019.BuildTools"
If (Test-Path "${env:PROGRAMFILES(X86)}/Microsoft Visual Studio/2019/BuildTools") {
  Update_msg("$ID")
}
ElseIf (-not(Test-Path "${env:PROGRAMFILES(X86)}/Microsoft Visual Studio/2019/BuildTools")) {
  Install_msg("$ID")
  winget install -e --id "$ID" --source winget
}
Write_Title("Visual Studio Installerから'C++ Build Tools'をダウンロードしてください.")
Write_Title("Download the 'C++ Build Tools' from Visual Studio Installer.")
br(2)


Write_Title("# Visual Studio Code")
$ID = "Microsoft.VisualStudioCode"
If (Test-Path "${env:LOCALAPPDATA}/Programs/Microsoft VS Code/Code.exe") {
  code --version
  Update_msg("$ID")
}
ElseIf (-not(Test-Path "${env:LOCALAPPDATA}/Programs/Microsoft VS Code/Code.exe")) {
  Install_msg("$ID")
  winget install -e --id "$ID" --source winget  --override "/silent /mergetasks=""addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"""
}
br(2)


Write_Title("# Visual Studio Code Insiders")
$ID = "Microsoft.VisualStudioCode.Insiders"
If (Test-Path  "${env:LOCALAPPDATA}/Programs/Microsoft VS Code Insiders/Code - Insiders.exe") {
  code-insiders --version
  Update_msg("$ID")
}
ElseIf (-not(Test-Path  "${env:LOCALAPPDATA}/Programs/Microsoft VS Code Insiders/Code - Insiders.exe")) {
  Install_msg("$ID")
  winget install -e --id "$ID" --source winget --override "/silent /mergetasks=""addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"""
}
br(2)


Write_Title("# PowerToys")
$ID = "Microsoft.PowerToys"
If (Test-Path "${env:PROGRAMFILES}/PowerToys/PowerToys.exe") {
  Update_msg("$ID")
}
ElseIf (-not(Test-Path "${env:PROGRAMFILES}/PowerToys/PowerToys.exe")) {
  Install_msg("$ID")
  winget install -e --id "$ID" --source winget
}
br(2)


<#
Write_Title("# Kite")
$ID = "kite.kite"
If (Test-Path "${env:PROGRAMFILES}/PowerToys/PowerToys.exe") {
  Update_msg("$ID")
}
ElseIf (-not(Test-Path "${env:PROGRAMFILES}/PowerToys/PowerToys.exe")) {
  Install_msg("$ID")
  winget install -e --id "$ID" --source winget
}
br(2)
#>


Write_Title("# PowerShellCore (pwsh)")
$ID = "Microsoft.PowerShell"
If (Test-Path  "${env:PROGRAMFILES}/PowerShell/7/pwsh.exe") {
  Update_msg("$ID")
}
ElseIf (-not(Test-Path  "${env:PROGRAMFILES}/PowerShell/7/pwsh.exe")) {
  Install_msg("$ID")
  winget install -ei --id "$ID" --source winget
}
br(1)


Write_Section("# winget/install.ps1 has finished.")
br(2)
