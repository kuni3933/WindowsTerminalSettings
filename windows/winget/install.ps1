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
if (${env:PROCESSOR_ARCHITECTURE} -ceq "AMD64" -or "X64" -or "IA64" -or "ARM64") {
  $bit = "x64"
}
elseIf (${env:PROCESSOR_ARCHITECTURE} -ceq "X86") {
  $bit = "x86"
}
$msg = "# Install the $bit version."
Write_Title($msg)
winget --Version
winget --info
winget  source update
br(2)


$ID = "Git.Git"
Write_Title("# " + $ID)
if (Test-Path "${env:PROGRAMFILES}/Git/bin/git.exe") {
  git --version
  &"$env:GIT_INSTALL_ROOT/git-bash.exe" "$MyPath/kill_gpg-agent.sh"
  br(1)
  Update_msg("$ID")
  git update-git-for-windows
}
else {
  Install_msg("$ID")
  winget install -e --id "$ID" --source winget
}
br(2)


$ID = "Microsoft.WindowsTerminal.Preview"
Write_Title("# " + $ID)
if (Test-Path "${env:LOCALAPPDATA}/Microsoft/WindowsApps/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/wt.exe") {
  Update_msg("$ID")
}
else {
  Install_msg("$ID")
  winget install -e --id "$ID" --source winget
}
br(2)


$ID = "Microsoft.VisualStudio.2019.BuildTools"
Write_Title("# " + $ID)
if (Test-Path "${env:PROGRAMFILES(X86)}/Microsoft Visual Studio/2019/BuildTools") {
  Update_msg("$ID")
}
else {
  Install_msg("$ID")
  winget install -e --id "$ID" --source winget
}
Write_Title("Visual Studio Installerから'C++ Build Tools'をダウンロードしてください.")
Write_Title("Download the 'C++ Build Tools' from Visual Studio Installer.")
br(2)


$ID = "Microsoft.VisualStudioCode"
Write_Title("# " + $ID)
if (Test-Path "${env:LOCALAPPDATA}/Programs/Microsoft VS Code/Code.exe") {
  code --version
  Update_msg("$ID")
}
else {
  Install_msg("$ID")
  winget install -e --id "$ID" --source winget  --override "/silent /mergetasks=""addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"""
}
br(2)


$ID = "Microsoft.VisualStudioCode.Insiders"
Write_Title("# " + $ID)
if (Test-Path  "${env:LOCALAPPDATA}/Programs/Microsoft VS Code Insiders/Code - Insiders.exe") {
  code-insiders --version
  Update_msg("$ID")
}
else {
  Install_msg("$ID")
  winget install -e --id "$ID" --source winget --override "/silent /mergetasks=""addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"""
}
br(2)


$ID = "Microsoft.PowerToys"
Write_Title("# " + $ID)
if (Test-Path "${env:PROGRAMFILES}/PowerToys/PowerToys.exe") {
  Update_msg("$ID")
}
else {
  Install_msg("$ID")
  winget install -e --id "$ID" --source winget
}
br(2)


<#
$ID = "kite.kite"
Write_Title("# " + $ID)
If (Test-Path "${env:PROGRAMFILES}/PowerToys/PowerToys.exe") {
  Update_msg("$ID")
}
else {
  Install_msg("$ID")
  winget install -e --id "$ID" --source winget
}
br(2)
#>


$ID = "SlackTechnologies.Slack"
Write_Title("# " + $ID)
if (Test-Path  "${env:LOCALAPPDATA}/slack/slack.exe") {
  Update_msg("$ID")
}
else {
  Install_msg("$ID")
  winget install -e --id "$ID" --source winget
}
br(1)


$ID = "Notion.Notion"
Write_Title("# " + $ID)
if (Test-Path  "${env:LOCALAPPDATA}/Programs/Notion/Notion.exe") {
  Update_msg("$ID")
}
else {
  Install_msg("$ID")
  winget install -e --id "$ID" --source winget
}
br(1)


Write_Title("# PowerShellCore (pwsh)")
$ID = "Microsoft.PowerShell"
if (Test-Path  "${env:PROGRAMFILES}/PowerShell/7/pwsh.exe") {
  Update_msg("$ID")
}
else {
  Install_msg("$ID")
  winget install -ei --id "$ID" --source winget
}
br(1)


Write_Section("# winget/install.ps1 has finished.")
br(2)
