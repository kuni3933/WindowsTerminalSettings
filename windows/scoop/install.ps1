. "${PSScriptRoot}/../Function.ps1"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

if(-Not (Get-Command("scoop"))){
		Write-Error -Message "scoop is not installed." -ErrorAction Stop
		return 1603
}

${MyPath} = Split-Path -Parent $MyInvocation.MyCommand.Path
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

_Write_Title("# Add java bucket")
scoop bucket add java "https://github.com/ScoopInstaller/Java"
_br(1)

_Write_Title("# Add pleiades bucket")
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

_Write_Title("# Main/uutils-coreutils")
if(Test-Path ${env:USERPROFILE}/scoop/apps/uutils-coreutils/current/coreutils.exe){
  scoop uninstall Main/uutils-coreutils
}
scoop install Main/uutils-coreutils

_Write_Title("# Main/less")
if(Test-Path ${env:USERPROFILE}/scoop/apps/less/current/less.exe){
  scoop uninstall Main/less
}
scoop install Main/less

_Write_Title("# CLI Tools")
scoop install `
  Main/7zip `
  Main/ag `
  Main/bat `
  Main/bind `
  Main/bit `
  Main/broot `
  Main/cacert `
  Main/cheat `
  Main/colortool `
  Main/curlie `
  Main/delta `
  Main/docfx `
  Main/dog `
  Main/fd `
  Main/ffmpeg `
  Main/firebase `
  Main/fx `
  Main/fzf `
  Main/gh `
  Main/ghq `
  Main/gron `
  Main/grpcurl `
  Main/gsudo `
  Main/hexyl `
  Main/htmlq `
  Main/httpstat `
  Main/hub `
  Main/hyperfine `
  Main/imagemagick `
  Main/jid `
  Main/jo `
  Main/jq `
  Main/lsd `
  Main/make `
  Main/neo-cowsay `
  Main/reviewdog `
  Main/ripgrep `
  Main/roswell `
  Main/sd `
  Main/sed `
  Main/task `
  Main/winfetch `
  Main/xh `
  Main/youtube-dl `
  Main/yq `
  Main/yt-dlp `
  Main/zoxide `
  Extras/onefetch `
  Extras/pipes-rs `
  Extras/streamlink
_br(1)

_Write_Title("# pwsh tool")
scoop install `
  Main/starship `
  Extras/psfzf `
  Extras/psreadline `
  Extras/scoop-completion `
  Extras/terminal-icons
_br(1)

_Write_Title("# GUI/TUI Tools")
scoop install `
  Main/bottom `
  Main/duf `
  Main/dust `
  Main/gitui `
  Main/gotop `
  Main/gping `
  Main/helix `
  Main/lazydocker `
  Main/mprocs `
  Main/neovim `
  Main/procs `
  Main/termshark `
  Main/vim `
  Extras/bugn `
  Extras/imhex `
  Extras/keypirinha `
  Extras/lazygit `
  Extras/wireshark
#Extras/asciidocfx
_br(1)

_Write_Title("# Framework / Language / MiddleWare / Shell")
scoop install `
  Main/deno `
  Main/docker `
  Main/dotnet-sdk `
  Main/go `
  Main/hugo-extended `
  Main/nu `
  Main/python `
  Main/rustup-msvc `
  Main/volta
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
scoop list > "${MyPath}/scoop_log.txt"
scoop status
_br(1)


_Set_ExecutionPolicy
_br(2)

_Write_Section("# scoop/install.ps1 has finished.")
_br(2)

