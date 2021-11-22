. "./../Function.ps1"

function Winget_Version() {
    $bit = "null"
    if (${env:PROCESSOR_ARCHITECTURE} -ceq "AMD64" -or "X64" -or "IA64" -or "ARM64") {
      $bit = "x64"
    }
    elseIf (${env:PROCESSOR_ARCHITECTURE} -ceq "X86") {
      $bit = "x86"
    }
    Write_Title("# Install the $bit version.")
    winget --Version
    br(1)
    winget --info
    br(1)
    winget  source update
    br(2)
    Return $bit
}

function Title($ID) {
    Write_Title("# " + $ID)
    Return $ID
}

function Install_msg($ID) {
    Write-Host "  インストールを開始します." -ForegroundColor Yellow
    Write-Host "  Start the installation of this application." -ForegroundColor Yellow
    br(1)
    winget show --id "$ID" --source winget
    br(1)
}

function  Update($ID) {
    Write-Host "  インストール済みです. アップデートを行います." -ForegroundColor Cyan
    Write-Host "  This application is already installed. Update the pwsh." -ForegroundColor Cyan
    br(1)
    winget show -e --id "$ID" --source winget
    br(1)
    winget upgrade -e --id "$ID" --source winget
}


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Write_Section("winget/install.ps1")

$bit = Winget_Version
$MyPath = Split-Path -Parent $MyInvocation.MyCommand.Path

$ID = Title("Git.Git")
if (Test-Path "${env:PROGRAMFILES}/Git/bin/git.exe") {
    git --version
    &"$env:GIT_INSTALL_ROOT/git-bash.exe" "$MyPath/kill_gpg-agent.sh"
    br(1)
    Update($ID)
    git update-git-for-windows
}
else {
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget
}
br(2)


$ID = Title("Microsoft.OneDrive")
if (Test-Path  "${env:PROGRAMFILES}/Microsoft OneDrive/OneDrive.exe") {
    Update($ID)
}
else {
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget
}
br(2)


$ID = Title("Google.Drive")
if (Test-Path  "${env:PROGRAMFILES}/Google/Drive File Stream/launch.bat") {
    Update($ID)
}
else {
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget
}
br(2)


$ID = Title("7zip.7zip")
if(Test-Path "${env:PROGRAMFILES}/7-Zip/7z.exe") {
    Update($ID)
}
else{
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget
}
br(2)


$ID = Title("Mp3tag.Mp3tag")
if(Test-Path "${env:PROGRAMFILES(x86)}/Mp3tag/Mp3tag.exe"){
    Update($ID)
}
else{
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget
}
br(2)


$ID = Title("Microsoft.PowerToys")
if (Test-Path "${env:PROGRAMFILES}/PowerToys/PowerToys.exe") {
    Update($ID)
}
else {
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget
}
br(2)


$ID = Title("SlackTechnologies.Slack")
if (Test-Path  "${env:LOCALAPPDATA}/slack/slack.exe") {
    Update($ID)
}
else {
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget
}
br(2)


$ID = Title("Notion.Notion")
if (Test-Path  "${env:LOCALAPPDATA}/Programs/Notion/Notion.exe") {
    Update($ID)
}
else {
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget
}
br(2)


<#
$ID = Title("ScreamingFrog.SEOSpider")
if (Test-Path  "${env:PROGRAMFILES}/") {
    Update($ID)
}
else {
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget
}
br(2)
#>


$ID = Title("Google.Chrome")
if (Test-Path  "${env:PROGRAMFILES(X86)}/Google/Chrome/Application/chrome.exe") {
    Update($ID)
}
else {
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget
}
br(2)


$ID =  Title("REALiX.HWiNFO")
if(Test-Path "${env:PROGRAMFILES}/HWiNFO64/HWiNFO64.EXE") {
    Update($ID)
}
else{
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget
}
br(2)

#$ID =Title("PeterPawlowski.foobar2000")

$ID =  Title("Amazon.Kindle")
if (Test-Path "${env:LOCALAPPDATA}/Amazon/Kindle/application/Kindle.exe") {
    Update($ID)
}
else {
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget
}
br(2)


$ID =  Title("Microsoft.WindowsTerminal.Preview")
if (Test-Path "${env:LOCALAPPDATA}/Microsoft/WindowsApps/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/wt.exe") {
    Update($ID)
}
else {
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget
}
br(2)


$ID =  Title("Microsoft.VisualStudio.2019.BuildTools")
if (Test-Path "${env:PROGRAMFILES(X86)}/Microsoft Visual Studio/2019/BuildTools") {
    Update($ID)
}
else {
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget
}
Write_Title("Visual Studio Installerから'C++ Build Tools'をダウンロードしてください.")
Write_Title("Download the 'C++ Build Tools' from Visual Studio Installer.")
br(2)


$ID =  Title("Microsoft.VisualStudioCode")
if (Test-Path "${env:LOCALAPPDATA}/Programs/Microsoft VS Code/Code.exe") {
    code --version
    Update($ID)
}
else {
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget  --override "/silent /mergetasks="runcode"addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"""
}
br(2)


$ID =  Title("Microsoft.VisualStudioCode.Insiders")
if (Test-Path  "${env:LOCALAPPDATA}/Programs/Microsoft VS Code Insiders/Code - Insiders.exe") {
  code-insiders --version
    Update($ID)
}
else {
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget --override "/silent /mergetasks="runcode"addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"""
}
br(2)


$ID = Title("Discord.Discord")
if (Test-Path  "${env:LOCALAPPDATA}/Discord/app.ico") {
    Update($ID)
}
else {
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget
}
br(2)


$ID =  Title("TeamSpeakSystems.TeamSpeakClient")
if (Test-Path  "${env:PROGRAMFILES}/TeamSpeak 3 Client/ts3client_win64.exe") {
    Update($ID)
}
else {
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget
}
br(2)


if ($bit -eq "x64") { $ID =  Title("Adobe.Acrobat.Reader.64-bit") }
else{ $ID =  Title("Adobe.Acrobat.Reader.32-bit") }
if ((Test-Path  "${env:PROGRAMFILES}/Adobe/Acrobat DC/Acrobat/Acrobat.exe") -or (Test-Path  "${env:PROGRAMFILES(X86)}/Adobe/Acrobat Reader DC/Reader/AcroRd32.exe")) {
    Update($ID)
}
else {
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget
}
br(2)


$ID =  Title("OpenMedia.4KVideoDownloader")
if (Test-Path "${env:PROGRAMFILES}/4KDownload/4kvideodownloader/4kvideodownloader.exe") {
    Update($ID)
}
else {
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget
}
br(2)


$ID =  Title("DeepL.DeepL")
if (Test-Path "${env:LOCALAPPDATA}/DeepL/DeepL.exe") {
    Update($ID)
}
else {
    Install_msg("$ID")
    winget install -e --id "$ID" --source winget
}
br(2)


<#
$ID =  Title("kite.kite")
If (Test-Path "${env:PROGRAMFILES}/PowerToys/PowerToys.exe") {
  Update($ID)
}
else {
  Install_msg("$ID")
  winget install -e --id "$ID" --source winget
}
br(2)
#>


$ID =  Title("Microsoft.PowerShell")
if (Test-Path  "${env:PROGRAMFILES}/PowerShell/7/pwsh.exe") {
    Update($ID)
}
else {
    Install_msg("$ID")
    winget install -ei --id "$ID" --source winget
}
br(2)


Write_Section("# winget/install.ps1 has finished.")
br(2)
