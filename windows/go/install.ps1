. "${PSScriptRoot}/../Function.ps1"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

if (-Not (Get-Command("go.exe"))) {
		Write-Error -Message "go.exe is not installed." -ErrorAction Stop
		return 1603
	}
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("go/install.ps1")


_Write_Title("# go get -u github.com/tadashi-aikawa/gowl")
go get -u github.com/tadashi-aikawa/gowl
_br(1)

_Write_Title("# go get -u github.com/tcnksm/ghr")
go get -u github.com/tcnksm/ghr
_br(1)


_Set_ExecutionPolicy
_br(2)

_Write_Section("# go/install.ps1 has finished.")
_br(2)

