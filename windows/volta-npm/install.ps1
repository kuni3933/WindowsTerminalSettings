. "${PSScriptRoot}/../Function.ps1"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

if (-Not (Get-Command("volta.exe"))) {
		Write-Error -Message "volta.exe is not installed." -ErrorAction Stop
		return 1603
	}
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("volta-npm/install.ps1")


_Write_Title("# volta")
volta -v
volta setup
volta list all
_br(1)

_Write_Title("# volta install node@latest")
if(Test-Path "${VOLTA_HOME}/tools/image/node"){
  Remove-Item -Recurse ${env:VOLTA_HOME}/tools/image/node
}
volta install node@latest
_br(1)

_Write_Title("# volta install npm@latest")
if(Test-Path "${env:VOLTA_HOME}/tools/image/npm"){
  Remove-Item -Recurse ${env:VOLTA_HOME}/tools/image/npm
}
volta install npm@latest
_br(1)

_Write_Title("# volta install yarn@latest")
if(Test-Path "${env:VOLTA_HOME}/tools/image/yarn"){
  Remove-Item -Recurse ${env:VOLTA_HOME}/tools/image/yarn
}
volta install yarn@latest
_br(1)

_Write_Title("# npm install -g express-generator json-server npx")
npm install -g json-server express-generator
_br(1)

_Write_Title("# volta list all")
volta list all
_br(1)


_Set_ExecutionPolicy
_br(2)

_Write_Section("# volta-npm/install.ps1 has finished.")
_br(2)

