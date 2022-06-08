. "${PSScriptRoot}/../Function.ps1"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

if (-Not (Get-Command("pip"))) {
		Write-Error -Message "Python/pip is not installed." -ErrorAction Stop
		return 1603
}

${MyPath} = Split-Path -Parent $MyInvocation.MyCommand.Path
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("Python-pip/install.ps1")


_Write_Title("# CLI Tools")
pip install --upgrade --user `
  'glances[action,browser,cloud,cpuinfo,docker,export,folders,gpu,graph,ip,raid,snmp,web,wifi]' `
  'httpie'
_br(1)


_Write_Title("# pip cache list")
pip cache list
_br(1)

_Write_Title("# pip cache purge")
pip cache purge
_br(1)

_Write_Title("# pip cache list")
pip cache list
_br(1)

_Write_Title("# pip list")
pip list
pip list > "${MyPath}/pip_log.txt"
pip freeze > "${MyPath}/pip_freeze_log.txt"
_br(1)


_Set_ExecutionPolicy
_br(2)

_Write_Section("# Python-pip/install.ps1 has finished.")
_br(2)

