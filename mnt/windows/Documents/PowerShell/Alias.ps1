#-----------------------------------------------------
# $env:EDITOR
#-----------------------------------------------------
if (Get-Command vim -ea SilentlyContinue) {
  ${env:EDITOR} = "vim"
  Set-Alias EDITOR vim
  Set-Alias :e vim
}
if (Get-Command nvim -ea SilentlyContinue) {
  ${env:EDITOR} = "nvim"
  Set-Alias EDITOR nvim
  Set-Alias :e nvim
}

#-----------------------------------------------------
# c => clear
#-----------------------------------------------------
Set-Alias c Clear-Host


#-----------------------------------------------------
# cliSaver
#-----------------------------------------------------
function cliSaver() {
  ${tmp} = $null
  if(Get-Command pipes-rs -ea SilentlyContinue) { $tmp += 2}
  if(Get-Command rusty-rain -ea SilentlyContinue) { $tmp += 3 }
  if($null -ne ${tmp}){
    switch(Get-Random $tmp){
      0{ pipes-rs }
      1{ pipes-rs --rainbow 1}
      2{ rusty-rain -s }
      3{ rusty-rain -C 0,139,139 -H 255,255,255 -s }
      4{ rusty-rain -C 0,180,200 -H 255,255,255 -s }
    }
  }
}


#-----------------------------------------------------
# fzf
#-----------------------------------------------------
$env:FZF_DEFAULT_OPTS="--reverse --border --height 50%"
$env:FZF_DEFAULT_COMMAND='fd -HL --exclude ".git" .'
if (Get-Command fd -ea SilentlyContinue && Get-Command fzf -ea SilentlyContinue) {
  function _fzf_compgen_path() {
    fd -HL --exclude ".git" . "$1"
  }
  function _fzf_compgen_dir() {
    fd --type d -HL --exclude ".git" . "$1"
  }
}


#-----------------------------------------------------
# Linux like commands
#-----------------------------------------------------
# https://secon.dev/entry/2020/08/17/070735/
if (Get-Command coreutils -ea SilentlyContinue) {
@"
  arch, base32, base64, basename, cat, cksum, comm, cp, cut, date, df, dircolors, dirname,
  echo, env, expand, expr, factor, false, fmt, fold, hashsum, head, hostname, join, link, ln,
  ls, md5sum, mkdir, mktemp, more, mv, nl, nproc, od, paste, printenv, printf, ptx, pwd,
  readlink, realpath, relpath, rm, rmdir, seq, sha1sum, sha224sum, sha256sum, sha3-224sum,
  sha3-256sum, sha3-384sum, sha3-512sum, sha384sum, sha3sum, sha512sum, shake128sum,
  shake256sum, shred, shuf, sleep, sort, split, sum, sync, tac, tail, tee, test, touch, tr,
  true, truncate, tsort, unexpand, uniq, wc, whoami, yes
"@ -split ',' |
  ForEach-Object { $_.trim() } |
  Where-Object { ! @('tee', 'sort', 'sleep').Contains($_) } |
  ForEach-Object {
    $cmd = $_
    if (Test-Path Alias:$cmd) { Remove-Item -Path Alias:$cmd }
    $fn = '$input | uutils ' + $cmd + ' $args'
    Invoke-Expression "function global:$cmd { $fn }"
  }
}

# bat - cat with syntax highlight - https://github.com/sharkdp/bat
if (Get-Command bat -ea SilentlyContinue) {
  function rebat() { bat cache --build $args }
  function b() { bat --wrap auto $args }
}

# less
if (Test-Path $env:USERPROFILE/scoop/apps/less/current/less.exe -ea SilentlyContinue) {
  Set-Alias less $env:USERPROFILE/scoop/apps/less/current/less.exe
}

#sudo
if (Get-Command gsudo -ea SilentlyContinue) { Set-Alias sudo gsudo }

# ⚠ readonlyのaliasなので問題が発生するかも..
if ((Get-Command uutils -ea SilentlyContinue) -AND (Get-Alias sort -ea SilentlyContinue)) {
  Remove-Item alias:sort -Force
  function sort() { $input | uutils sort $args }
}

# 代替コマンドを使用
if (Get-Command rg -ea SilentlyContinue) { Set-Alias grep rg }

# Linuxコマンドのエイリアス
if (Get-Command exa -ea SilentlyContinue) {
  function l() { exa --all --git --icons --classify $args }
  function la() { exa --all --git --icons --classify $args }
  function ls() { exa --git --icons $args }
  function ll() { exa --all --git --group --header --icons --long --time-style long-iso $args }
  function lt() { exa --all --git --group --header --icons --long --time-style long-iso --tree $args }
  function tree() { exa --all --git --group --header --icons --long --time-style long-iso --tree $args }
}
#function awslocal { aws '--endpoint-url=http://localhost:4566' $args }


#-----------------------------------------------------
# Useful commands
#-----------------------------------------------------
# cd
function ..() { Set-Location ../ }
function ...() { Set-Location ../../ }
function ....() { Set-Location ../../../ }
if (Get-Command gowl -ea SilentlyContinue && Get-Command fzf -ea SilentlyContinue) {
  function cdgowl() { gowl list | fzf | Set-Location }
}
if (Get-Command ghq -ea SilentlyContinue) {
  function cdghq_root { Set-Location "$(ghq root)" }
  function cdghq_rootGithub { Set-Location "$(ghq root)/github.com" }

  if (Get-Command fzf -ea SilentlyContinue) {
    function cdghq {
      ${d} = $null
      # $d = ghq list | fzf --preview "pwsh -c ls -l $(ghq root)/{}"
      if (Get-Command exa -ea SilentlyContinue) {
        ${d} = ghq list | fzf --preview "cd $(ghq root)/{} & exa --all --git --group --header --icons --long --time-style long-iso"
      } else {
        ${d} = ghq list | fzf --preview "cd $(ghq root)/{} & powershell -c ls"
      }
      if (${d}) { Set-Location "$(ghq root)/${d}" }
    }
  }
}
if (Get-Command fd -ea SilentlyContinue && Get-Command fzf -ea SilentlyContinue) {
  function cdr() { fd -H -t d -E .git -E node_modules | fzf | Set-Location }
}
if (Get-Command zoxide -ea SilentlyContinue) {
  Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell) -join "`n"
  })
  Set-Alias cdz zi
}


#-----------------------------------------------------
# Vim
#-----------------------------------------------------
if (Get-Command fd -ea SilentlyContinue && Get-Command fzf -ea SilentlyContinue) {
  function vimr() { fd -H -E .git -E node_modules | fzf | ForEach-Object { EDITOR $_ } }
}


#-----------------------------------------------------
# Copy current path
#-----------------------------------------------------
function cpwd() {
  Resolve-Path
  Convert-Path . | Set-Clipboard
}


#-----------------------------------------------------
#Git/usr/bin
#-----------------------------------------------------
[string] ${Git_usr_bin} = ${null};
if (Test-Path "${env:GIT_INSTALL_ROOT}/cmd/git.exe") {
  ${Git_usr_bin} = "${env:GIT_INSTALL_ROOT}/usr/bin"
}
elseif (Test-Path "C:/Program Files/Git/cmd/git.exe") {
  ${Git_usr_bin} = "C:/Program Files/Git//usr/bin"
}
if (${Git_usr_bin} -ne ${null}) {
  Set-Alias tig "${Git_usr_bin}/tig"
}

# git flow
function gf() { git fetch --all }
function gd() { git diff -U5 $args }
function gdc() { git diff --cached $args }
function gds() { git diff --staged $args }
function ga() { git add $args }
function gaa() { git add --all }
function gco() { git commit -m $args[0] }

# git switch
function gba() { git branch -a }
function gb() { git branch -l | rg -v '^\* ' | ForEach-Object { $_ -replace " ", "" } | fzf | ForEach-Object { git switch $_ } }
function gbr() { git branch -rl | rg -v "HEAD|master" | ForEach-Object { $_ -replace "  origin/", "" } | fzf | ForEach-Object { git switch $_ } }
function gbc() { git switch -c $args[0] }
function gbm() { git branch -l | rg -v '^\* ' | ForEach-Object { $_ -replace " ", "" } | fzf | ForEach-Object { git merge --no-ff $_ } }

# git log
function gls() { git log -3 }
function gll() { git log -10 --oneline --all --graph --decorate }
function glll() { git log --graph --all --date=format:'%Y-%m-%d %H:%M:%S' --pretty=format:'%C(auto)%d%Creset\ %C(yellow)%h%Creset %C(magenta)%ae%Creset %C(cyan)%ad%Creset%n%C(white bold)%w(80)%s%Creset%n%b' }
function glls() { git log --graph --all --date=format:'%Y-%m-%d %H:%M:%S' --pretty=format:'%C(auto)%d%Creset\ %C(yellow)%h%Creset %C(magenta)%ae%Creset %C(cyan)%ad%Creset%n%C(white bold)%w(80)%s%Creset%n%b' -10 }
function ggraph() { git log --graph --all  --date=format:'%Y-%m-%d %H:%M:%S' -C -M --pretty=format:\"<%h> %ad [%an] %Cgreen%d%Creset %s\" --date-order }

# git status
function gs() { git status --short }
function gss() { git status -v }


#-----------------------------------------------------
# explorer
#-----------------------------------------------------
function e() { explorer $args }


#-----------------------------------------------------
# ffmpeg
#-----------------------------------------------------
function ffmp4red() { ffmpeg -i $args[0] -vcodec libx264 -crf 20 $args[1] }
function ff256() { ffmpeg -i $args[0] -filter_complex "[0:v] split [a][b];[a] palettegen [p];[b][p] paletteuse" $args[1] }
function ffresize() { $width = $args[1]; ffmpeg -i $args[0] -vf scale=$width":-1" $args[2] }
function fffavicon() { $width = $args[1]; ffmpeg -i $args[0] -vf scale=$width":-1" favicon.ico }
function ffjpeg() { ffmpeg -i $args[0] -vf scale=1280":-1" $args[0] }


#-----------------------------------------------------
# broot
#-----------------------------------------------------
function bo() { broot -g --conf $env:USERPROFILE\broot.toml $args }
function br() {
  $outcmd = New-Temporaryfile
  bo --outcmd $outcmd $args
  if (!$?) {
    Remove-Item -Force $outcmd
    return $lastexitcode
  }

  $command = Get-Content $outcmd
  if ($command) {
    # workaround - paths have some garbage at the start
    $command = $command.replace("\\?\", "", 1)
    Invoke-Expression $command
  }
  Remove-Item -Force $outcmd
}
