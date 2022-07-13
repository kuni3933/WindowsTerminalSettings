. "${PSScriptRoot}/../Function.ps1"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

if (-Not (Get-Command("volta.exe"))) {
	Write-Error -Message "volta.exe is not installed." -ErrorAction Stop
	return 1603
}

${MyPath} = Split-Path -Parent $MyInvocation.MyCommand.Path

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("volta-npm/install.ps1")


_Write_Title("# volta")
volta -v
volta setup
volta list all
_br(1)

_Write_Title("# volta install node@latest")
volta install node@latest
_br(1)

_Write_Title("# volta install npm@latest")
volta install npm@latest
_br(1)

_Write_Title("# volta install npx@latest")
volta install npx@latest
_br(1)

_Write_Title("# volta install yarn@latest")
volta install yarn@latest
_br(1)

_Write_Title("# npm install -g expo-cli gtop json-server serve tldr typescript")
npm install -g expo-cli gtop json-server serve tldr typescript
_br(1)

_Write_Title("# volta list all")
volta list all > "${MyPath}/volta_log.txt"
_br(1)


_Set_ExecutionPolicy
_br(2)

_Write_Section("# volta-npm/install.ps1 has finished.")
_br(2)

