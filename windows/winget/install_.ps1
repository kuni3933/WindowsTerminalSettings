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
		Write-Error -Message "ID is null or empty."
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
$data = (Get-Content "${MyPath}/install.json" | ConvertFrom-Json)

foreach (${index} in ${data}) {
    ${ID} = ${index}."ID"
    ${Path} = ${index}."Path"
    ${Install_Options} = ${index}."Install_Options"
    ${Update_Options} = ${index}."Update_Options"
    ${Message} = ${index}."Message"
    ${Flag} =  ${index}."Flag"

  if((_Title(${ID}) -ne 1603) -and ((${Flag} -eq "true") -or (${Flag} -eq ${bit}))) {
    if(Test-Path "${Path}"){
      Write-Host(${Path})
      & "${Update_Options}"
      _br(1)
      _Update(${ID})
    }elseIf(_Want_To_Install(${ID})) {
      _Install(${ID})
    }
  }else{
    Write-Host("Either the architecture is different or Flag is False.")
  }
  _br(2)
}


