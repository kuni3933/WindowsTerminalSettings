function Write_Title($msg) {
  Write-Host "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
  Write-Host "┃$msg" -ForegroundColor Yellow
  Write-Host "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
}

Write_Title "# Add extras bucket"
scoop bucket add extras
Write_Title "# Add versions bucket"
scoop bucket add versions
Write_Title "# Add nerd-fonts buvket"
scoop bucket add nerd-fonts
Write_Title "# Add Java bucket"
scoop bucket add java
Write_Title "# Add pleiades bucket"
scoop bucket add pleiades
Write_Title " scoop update"
scoop update

Write_Title "# CLI Tools"
scoop install `
  aria2 `
  streamlink `
  youtube-dl `
  cacert `
  grep `
  hub `
  imagemagick `
  innounp `
  neovim `
  winfetch `
  sudo `
  gsudo `
  wget `
  bat `
  bind `
  fd `
  dust `
  7zip `
  fzf `
  jq `
  fx `
  less `
  ripgrep `
  delta `
  lsd `
  make `
  ffmpeg `
  z `
  vim `
  uutils-coreutils `
  broot `
  zoxide

Write_Title "# GUI Tools"
scoop install `
  dbeaver `
  postman `
  keypirinha `
  ditto `
  draw.io

Write_Title "# Language / Framework / MiddleWare"
scoop install `
  docker `
  go `
  rustup `
  hugo-extended `
  vcxsrv

# Python
#scoop install `
#python27 `
#python37 `
#python38
#python
#scoop reset python

Write_Title "# scoop install gcc "
scoop install gcc
scoop uninstall gcc

Write_Title "# scoop install msys2"
scoop install msys2

Write_Title "# scoop install nerd-fonts"
scoop install `
  SourceCodePro-NF-Mono `
  SourceCodePro-NF

Write_Title "# autohotkey-installer"
scoop install autohotkey-installer
# In the future..: scoop install volta

Write_Title "# scoop update * & scoop cleanup *"
scoop update *
scoop cleanup *
scoop status
Pause
Write_Title " 'install.ps1'が終了しました. / 'install.ps1' has finished."
