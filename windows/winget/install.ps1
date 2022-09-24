. "${PSScriptRoot}/../Function.ps1"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

function _Winget_Version([string]${Path}) {
  if (-Not (Get-Command("winget.exe") -ErrorAction SilentlyContinue)) {
		Write-Error -Message "winget.exe is not installed." -ErrorAction Stop
		return 1603
	}

  [string] ${bit} = "0"
  if (${env:PROCESSOR_ARCHITECTURE} -ieq "AMD64" -or "X64") {
    ${bit} = "x64"
  }elseIf (${env:PROCESSOR_ARCHITECTURE} -ieq "X86") {
    ${bit} = "x86"
  }elseIf (${env:PROCESSOR_ARCHITECTURE} -ieq "IA64") {
    ${bit} = "IA64"
  }elseIf (${env:PROCESSOR_ARCHITECTURE} -ieq "ARM64") {
    ${bit} = "ARM64"
  }
  _Write_Title("# Install the ${bit} version.")

  [System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "winget.exe" `
		-ArgumentList "--version" `
		-NoNewWindow `
		-PassThru `
		-Wait

  [System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "winget.exe" `
		-ArgumentList "--info" `
		-NoNewWindow `
		-PassThru `
		-Wait

  [System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "winget.exe" `
		-ArgumentList "source update" `
		-NoNewWindow `
		-PassThru `
		-Wait

  [System.Diagnostics.Process] ${process} = Start-Process `
    -FilePath "winget.exe" `
    -ArgumentList "list" `
    -RedirectStandardOutput "${Path}" `
    -NoNewWindow `
    -PassThru `
    -Wait

    Return ${bit}
}

#参考:https://zenn.dev/sha256/articles/44a6e2f4c7b89f
function _Title([string]${Name},[string] ${ID}) {
  if ([string]::IsNullOrEmpty(${Name})) {
		Write-Error -Message "[Name] is null or empty."
		return 1603
	}
  if ([string]::IsNullOrEmpty(${ID})) {
		Write-Error -Message "[ID] is null or empty."
		return 1603
	}
  _Write_Title("# " + "${Name} [${ID}]")

	# Require "-PassThru" option to get ExitCode
	[System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "winget.exe" `
		-ArgumentList "show -e --id ${ID}" `
		-NoNewWindow `
		-PassThru `
		-Wait

  return ${process}.ExitCode
}

#参考:https://zenn.dev/sha256/articles/44a6e2f4c7b89f
function _Install([string] ${ID},[string] ${Options}) {
  _br(1)
  Write-Host "  インストールを開始します." -ForegroundColor Yellow
  Write-Host "  Start the installation of this application." -ForegroundColor Yellow
  _br(1)

  if ([string]::IsNullOrEmpty(${ID})) {
		Write-Error -Message "Invalid [ID]"
		return 1603
	}

  if ([string]::IsNullOrEmpty(${Options})) {
		Write-Error -Message "Invalid [Install_Options]"
		return 1603
	}

	# Require "-PassThru" option to get ExitCode
	[System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "winget.exe" `
		-ArgumentList "install -e --id ${ID} ${Options}" `
		-NoNewWindow `
		-PassThru `
		-Wait

	return ${process}.ExitCode
}

#参考:https://zenn.dev/sha256/articles/44a6e2f4c7b89f
function  _Update([string] ${ID},[string] ${Options}) {
  _br(1)
  Write-Host "  インストール済みです. アップデートを行います." -ForegroundColor Cyan
  Write-Host "  This application is already installed. Start the updating of this application." -ForegroundColor Cyan
  _br(1)

  if ([string]::IsNullOrEmpty(${ID})) {
		Write-Error -Message "Invalid [ID]"
		return 1603
	}
  if ([string]::IsNullOrEmpty(${Options})) {
		Write-Error -Message "Invalid [Update_Options]"
		return 1603
	}

	# Require "-PassThru" option to get ExitCode
	[System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "winget.exe" `
		-ArgumentList "upgrade -e --id ${ID} ${Options}" `
		-NoNewWindow `
		-PassThru `
		-Wait

	return ${process}.ExitCode
}


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("winget/install.ps1")
${MyPath} = Split-Path -Parent $MyInvocation.MyCommand.Path
${LogFilePath} = "${MyPath}/winget_log.txt"
[string] ${bit} = _Winget_Version("${LogFilePath}")
_br(2)

${json} = $null
if(Test-Path "${MyPath}/PKGLIST.json"){
  ${json} = (Get-Content "${MyPath}/PKGLIST.json" | ConvertFrom-Json)
}else{
  Write-Error -Message "PKGLIST.json is not found." -ErrorAction Stop
		return 1603
}

[int] ${Count} = 0

foreach (${index} in ${json}."data") {
  [string] ${Name} = ${index}."Name"
  [string] ${ID} = ${index}."ID"
  [string] ${Flag} =  ${index}."Flag"
  [string] ${Install_Options} = ${index}."Install_Options"
  [string] ${Update_Options} = ${index}."Update_Options"
  [string[]] ${ArrayMessages} = ${index}."Message"

  if(((_Title ${Name} ${ID}) -eq 0) -and ((${Flag} -eq "1") -or (${Flag} -ieq "${bit}_1"))){
    if(Select-String "${LogFilePath}" -Pattern "\s${ID}\s" -CaseSensitive){
      if(Test-Path "${MyPath}/${ID}.ps1"){ & "${MyPath}/${ID}.ps1" }
      if(${Update_Options} -eq ""){ ${Update_Options} = " " }
      _Update ${ID} ${Update_Options}
    }elseIf(_Want_To_Install("${Name} [${ID}]")) {
      if(${Install_Options} -eq ""){ ${Install_Options} = " " }
      _Install ${ID} ${Install_Options}
    }
    _br(1)
    foreach(${MessageIndex} in ${ArrayMessages}) {
      Write-Host("  ${MessageIndex}") -ForegroundColor Green
    }
    _br(1)
  }else{
    _br(1)
    Write-Host("  Error:Either the [ID] is different, the [ISA] is different, or [Flag] is False.") -ForegroundColor Red
    _br(1)
  }
  ${Count} += 1
  _br(2)
}

Write-Host("Count: ${Count}")
_br(2)
_Set_ExecutionPolicy
_br(2)

_Write_Section("# winget/install.ps1 has finished.")
_br(2)
