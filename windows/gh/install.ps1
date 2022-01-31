. "${PSScriptRoot}/../Function.ps1"

function _ghinstall([string] ${extension}) {
  _Write_Title("# ${extension}")

  [System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "gh.exe" `
		-ArgumentList "extension install ${extension}" `
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
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

if (-Not (Get-Command("gh.exe"))) {
		Write-Error -Message "gh.exe is not installed." -ErrorAction Stop
		return 1603
	}
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("gh/install.ps1")

_ghinstall("anmalkov/gh-timer")
_ghinstall("daido1976/gh-default-branch")
_ghinstall("ericwb/gh-alerts")
_ghinstall("heaths/gh-label")
_ghinstall("kavinvalli/gh-repo-fzf")
_ghinstall("kawarimidoll/gh-q")
_ghinstall("kentaro-m/gh-lspr")
_ghinstall("KOBA789/gh-sql")
_ghinstall("maggie-j-liu/gh-star")
_ghinstall("matt-bartel/gh-clone-org")
_ghinstall("meiji163/gh-search")
_ghinstall("meiji163/gh-notify")
_ghinstall("mislav/gh-branch")
_ghinstall("mislav/gh-cp")
_ghinstall("mislav/gh-repo-collab")
_ghinstall("sheepla/gh-fzrepo")
_ghinstall("otiai10/gh-dependents")
_ghinstall("samcoe/gh-repo-explore")
_ghinstall("sheepla/gh-userfetch")
_ghinstall("sheepla/gh-graph")
_ghinstall("siketyan/gh-smerge")
_ghinstall("YuG1224/gh-lgtmoon")
_ghinstall("yuler/gh-download")
_ghinstall("yusukebe/gh-markdown-preview")


_Set_ExecutionPolicy
_br(2)

_Write_Section("# scoop/install.ps1 has finished.")
_br(2)

