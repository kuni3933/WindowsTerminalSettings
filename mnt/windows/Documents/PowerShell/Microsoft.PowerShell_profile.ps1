$scriptPath = $MyInvocation.MyCommand.Path
$SplitDirPath = Split-Path -Parent $scriptPath
$IsSet = "$SplitDirPath/IsSet.ps1"
# Example of "IsSet" usage
# if((powershell $IsSet command_name -eq $true){alias...function...}
# command_name...exa/cat/...etc

if(Test-Path $env:USERPROFILE/scoop/apps/rustup-msvc/current/.cargo/bin/rusty-rain.exe){
  if((Get-Random 2) -eq 0){
    pipes-rs
  }
  else{
    rusty-rain -C 0,139,139 -H 255,255,255 -s
  }
}
else{
  pipes-rs
}
winfetch.PS1

# $env:EDITOR
if(Get-Command vim -ea SilentlyContinue){
    ${env:EDITOR} = "vim"
    Set-Alias EDITOR vim
    Set-Alias :e vim
}
if(Get-Command nvim -ea SilentlyContinue){
    ${env:EDITOR} = "nvim"
    Set-Alias EDITOR nvim
    Set-Alias :e nvim
}

# c => clear
Set-Alias c Clear-Host

##############################
# PSFzf
# ##############################
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

##############################
# Scoop completion
# ##############################
Import-Module "$($(Get-Item $(Get-Command scoop).Path).Directory.Parent.FullName)/modules/scoop-completion"

#-----------------------------------------------------
# General
#-----------------------------------------------------

# PowerShell Core7でもConsoleのデフォルトエンコーディングはsjisなので必要
[System.Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("utf-8")
[System.Console]::InputEncoding = [System.Text.Encoding]::GetEncoding("utf-8")

# git logなどのマルチバイト文字を表示させるため (絵文字含む)
$env:LESSCHARSET = "utf-8"

# 音を消す
Set-PSReadlineOption -BellStyle None

# 予測インテリセンス
Set-PSReadLineOption -PredictionSource History
#参考https://docs.microsoft.com/en-us/powershell/module/psreadline/set-psreadlineoption?view=powershell-7.1
#参考-https://serverfault.com/questions/36991/windows-powershell-vim-keybindings
#参考 https://docs.microsoft.com/ja-jp/powershell/module/psreadline/about/about_psreadline?view=powershell-7.1
Set-PSReadLineOption -HistoryNoDuplicates:$true
Set-PSReadLineOption -HistorySearchCursorMovesToEnd:$true
# (optional) Ctrl+f 入力で前方1単語進む : 補完の確定に使う用
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function ForwardWord
Set-PSReadLineKeyHandler -Key "UpArrow" -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key "Ctrl+o" -Function MenuComplete

#-----------------------------------------------------
# Key binding
#-----------------------------------------------------

# Emacsベース
#Set-PSReadLineOption -EditMode Emacs
# Windowsベース
Set-PSReadLineOption -EditMode Windows

#-----------------------------------------------------
# Powerline
#-----------------------------------------------------

Import-Module posh-git
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell) -join "`n"
})

#Set-PoshPrompt -Theme  ~/.oh-my-posh.json
oh-my-posh --init --shell pwsh --config ~/.oh-my-posh.json | Invoke-Expression

#-----------------------------------------------------
# fzf
#-----------------------------------------------------

# fzf
$env:FZF_DEFAULT_OPTS="--reverse --border --height 50%"
$env:FZF_DEFAULT_COMMAND='fd -HL --exclude ".git" .'
function _fzf_compgen_path() {
  fd -HL --exclude ".git" . "$1"
}
function _fzf_compgen_dir() {
  fd --type d -HL --exclude ".git" . "$1"
}

#-----------------------------------------------------
# Linux like commands
#-----------------------------------------------------

# https://secon.dev/entry/2020/08/17/070735/
if(Test-Path $env:USERPROFILE/scoop/apps/uutils-coreutils/current/coreutils.exe){
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

# bat - cat with syntax highlight
# https://github.com/sharkdp/bat
if(Get-Command bat -ea SilentlyContinue){
    if(Get-Alias cat -ea SilentlyContinue) {
        Remove-Item alias:cat
    }
    if(Get-ChildItem Function:\cat -ea SilentlyContinue){
        Remove-Item Function:cat
    }
    function rebat() { bat cache --build $args}
    function cat() { bat --wrap auto $args}
}
else {
    Set-Alias cat Get-Content
}

# less
if(Test-Path $env:USERPROFILE/scoop/apps/less/current/less.exe -ea SilentlyContinue){
    Set-Alias less $env:USERPROFILE/scoop/apps/less/current/less.exe
}

#sudo
if(Test-Path $env:USERPROFILE/scoop/apps/gsudo/current/gsudo.exe -ea SilentlyContinue){
    Set-Alias sudo $env:USERPROFILE/scoop/apps/gsudo/current/gsudo.exe
}

# ⚠ readonlyのaliasなので問題が発生するかも..
Remove-Item alias:sort -Force
function sort() { $input | uutils sort $args}

# 代替コマンドを使用
Set-Alias grep rg
function ls() { uutils ls $args }
function tree() { exa --long --all --git --icons --tree --header }

# Linuxコマンドのエイリアス
function l() { exa --all --icons --classify }
function la() { exa --all --icons --classify }
function ls() { exa --icons }
function ll() { exa --long --all --git --icons --header }
function lt() { exa --long --all --git --icons --tree --header }

#function awslocal { aws '--endpoint-url=http://localhost:4566' $args }

#-----------------------------------------------------
# Useful commands
#-----------------------------------------------------

# cd
function ..() { Set-Location ../ }
function ...() { Set-Location ../../ }
function ....() { Set-Location ../../../ }
function cdg() { gowl list | fzf | Set-Location }
function cdr() { fd -H -t d -E .git -E node_modules | fzf | Set-Location }
Set-Alias cdz zi
function buscdd() { Get-ChildItem -1 C:\\Work\\treng\\Bus\\data | rg .*$Arg1.*_xrf | fzf | ForEach-Object { Set-Location C:\\Work\\treng\\Bus\\data\\$_ } }
function buscdw() { Get-ChildItem -1 C:\\Work\\treng\\Bus\\work | rg .*$Arg1.*_xrf | fzf | ForEach-Object { Set-Location C:\\Work\\treng\\Bus\\work\\$_ } }

# vim
function vimr() { fd -H -E .git -E node_modules | fzf | ForEach-Object { EDITOR $_ } }

# Copy current path
function cpwd() { Convert-Path . | Set-Clipboard }

# git flow
function gf()  { git fetch --all }
function gd()  { git diff $args }
function gdc() { git diff --cached $args }
function gds() { git diff --staged $args }
function ga()  { git add $args }
function gaa() { git add --all }
function gco() { git commit -m $args[0] }

# git switch
function gb()  { git branch -l | rg -v '^\* ' | ForEach-Object { $_ -replace " ", "" } | fzf | ForEach-Object { git switch $_ } }
function gbr() { git branch -rl | rg -v "HEAD|master" | ForEach-Object { $_ -replace "  origin/", "" } | fzf | ForEach-Object { git switch $_ } }
function gbc() { git switch -c $args[0] }
function gbm()  { git branch -l | rg -v '^\* ' | ForEach-Object { $_ -replace " ", "" } | fzf | ForEach-Object { git merge --no-ff $_ } }

# git log
function gls()   { git log -3}
function gll()   { git log -10 --oneline --all --graph --decorate }
function glll()  { git log --graph --all --date=format:'%Y-%m-%d %H:%M' --pretty=format:'%C(auto)%d%Creset\ %C(yellow)%h%Creset %C(magenta)%ae%Creset %C(cyan)%ad%Creset%n%C(white bold)%w(80)%s%Creset%n%b' }
function glls()  { git log --graph --all --date=format:'%Y-%m-%d %H:%M' --pretty=format:'%C(auto)%d%Creset\ %C(yellow)%h%Creset %C(magenta)%ae%Creset %C(cyan)%ad%Creset%n%C(white bold)%w(80)%s%Creset%n%b' -10}

# git status
function gs()  { git status --short }
function gss() { git status -v }

# explorer
function e() { explorer $args }

# ffmpeg
function ffmp4red() { ffmpeg -i $args[0] -vcodec libx264 -crf 20 $args[1] }
function ff256() { ffmpeg -i $args[0] -filter_complex "[0:v] split [a][b];[a] palettegen [p];[b][p] paletteuse" $args[1] }
function ffresize() { $width = $args[1]; ffmpeg -i $args[0] -vf scale=$width":-1" $args[2] }
function fffavicon() { $width = $args[1]; ffmpeg -i $args[0] -vf scale=$width":-1" favicon.ico }
function ffjpeg() { ffmpeg -i $args[0] -vf scale=1280":-1" $args[0] }

# broot
function bo() { broot -g --conf $env:USERPROFILE\broot.toml $args }
function br() {
  $outcmd = new-temporaryfile
  bo --outcmd $outcmd $args
  if (!$?) {
    remove-item -force $outcmd
    return $lastexitcode
  }

  $command = get-content $outcmd
  if ($command) {
    # workaround - paths have some garbage at the start
    $command = $command.replace("\\?\", "", 1)
    invoke-expression $command
  }
  remove-item -force $outcmd
}

#-----------------------------------------------------
# Golang
#-----------------------------------------------------

$env:GO111MODULE = "on"

#-----------------------------------------------------
# Execution PATHs
#-----------------------------------------------------

$env:PATH += ";" + $env:LOCALAPPDATA + "\JetBrains\Toolbox\apps\IDEA-U\ch-0\212.5080.55\bin"
$env:PATH += ";" + $env:USERPROFILE + "\git\bitbucket.org\ntj-developer\diamant\target\release"
