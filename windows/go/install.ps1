. "${PSScriptRoot}/../Function.ps1"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

if (-Not (Get-Command("go.exe"))) {
		Write-Error -Message "go.exe is not installed." -ErrorAction Stop
		return 1603
	}
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("go/install.ps1")

_Write_Title("# go clean -cache -testcache")
go clean -cache -testcache -n
go clean -cache -testcache
_br(1)

_Write_Title("# go install github.com/sheepla/fzwiki@latest")
go install github.com/sheepla/fzwiki@latest
_br(1)

_Write_Title("# go install github.com/tadashi-aikawa/gowl@latest")
go install github.com/tadashi-aikawa/gowl@latest
_br(1)

_Write_Title("# go install github.com/tcnksm/ghr@latest")
go install github.com/tcnksm/ghr@latest
_br(1)


_Set_ExecutionPolicy
_br(2)

_Write_Section("# go/install.ps1 has finished.")
_br(2)

