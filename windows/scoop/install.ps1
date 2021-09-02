function Write_Title($msg) {
  Write-Host "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
  Write-Host "┃$msg" -ForegroundColor Yellow
  Write-Host "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
}
function Write_Section($msg) {
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
    Write-Host "     $msg" -ForegroundColor Green
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
}
function br($times) {
  $tmp = 1
  while ($tmp -le $times) {
    Write-Output " ";
    $tmp += 1
  }
}

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

Write_Title("# CLI Tools")
scoop install `
  aria2 `
  pipes-rs `
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
  busybox `
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
  z `
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

Write_Title("# scoop install gcc")
scoop install gcc
scoop uninstall gcc
br(1)

Write_Title("# fonts")
scoop install `
  source-han-code-jp `
  SourceCodePro-NF-Mono `
  SourceCodePro-NF `
  SarasaGothic-J
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

Write_Title("# scoop status")
scoop status
br(1)

Write_Section("# scoop/install.ps1 has finished.")
br(2)
