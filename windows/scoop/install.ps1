function Write_Title($msg) {
  Write-Host "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
  Write-Host "┃$msg" -ForegroundColor Yellow
  Write-Host "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
}

Write_Title "# Add versions bucket"
scoop bucket add versions
Write_Title "# Add extras"
scoop bucket add extras

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
  nodejs-lts `
  docker `
  go `
  rustup `
  hugo-extended `
  vcxsrv

# Python
#scoop install `
#python27 `
#python37 `
#python
#scoop reset python

Write_Title "# scoop install gcc "
scoop install gcc
scoop uninstall gcc

Write_Title "# autohotkey-installer"
scoop install autohotkey-installer
# In the future..: scoop install volta

Write_Title "# scoop update & scoop cleanup"
scoop update *
scoop cleanup *
scoop status
Pause
Write_Title " 'install.ps1'が終了しました. / 'install.ps1' has finished."
