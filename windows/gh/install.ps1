. "${PSScriptRoot}/../Function.ps1"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

function _Gh_Version([string]${Path}) {
  if (-Not (Get-Command("gh.exe") -ErrorAction SilentlyContinue)) {
		Write-Error -Message "gh.exe is not installed." -ErrorAction Stop
		return 1603
	}

  [System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "gh.exe" `
		-ArgumentList "--version" `
		-NoNewWindow `
		-PassThru `
		-Wait

    _br(1)

    [System.Diagnostics.Process] ${process} = Start-Process `
    -FilePath "gh.exe" `
    -ArgumentList "extension upgrade --all" `
    -NoNewWindow `
    -PassThru `
    -Wait

    [System.Diagnostics.Process] ${process} = Start-Process `
    -FilePath "gh.exe" `
    -ArgumentList "extension list" `
    -RedirectStandardOutput "${Path}" `
    -NoNewWindow `
    -PassThru `
    -Wait
}

function _Title([string]${Name}) {
  if ([string]::IsNullOrEmpty(${Name})) {
		Write-Error -Message "[Name] is null or empty."
		return 1603
	}
  _Write_Title("# " + "${Name}")
  Write-Host "URL: https://github.com/${Name}"
}

function _Install([string] ${Name}) {
  _br(1)
  Write-Host "  インストールを開始します." -ForegroundColor Yellow
  Write-Host "  Start the installation of this gh_extension." -ForegroundColor Yellow
  _br(1)

  [System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "gh.exe" `
		-ArgumentList "extension install ${Name}" `
		-NoNewWindow `
		-PassThru `
		-Wait

  if (${process}.ExitCode -eq 0) {
    Write-Host("0")
    _br(1)
    #Return 0
  }
  elseif(${process}.ExitCode -eq 1){
    Write-Host("1")
    _br(1)
    #Return 1
  }
	else {
    Write-Host("1603")
    _br(1)
    #return 1603
  }
}

function _Update([string] ${Name}) {
  _br(1)
  Write-Host "  インストール済みです. アップデートを行います." -ForegroundColor Cyan
  Write-Host "  This gh_extension is already installed. Start the updating of this gh_extension." -ForegroundColor Cyan
  _br(1)

  [System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "gh.exe" `
		-ArgumentList "extension upgrade ${Name}" `
		-NoNewWindow `
		-PassThru `
		-Wait

  if (${process}.ExitCode -eq 0) {
    Write-Host("0")
    _br(1)
    #Return 0
  }
  elseif(${process}.ExitCode -eq 1){
    Write-Host("1")
    _br(1)
    #Return 1
  }
	else {
    Write-Host("1603")
    _br(1)
    #return 1603
  }
}

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("gh/install.ps1")
${MyPath} = Split-Path -Parent $MyInvocation.MyCommand.Path
${LogFilePath} = "${MyPath}/gh_log.txt"
_Gh_Version("${LogFilePath}")
_br(2)

if(Test-Path "${MyPath}/PKGLIST.json"){
  ${data} = (Get-Content "${MyPath}/PKGLIST.json" | ConvertFrom-Json)
}else{
  Write-Error -Message "PKGLIST.json is not found." -ErrorAction Stop
		return 1603
}

[int] ${Count} = 0

foreach (${index} in ${data}) {
  [string] ${Name} = ${index}."Name"
  [string] ${Flag} =  ${index}."Flag"

  _Title ${Name}
  if(${Flag} -eq "1"){
    Write-Host ${LogFilePath}
    if(Select-String "${LogFilePath}" -Pattern "\s${Name}\s" -CaseSensitive){ _Update ${Name} }
    else{ _Install ${Name} }
  }
  else{
    _br(1)
    Write-Host("  Error:Either the [Name] is different or [Flag] is False.") -ForegroundColor Red
    _br(1)
  }
  ${Count} += 1
  _br(2)
}

Write-Host("Count: ${Count}")
_br(2)
_Set_ExecutionPolicy
_br(2)

_Write_Section("# gh/install.ps1 has finished.")
_br(2)

