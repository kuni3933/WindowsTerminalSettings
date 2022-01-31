. "${PSScriptRoot}/../Function.ps1"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

if (-Not (Get-Command("gh.exe"))) {
		Write-Error -Message "gh.exe is not installed." -ErrorAction Stop
		return 1603
	}
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("gh/install.ps1")

_Write_Title("# deno install mrshmllow/ghfetch")
deno install --unstable --allow-net --allow-run "https://raw.githubusercontent.com/bwac2517/ghfetch/main/ghfetch.ts"
_br(1)

_Write_Title("# gh extension install sheepla/gh-userfetch")
gh extension install sheepla/gh-userfetch
_br(1)

_Write_Title("# gh extension install sheepla/gh-fzopen")
gh extension install sheepla/gh-fzopen
_br(1)

_Write_Title("# gh extension install sheepla/gh-graph")
gh extension install sheepla/gh-graph
_br(1)


_Set_ExecutionPolicy
_br(2)

_Write_Section("# scoop/install.ps1 has finished.")
_br(2)

