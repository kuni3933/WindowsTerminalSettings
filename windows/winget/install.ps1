. "./../Function.ps1"

function _Winget_Version() {
    ${bit} = "null"
    if (${env:PROCESSOR_ARCHITECTURE} -ceq "AMD64" -or "X64" -or "IA64" -or "ARM64") {
      ${bit} = "x64"
    }
    elseIf (${env:PROCESSOR_ARCHITECTURE} -ceq "X86") {
      ${bit} = "x86"
    }
    _Write__Title("# Install the $bit version.")
    winget --Version
    _br(1)
    winget --info
    _br(1)
    winget  source update
    _br(2)
    Return ${bit}
}

function _Title(${ID}) {
    _Write__Title("# " + ${ID})
    Return ${ID}
}

function _Install_Msg(${ID}) {
    Write-Host "  インストールを開始します." -ForegroundColor Yellow
    Write-Host "  Start the installation of this application." -ForegroundColor Yellow
    _br(1)
    winget show --id "${ID}"
    _br(1)
}

function  _Update(${ID}) {
    Write-Host "  インストール済みです. アップデートを行います." -ForegroundColor Cyan
    Write-Host "  This application is already installed. Update the pwsh." -ForegroundColor Cyan
    _br(1)
    winget show -e --id "${ID}" --source winget
    _br(1)
    winget upgrade -e --id "${ID}" --source winget
}


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("winget/install.ps1")

${bit} = Winget_Version
${MyPath} = Split-Path -Parent $MyInvocation.MyCommand.Path

${ID} = _Title("Git.Git")
if (Test-Path "${env:PROGRAMFILES}/Git/bin/git.exe") {
    git --version
    &"${env:GIT_INSTALL_ROOT}/git-bash.exe" "${MyPath}/kill_gpg-agent.sh"
    _br(1)
    _Update(${ID})
    git update-git-for-windows
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("Microsoft.OneDrive")
if (Test-Path  "${env:LOCALAPPDATA}/Microsoft/OneDrive/OneDrive.exe") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("Google.Drive")
if (Test-Path  "${env:PROGRAMFILES}/Google/Drive File Stream/launch.bat") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("7zip.7zip")
if(Test-Path "${env:PROGRAMFILES}/7-Zip/7z.exe") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("Mp3tag.Mp3tag")
if(Test-Path "${env:PROGRAMFILES(x86)}/Mp3tag/Mp3tag.exe"){
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("Microsoft.PowerToys")
if (Test-Path "${env:PROGRAMFILES}/PowerToys/PowerToys.exe") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("SlackTechnologies.Slack")
if (Test-Path  "${env:LOCALAPPDATA}/slack/slack.exe") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("Notion.Notion")
if (Test-Path  "${env:LOCALAPPDATA}/Programs/Notion/Notion.exe") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


<#
${ID} = _Title("ScreamingFrog.SEOSpider")
if (Test-Path  "${env:PROGRAMFILES}/") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)
#>


${ID} = _Title("Google.Chrome")
if (Test-Path  "${env:PROGRAMFILES}/Google/Chrome/Application/chrome.exe") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("REALiX.HWiNFO")
if(Test-Path "${env:PROGRAMFILES}/HWiNFO64/HWiNFO64.EXE") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)

#${ID} =_Title("PeterPawlowski.foobar2000")

${ID} = _Title("Amazon.Kindle")
if (Test-Path "${env:LOCALAPPDATA}/Amazon/Kindle/application/Kindle.exe") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("Microsoft.WindowsTerminal.Preview")
if (Test-Path "${env:LOCALAPPDATA}/Microsoft/WindowsApps/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/wt.exe") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("Microsoft.VisualStudio.2019.BuildTools")
if (Test-Path "${env:PROGRAMFILES(X86)}/Microsoft Visual Studio/2019/BuildTools") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_Write__Title("Visual Studio Installerから'C++ Build Tools'をダウンロードしてください.")
_Write__Title("Download the 'C++ Build Tools' from Visual Studio Installer.")
_br(2)


${ID} = _Title("Microsoft.VisualStudioCode")
if (Test-Path "${env:LOCALAPPDATA}/Programs/Microsoft VS Code/Code.exe") {
    code --version
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget  --override "/VERYSILENT /NORESTART /MERGETASKS=runcode,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"
}
_br(2)


${ID} = _Title("Microsoft.VisualStudioCode.Insiders")
if (Test-Path  "${env:LOCALAPPDATA}/Programs/Microsoft VS Code Insiders/Code - Insiders.exe") {
  code-insiders --version
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget --override "/VERYSILENT /NORESTART /MERGETASKS=runcode,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"
}
_br(2)


<#
${ID} = _Title("PeterPawlowski.foobar2000")
if (Test-Path  "${env:LOCALAPPDATA}/") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)
#>


${ID} = _Title("Discord.Discord")
if (Test-Path  "${env:LOCALAPPDATA}/Discord/app.ico") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("TeamSpeakSystems.TeamSpeakClient")
if (Test-Path  "${env:PROGRAMFILES}/TeamSpeak 3 Client/ts3client_win64.exe") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("Valve.Steam")
if (Test-Path  "${env:PROGRAMFILES(X86)}/Steam/Steam.exe") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("ElectronicArts.EADesktop")
if (Test-Path  "${env:PROGRAMFILES}/Electronic Arts/EA Desktop/EA Desktop/EALauncher.exe") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("SteelSeries.GG")
if (Test-Path  "${env:PROGRAMFILES}/SteelSeries/GG/SteelSeriesGG.exe") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("Corsair.iCUE.4")
if (test-path  "${env:PROGRAMFILES}/Corsair/CORSAIR iCUE 4 Software/iCUE.exe") {
    _Update(${ID})
}
elseif(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("Apple.iTunes")
if (test-path  "${env:PROGRAMFILES}/iTunes/iTunes.exe") {
    _Update(${ID})
}
elseif(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


if ($bit -eq "x64") { ${ID} = _Title("Adobe.Acrobat.Reader.64-bit") }
else{ ${ID} = _Title("Adobe.Acrobat.Reader.32-bit") }
if ((Test-Path  "${env:PROGRAMFILES}/Adobe/Acrobat DC/Acrobat/Acrobat.exe") -or (Test-Path  "${env:PROGRAMFILES(X86)}/Adobe/Acrobat Reader DC/Reader/AcroRd32.exe")) {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("OpenMedia.4KVideoDownloader")
if (Test-Path "${env:PROGRAMFILES}/4KDownload/4kvideodownloader/4kvideodownloader.exe") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("DeepL.DeepL")
if (Test-Path "${env:LOCALAPPDATA}/DeepL/DeepL.exe") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -e --id "${ID}" --source winget
}
_br(2)


<#
${ID} = _Title("kite.kite")
If (Test-Path "${env:PROGRAMFILES}/") {
  _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {else {
  _Install_Msg(${ID})
  winget install -e --id "${ID}" --source winget
}
_br(2)
#>


${ID} = _Title("TranslucentTB.TranslucentTB")
if (Test-Path  "${env:PROGRAMFILES(X86)}/TranslucentTB/TranslucentTB.exe") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -ei --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("WiresharkFoundation.Wireshark")
if (Test-Path  "${env:PROGRAMFILES}/Wireshark/Wireshark.exe") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -ei --id "${ID}" --source winget
}
_br(2)


${ID} = _Title("Microsoft.PowerShell")
if (Test-Path  "${env:PROGRAMFILES}/PowerShell/7/pwsh.exe") {
    _Update(${ID})
}
elseIf(_Want_To_Install(${ID})) {
    _Install_Msg(${ID})
    winget install -ei --id "${ID}" --source winget
}
_br(2)


_Set_ExecutionPolicy
_br(2)

_Write_Section("# winget/install.ps1 has finished.")
_br(2)

