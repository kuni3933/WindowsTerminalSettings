. "./../Function.ps1"

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("scoop/install.ps1")


_Write_Title("# Add extras bucket")
scoop bucket add extras
_br(1)

_Write_Title("# Add versions bucket")
scoop bucket add versions
_br(1)

_Write_Title("# Add nerd-fonts bucket")
scoop bucket add nerd-fonts
_br(1)

<#
_Write_Title("# scoop-for-jp")
scoop bucket add jp https://github.com/rkbk60/scoop-for-jp
_br(1)
#>

_Write_Title("# Add Java bucket")
scoop bucket add java
_br(1)

_Write_Title("# Add pleiades bucket")
scoop bucket add pleiades https://github.com/jfut/scoop-pleiades.git
_br(1)

_Write_Title("# Add scoop-completion bucket")
scoop bucket add scoop-completion https://github.com/Moeologist/scoop-completion
_br(1)

_Write_Title("# scoop update")
scoop update
_br(1)

_Write_Title("# aria2")
scoop install `
  aria2 `

_Write_Title("# busybox")
if(Test-Path ${env:USERPROFILE}/scoop/apps/busybox/current/busybox.exe){
  scoop uninstall busybox
}
scoop install busybox

_Write_Title("# uutils-coreutils")
if(Test-Path ${env:USERPROFILE}/scoop/apps/uutils-coreutils/current/coreutils.exe){
    scoop uninstall uutils-coreutils
}
scoop install uutils-coreutils

# less
if(Test-Path ${env:USERPROFILE}/scoop/apps/less/current/less.exe){
    scoop uninstall less
}

_Write_Title("# CLI Tools")
scoop install `
  pipes-rs `
  procs `
  bottom `
  hexyl `
  streamlink `
  youtube-dl `
  colortool `
  cowsay `
  gh `
  gitignore `
  nu `
  onefetch `
  pandoc `
  scoop-completion `
  less `
  cacert `
  hub `
  imagemagick `
  innounp `
  neovim `
  winfetch `
  gsudo `
  bat `
  bind `
  fd `
  dust `
  7zip `
  fzf `
  jq `
  jx `
  jid `
  ripgrep `
  delta `
  lsd `
  make `
  ffmpeg `
  vim `
  broot `
  xh `
  zoxide `
  task `
  roswell
_br(1)

_Write_Title("# pwsh tool")
scoop install `
  oh-my-posh3 `
  posh-git `
  starship
_br(1)

_Write_Title("# GUI Tools")
scoop install `
  alacritty `
  bugn `
  etcher `
  typora `
  dbeaver `
  postman `
  keypirinha `
  ditto `
  draw.io
_br(1)

_Write_Title("# Language / Framework / MiddleWare")
scoop install `
  volta `
  deno `
  dotnet-sdk-preview `
  sed `
  docker `
  go `
  rustup-msvc `
  python `
  hugo-extended `
  vcxsrv
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
  SourceCodePro-NF `
  SourceCodePro-NF-Mono
_br(1)

_Write_Title("# autohotkey-installer")
scoop install autohotkey-installer
# In the future..: scoop install volta
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

