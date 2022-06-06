. "${PSScriptRoot}/../Function.ps1"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

if (-Not (Get-Command("scoop"))) {
		Write-Error -Message "scoop is not installed." -ErrorAction Stop
		return 1603
	}
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("scoop/install.ps1")

_Write_Title("# Add Main bucket")
scoop bucket add Main "https://github.com/ScoopInstaller/Main"
_br(1)

_Write_Title("# Add Extras bucket")
scoop bucket add Extras "https://github.com/ScoopInstaller/Extras"
_br(1)

_Write_Title("# Add Versions bucket")
scoop bucket add Versions "https://github.com/ScoopInstaller/Versions"
_br(1)

_Write_Title("# Add nerd-fonts bucket")
scoop bucket add nerd-fonts "https://github.com/matthewjberger/scoop-nerd-fonts"
_br(1)

<#
_Write_Title("# scoop-for-jp")
scoop bucket add jp https://github.com/rkbk60/scoop-for-jp
_br(1)
#>

_Write_Title("# Add Java bucket")
scoop bucket add java "https://github.com/ScoopInstaller/Java"
_br(1)

_Write_Title("# Add scoop-pleiades bucket")
scoop bucket add pleiades "https://github.com/jfut/scoop-pleiades"
_br(1)

_Write_Title("# Add scoop-completion bucket")
scoop bucket add scoop-completion "https://github.com/Moeologist/scoop-completion"
_br(1)

_Write_Title("# scoop update")
scoop update
_br(1)

_Write_Title("# aria2")
scoop install Main/aria2

_Write_Title("# Main/busybox")
if(Test-Path ${env:USERPROFILE}/scoop/apps/busybox/current/busybox.exe){
  scoop uninstall Main/busybox
}
scoop install Main/busybox

_Write_Title("# uutils-coreutils")
if(Test-Path ${env:USERPROFILE}/scoop/apps/uutils-coreutils/current/coreutils.exe){
    scoop uninstall Main/uutils-coreutils
}
scoop install Main/uutils-coreutils

# less
if(Test-Path ${env:USERPROFILE}/scoop/apps/less/current/less.exe){
    scoop uninstall Main/less
}

_Write_Title("# CLI Tools")
scoop install `
  Extras/pipes-rs `
  Main/procs `
  Main/bottom `
  Main/hexyl `
  Extras/streamlink `
  Main/youtube-dl `
  Main/colortool `
  Main/neo-cowsay `
  Main/gh `
  Main/ghq `
  Main/gitignore `
  Main/heroku-cli `
  Main/firebase `
  Main/nu `
  Extras/onefetch `
  Extras/terminal-icons `
  Main/pandoc `
  Extras/scoop-completion `
  Main/less `
  Main/cacert `
  Main/hub `
  Main/imagemagick `
  Main/innounp `
  Main/neovim `
  Main/winfetch `
  Main/gsudo `
  Main/bat `
  Main/bit `
  Main/bind `
  Main/gping `
  Main/fd `
  Main/fx `
  Main/dust `
  Main/7zip `
  Main/fzf `
  Main/jo `
  Main/jq `
  Main/jx `
  Main/jid `
  Main/gron `
  Main/ripgrep `
  Main/delta `
  Main/lsd `
  Main/make `
  Main/ffmpeg `
  Main/vim `
  Main/broot `
  Main/xh `
  Main/zoxide `
  Main/task `
  Main/roswell
_br(1)

_Write_Title("# pwsh tool")
scoop install `
  Main/oh-my-posh `
  Extras/posh-git `
  Main/starship
_br(1)

_Write_Title("# GUI Tools")
scoop install `
  Extras/bugn `
  Extras/keypirinha
_br(1)

_Write_Title("# Language / Framework / MiddleWare")
scoop install `
  Main/volta `
  Main/deno `
  Main/dotnet-sdk `
  Main/sed `
  Main/docker `
  Main/go `
  Main/rustup-msvc `
  Main/python `
  Main/hugo-extended
_br(1)

<#
_Write_Title("# Python")
#Python
scoop install `
python27 `
python37 `
python38 `
python
scoop reset python
_br(1)
#>

_Write_Title("# fonts")
scoop install `
  nerd-fonts/SourceCodePro-NF `
  nerd-fonts/SourceCodePro-NF-Mono
_br(1)

_Write_Title("# scoop update *")
scoop update *
_br(1)

_Write_Title("# scoop cleanup *")
scoop cleanup *
_br(1)

_Write_Title("# scoop cache show")
scoop cache show
_br(1)

_Write_Title("# scoop cache rm *")
scoop cache rm *
_br(1)

_Write_Title("# scoop cache show")
scoop cache show
_br(1)

_Write_Title("# scoop status")
scoop status
_br(1)


_Set_ExecutionPolicy
_br(2)

_Write_Section("# scoop/install.ps1 has finished.")
_br(2)

