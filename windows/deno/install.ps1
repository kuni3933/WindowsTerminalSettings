. "${PSScriptRoot}/../Function.ps1"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

if (!(Get-Command("deno.exe") -ErrorAction SilentlyContinue)) {
		Write-Error -Message "deno.exe is not installed." -ErrorAction Stop
		return 1603
	}
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("deno/install.ps1")

_Write_Title("# deno install mrshmllow/ghfetch")
deno install --force --unstable --allow-net --allow-run "https://raw.githubusercontent.com/bwac2517/ghfetch/main/ghfetch.ts"
_br(1)

_Write_Title("# deno install sheepla/dwebsh")
deno install --force --allow-net --allow-write --name dwebsh "https://raw.githubusercontent.com/sheepla/dwebsh/master/cli.ts"
_br(1)

#_Write_Title("# deno install sheepla/zenn-trend-cli")
#deno install --force --allow-net --name zenn-trend-cli "https://raw.githubusercontent.com/sheepla/zenn-trend-cli/master/cli.ts"
_br(1)


_Set_ExecutionPolicy
_br(2)

_Write_Section("# deno/install.ps1 has finished.")
_br(2)


