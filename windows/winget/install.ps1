. "${PSScriptRoot}/../Function.ps1"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

function _Winget_Version() {
  if (-Not (Get-Command("winget.exe"))) {
		Write-Error -Message "winget.exe is not installed." -ErrorAction Stop
		return 1603
	}

  ${bit} = "null"
  if (${env:PROCESSOR_ARCHITECTURE} -ceq "AMD64" -or "X64" -or "IA64" -or "ARM64") {
    ${bit} = "x64"
  }
  elseIf (${env:PROCESSOR_ARCHITECTURE} -ceq "X86") {
    ${bit} = "x86"
  }
  _Write_Title("# Install the $bit version.")

  [System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "winget.exe" `
		-ArgumentList "--version" `
		-NoNewWindow `
		-PassThru `
		-Wait
    _br(1)

  [System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "winget.exe" `
		-ArgumentList "--info" `
		-NoNewWindow `
		-PassThru `
		-Wait
    _br(1)

  [System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "winget.exe" `
		-ArgumentList "source update" `
		-NoNewWindow `
		-PassThru `
		-Wait
    _br(1)
  Return ${bit}
  _br(2)
}

#参考:https://zenn.dev/sha256/articles/44a6e2f4c7b89f
function _Title([string] ${ID}) {
  _Write_Title("# " + ${ID})
  _br(1)

  if ([string]::IsNullOrEmpty(${id})) {
		Write-Error -Message "Invalid id"
		return 1603
	}

	# Require "-PassThru" option to get ExitCode
	[System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "winget.exe" `
		-ArgumentList "show -e --id ${id}" `
		-NoNewWindow `
		-PassThru `
		-Wait
  _br(1)
  if (${process}.ExitCode -eq 0) {
    Return ${ID}
  }
	else {
    return 1603
  }
  _br(2)
}

#参考:https://zenn.dev/sha256/articles/44a6e2f4c7b89f
function _Install([string] ${ID},[string] ${options}) {
  Write-Host "  インストールを開始します." -ForegroundColor Yellow
  Write-Host "  Start the installation of this application." -ForegroundColor Yellow
  _br(1)

  if ([string]::IsNullOrEmpty(${id})) {
		Write-Error -Message "Invalid id"
		return 1603
	}

  if ([string]::IsNullOrEmpty(${options})) {
		Write-Error -Message "Invalid options"
		return 1603
	}

	# Require "-PassThru" option to get ExitCode
	[System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "winget.exe" `
		-ArgumentList "install -e --id ${id} ${options}" `
		-NoNewWindow `
		-PassThru `
		-Wait
  _br(1)
	return ${process}.ExitCode
  _br(2)
}

#参考:https://zenn.dev/sha256/articles/44a6e2f4c7b89f
function _Install([string] ${ID}) {
  Write-Host "  インストールを開始します." -ForegroundColor Yellow
  Write-Host "  Start the installation of this application." -ForegroundColor Yellow
  _br(1)

  if ([string]::IsNullOrEmpty(${id})) {
		Write-Error -Message "Invalid id"
		return 1603
	}

	# Require "-PassThru" option to get ExitCode
	[System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "winget.exe" `
		-ArgumentList "install -e --id ${id}" `
		-NoNewWindow `
		-PassThru `
		-Wait
  _br(1)
	return ${process}.ExitCode
  _br(2)
}

#参考:https://zenn.dev/sha256/articles/44a6e2f4c7b89f
function  _Update(${ID}) {
  Write-Host "  インストール済みです. アップデートを行います." -ForegroundColor Cyan
  Write-Host "  This application is already installed. Update the pwsh." -ForegroundColor Cyan
  _br(1)

  if ([string]::IsNullOrEmpty(${id})) {
		Write-Error -Message "Invalid id"
		return 1603
	}

	# Require "-PassThru" option to get ExitCode
	[System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "winget.exe" `
		-ArgumentList "upgrade -e --id ${id}" `
		-NoNewWindow `
		-PassThru `
		-Wait
    _br(1)
	return ${process}.ExitCode
  _br(2)
}


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("winget/install.ps1")
${bit} = _Winget_Version
${MyPath} = Split-Path -Parent $MyInvocation.MyCommand.Path


${ID} = _Title("Git.Git")
if(${ID} -ne 1603){
  if (Test-Path "${env:PROGRAMFILES}/Git/bin/git.exe") {
    git --version
    &"${env:GIT_INSTALL_ROOT}/git-bash.exe" "${MyPath}/kill_gpg-agent.sh"
    _br(1)
    _Update(${ID})
    [System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "git.exe" `
		-ArgumentList "update-git-for-windows" `
		-NoNewWindow `
		-PassThru `
		-Wait
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("Microsoft.OneDrive")
if(${ID} -ne 1603){
  if ((Test-Path "${env:LOCALAPPDATA}/Microsoft/OneDrive/OneDrive.exe") -or (Test-Path "${env:PROGRAMFILES}/Microsoft OneDrive/OneDrive.exe")){
    _Update(${ID})
  }
elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("Google.Drive")
if(${ID} -ne 1603){
  if (Test-Path  "${env:PROGRAMFILES}/Google/Drive File Stream/launch.bat") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("7zip.7zip")
if(${ID} -ne 1603){
  if(Test-Path "${env:PROGRAMFILES}/7-Zip/7z.exe") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("Mp3tag.Mp3tag")
if(${ID} -ne 1603){
  if(Test-Path "${env:PROGRAMFILES(x86)}/Mp3tag/Mp3tag.exe"){
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("Microsoft.PowerToys")
if(${ID} -ne 1603){
  if (Test-Path "${env:PROGRAMFILES}/PowerToys/PowerToys.exe") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("SlackTechnologies.Slack")
if(${ID} -ne 1603){
  if (Test-Path  "${env:LOCALAPPDATA}/slack/slack.exe") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("Notion.Notion")
if(${ID} -ne 1603){
  if (Test-Path  "${env:LOCALAPPDATA}/Programs/Notion/Notion.exe") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


<#
${ID} = _Title("ScreamingFrog.SEOSpider")
if(${ID} -ne 1603){
  if (Test-Path  "${env:PROGRAMFILES}/") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)
#>


${ID} = _Title("Google.Chrome")
if(${ID} -ne 1603){
  if (Test-Path  "${env:PROGRAMFILES}/Google/Chrome/Application/chrome.exe") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("REALiX.HWiNFO")
if(${ID} -ne 1603){
  if(Test-Path "${env:PROGRAMFILES}/HWiNFO64/HWiNFO64.EXE") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("Amazon.Kindle")
if(${ID} -ne 1603){
  if (Test-Path "${env:LOCALAPPDATA}/Amazon/Kindle/application/Kindle.exe") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("Microsoft.WindowsTerminal.Preview")
if(${ID} -ne 1603){
  if (Test-Path "${env:LOCALAPPDATA}/Microsoft/WindowsApps/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/wt.exe") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("Microsoft.VisualStudio.2019.BuildTools")
if(${ID} -ne 1603){
  if (Test-Path "${env:PROGRAMFILES(X86)}/Microsoft Visual Studio/2019/BuildTools") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
  _Write_Title("Visual Studio Installerから'C++ Build Tools'をダウンロードしてください.")
  _Write_Title("Download the 'C++ Build Tools' from Visual Studio Installer.")
}
else{
  _br(1)
}

_br(2)


${ID} = _Title("Microsoft.VisualStudioCode")
if(${ID} -ne 1603){
  if (Test-Path "${env:LOCALAPPDATA}/Programs/Microsoft VS Code/Code.exe") {
    code --version
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID},"--override `"/VERYSILENT /NORESTART /MERGETASKS=runcode,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath`"")
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("Microsoft.VisualStudioCode.Insiders")
if(${ID} -ne 1603){
  if (Test-Path  "${env:LOCALAPPDATA}/Programs/Microsoft VS Code Insiders/Code - Insiders.exe") {
    code-insiders --version
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID},"--override `"/VERYSILENT /NORESTART /MERGETASKS=runcode,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath`"")
  }
}
else{
  _br(1)
}
_br(2)


<#
${ID} = _Title("PeterPawlowski.foobar2000")
if(${ID} -ne 1603){
  if (Test-Path  "${env:LOCALAPPDATA}/") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)
#>


${ID} = _Title("Discord.Discord")
if(${ID} -ne 1603){
  if (Test-Path  "${env:LOCALAPPDATA}/Discord/app.ico") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("TeamSpeakSystems.TeamSpeakClient")
if(${ID} -ne 1603){
  if (Test-Path  "${env:PROGRAMFILES}/TeamSpeak 3 Client/ts3client_win64.exe") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("Valve.Steam")
if(${ID} -ne 1603){
  if (Test-Path  "${env:PROGRAMFILES(X86)}/Steam/Steam.exe") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("ElectronicArts.EADesktop")
if(${ID} -ne 1603){
  if (Test-Path  "${env:PROGRAMFILES}/Electronic Arts/EA Desktop/EA Desktop/EALauncher.exe") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("SteelSeries.GG")
if(${ID} -ne 1603){
  if (Test-Path  "${env:PROGRAMFILES}/SteelSeries/GG/SteelSeriesGG.exe") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("Corsair.iCUE.4")
if(${ID} -ne 1603){
  if (test-path  "${env:PROGRAMFILES}/Corsair/CORSAIR iCUE 4 Software/iCUE.exe") {
    _Update(${ID})
  }
  elseif(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("Apple.iTunes")
if(${ID} -ne 1603){
  if (test-path  "${env:PROGRAMFILES}/iTunes/iTunes.exe") {
    _Update(${ID})
  }
  elseif(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


if ($bit -eq "x64") { ${ID} = _Title("Adobe.Acrobat.Reader.64-bit") }
else{ ${ID} = _Title("Adobe.Acrobat.Reader.32-bit") }
if(${ID} -ne 1603){
  if ((Test-Path  "${env:PROGRAMFILES}/Adobe/Acrobat DC/Acrobat/Acrobat.exe") -or (Test-Path  "${env:PROGRAMFILES(X86)}/Adobe/Acrobat Reader DC/Reader/AcroRd32.exe")) {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("OpenMedia.4KVideoDownloader")
if(${ID} -ne 1603){
  if (Test-Path "${env:PROGRAMFILES}/4KDownload/4kvideodownloader/4kvideodownloader.exe") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("DeepL.DeepL")
if(${ID} -ne 1603){
  if (Test-Path "${env:LOCALAPPDATA}/DeepL/DeepL.exe") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


<#
${ID} = _Title("kite.kite")
if(${ID} -ne 1603){
  If (Test-Path "${env:PROGRAMFILES}/") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {else {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)
#>


${ID} = _Title("TranslucentTB.TranslucentTB")
if(${ID} -ne 1603){
  if (Test-Path  "${env:PROGRAMFILES(X86)}/TranslucentTB/TranslucentTB.exe") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("WiresharkFoundation.Wireshark")
if(${ID} -ne 1603){
  if (Test-Path  "${env:PROGRAMFILES}/Wireshark/Wireshark.exe") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


${ID} = _Title("Microsoft.PowerShell")
if(${ID} -ne 1603){
  if (Test-Path  "${env:PROGRAMFILES}/PowerShell/7/pwsh.exe") {
    _Update(${ID})
  }
  elseIf(_Want_To_Install(${ID})) {
    _Install(${ID})
  }
}
else{
  _br(1)
}
_br(2)


_Set_ExecutionPolicy
_br(2)

_Write_Section("# winget/install.ps1 has finished.")
_br(2)

