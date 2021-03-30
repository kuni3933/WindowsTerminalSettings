function Write_Title($msg) {
  Write-Host "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
  Write-Host "┃$msg" -ForegroundColor Yellow
  Write-Host "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
}

# Add versions bucket
scoop bucket add versions
# Add extras
scoop bucket add extras
# CLI Tools
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

# GUI Tools
scoop install `
  dbeaver `
  postman `
  keypirinha `
  ditto `
  draw.io


# Language / Framework / MiddleWare
scoop install `
  nodejs-lts `
  gcc `
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

scoop install autohotkey-installer



scoop update *
scoop cleanup *
scoop status

Pause
Write_Title " 'install.ps1'が終了しました. / 'install.ps1' has finished."
