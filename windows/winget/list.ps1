. "${PSScriptRoot}/../Function.ps1"

${MyPath} = Split-Path -Parent $MyInvocation.MyCommand.Path
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if (!(Get-Command("winget.exe") -ErrorAction SilentlyContinue)) {
  Write-Error -Message "winget.exe is not installed." -ErrorAction Stop
  return 1603
}

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function _Winget_Version() {
  [string]${bit} = "0"
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
    -RedirectStandardOutput "${MyPath}/winget_log.txt" `
    -NoNewWindow `
    -PassThru `
    -Wait

    Return ${bit}
}

#参考:https://zenn.dev/sha256/articles/44a6e2f4c7b89f
function _Title([string]${Name},[string] ${ID}) {
  if ([string]::IsNullOrEmpty(${Name})) {
		Write-Error -Message "Name is null or empty."
		return 1603
	}
  if ([string]::IsNullOrEmpty(${ID})) {
		Write-Error -Message "ID is null or empty."
		return 1603
	}
  _Write_Title("# " + ${Name})

	# Require "-PassThru" option to get ExitCode
	[System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "winget.exe" `
		-ArgumentList "show -e --id ${ID}" `
		-NoNewWindow `
		-PassThru `
		-Wait

  return ${process}.ExitCode
}


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("winget/list.ps1")
[string] ${bit} = _Winget_Version
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
  [string] ${Flag} = ${index}."Flag"

  Write-Host($(Write-Host("${Name} ") -NoNewline -ForegroundColor DarkCyan) + $(Write-Host("[") -NoNewline) + $(Write-Host("${ID}") -NoNewline -ForegroundColor Green) + $(Write-Host("]") -NoNewline))
  #Write-Host(${Name})
  #Write-Host(${ID})
  #Write-Host("Flag: ${Flag}")
  #_br(1)
  ${Count} += 1
}

_br(1)
Write-Host("Count: ${Count}")

_br(1)
_Set_ExecutionPolicy


_br(2)
_Write_Section("# winget/list.ps1 has finished.")
_br(2)
