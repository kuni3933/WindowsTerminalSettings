. "./../Function.ps1"

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Write_Section("scoop/install.ps1")


Write_Title("# Add extras bucket")
scoop bucket add extras
br(1)

Write_Title("# Add versions bucket")
scoop bucket add versions
br(1)

Write_Title("# Add nerd-fonts bucket")
scoop bucket add nerd-fonts
br(1)

Write_Title("# scoop-for-jp")
scoop bucket add jp https://github.com/rkbk60/scoop-for-jp
br(1)

Write_Title("# Add Java bucket")
scoop bucket add java
br(1)

Write_Title("# Add pleiades bucket")
scoop bucket add pleiades https://github.com/jfut/scoop-pleiades.git
br(1)

Write_Title("# Add scoop-completion bucket")
scoop bucket add scoop-completion https://github.com/Moeologist/scoop-completion
br(1)

Write_Title("# scoop update")
scoop update
br(1)

Write_Title("# aria2 busybox")
scoop install `
  aria2 `
  busybox

Write_Title("# CLI Tools")
scoop install `
  pipes-rs `
  procs `
  bottom `
  streamlink `
  youtube-dl `
  colortool `
  cowsay `
  gh `
  gitignore `
  ln `
  nu `
  onefetch `
  pandoc `
  scoop-completion `
  touch `
  less `
  cacert `
  grep `
  hub `
  imagemagick `
  innounp `
  neovim `
  winfetch `
  gsudo `
  wget `
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
  uutils-coreutils `
  broot `
  xh `
  zoxide `
  task `
  roswell
br(1)

Write_Title("# pwsh tool")
scoop install `
  oh-my-posh3 `
  posh-git `
  starship
br(1)

Write_Title("# GUI Tools")
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
br(1)

Write_Title("# Language / Framework / MiddleWare")
scoop install `
  dotnet `
  sed `
  docker `
  go `
  rustup-msvc `
  python `
  hugo-extended `
  vcxsrv
br(1)

Write_Title("# Python")
# Python
#scoop install `
#python27 `
#python37 `
#python38 `
#python
scoop reset python
br(1)

Write_Title("# fonts")
scoop install `
  source-han-code-jp `
  SourceCodePro-NF-Mono `
  SourceCodePro-NF 
br(1)

Write_Title("# autohotkey-installer")
scoop install autohotkey-installer
# In the future..: scoop install volta
br(1)

Write_Title("# scoop update *")
scoop update *
br(1)

Write_Title("# scoop cleanup *")
scoop cleanup *
br(1)

Write_Title("# scoop cache show")
scoop cache show
br(1)

Write_Title("# scoop cache rm *")
scoop cache rm *
br(1)

Write_Title("# scoop cache show")
scoop cache show
br(1)

Write_Title("# scoop status")
scoop status
br(1)


Write_Section("# scoop/install.ps1 has finished.")
br(2)
