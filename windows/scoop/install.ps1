# Add versions bucket
scoop bucket add versions
# Add extras
scoop bucket add extras
# Add git -g(lobal)
scoop install git -g
# CLI Tools
scoop install `
  aria2 `
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
  vscode `
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

sudo scoop install autohotkey-installer












scoop status
scoop cleanup *
