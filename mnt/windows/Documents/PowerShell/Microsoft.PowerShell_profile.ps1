# ${IsSet} = "${PSScriptRoot}/IsSet.ps1"
# Example of "IsSet" usage
# if ((powershell $IsSet command_name -eq $true) { alias...function... }
# command_name...exa/cat/...etc

#-----------------------------------------------------
# Alias
#-----------------------------------------------------
. "${PSScriptRoot}/Alias.ps1"


#-----------------------------------------------------
# Path
#-----------------------------------------------------
if((Get-Command deno -ea SilentlyContinue) -AND (Test-Path "${env:USERPROFILE}/.deno/bin")) {
  ${env:path} += ";${env:USERPROFILE}/.deno/bin"
}


#-----------------------------------------------------
# General
#-----------------------------------------------------
# PowerShell Core7でもConsoleのデフォルトエンコーディングはsjisなので必要
[System.Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("utf-8")
[System.Console]::InputEncoding = [System.Text.Encoding]::GetEncoding("utf-8")

# git logなどのマルチバイト文字を表示させるため (絵文字含む)
$env:LESSCHARSET = "utf-8"



#-----------------------------------------------------
# PSReadline
#-----------------------------------------------------
Import-Module PSReadLine

# 音を消す
Set-PSReadlineOption -BellStyle None

# 履歴
Set-PSReadLineOption -HistoryNoDuplicates:$true
# 履歴からコマンド読み込みした際のカーソル位置
Set-PSReadLineOption -HistorySearchCursorMovesToEnd:$true

# 予測インテリセンス
#https://docs.microsoft.com/en-us/powershell/module/psreadline/set-psreadlineoption?view=powershell-7.1
#https://serverfault.com/questions/36991/windows-powershell-vim-keybindings
#https://docs.microsoft.com/ja-jp/powershell/module/psreadline/about/about_psreadline?view=powershell-7.1
Set-PSReadLineOption -PredictionSource HistoryAndPlugin

# 単語区切り
#https://qiita.com/AWtnb/items/5551fcc762ed2ad92a81#%E5%8D%98%E8%AA%9E%E5%8C%BA%E5%88%87%E3%82%8A
Set-PSReadLineOption -WordDelimiters ";:,.[]{}()/\|^&*-=+'`" !?@#$%&_<>「」（）『』『』［］、，。：；／"

# 括弧／引用符の入力補完
#https://qiita.com/AWtnb/items/5551fcc762ed2ad92a81#%E6%8B%AC%E5%BC%A7%E5%BC%95%E7%94%A8%E7%AC%A6%E3%81%AE%E5%85%A5%E5%8A%9B%E8%A3%9C%E5%AE%8C
Set-PSReadLineKeyHandler -Key "(","{","[" -BriefDescription "InsertPairedBraces" -LongDescription "Insert matching braces or wrap selection by matching braces" -ScriptBlock {
  param($key, $arg)
  $openChar = $key.KeyChar
  $closeChar = switch ($openChar) {
    <#case#> "(" { [char]")"; break }
    <#case#> "{" { [char]"}"; break }
    <#case#> "[" { [char]"]"; break }
  }
  $selectionStart = $null
  $selectionLength = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)
  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($selectionStart -ne -1) {
    [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, $openChar + $line.SubString($selectionStart, $selectionLength) + $closeChar)
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
    return
  }
  $nOpen = [regex]::Matches($line, [regex]::Escape($openChar)).Count
  $nClose = [regex]::Matches($line, [regex]::Escape($closeChar)).Count
  if ($nOpen -ne $nClose) {
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($openChar)
  }
  else {
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($openChar + $closeChar)
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor - 1)
  }
}

# コマンドを括弧で囲む
#https://qiita.com/AWtnb/items/5551fcc762ed2ad92a81#%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E6%8B%AC%E5%BC%A7%E3%81%A7%E5%9B%B2%E3%82%80
Set-PSReadLineKeyHandler -Key "alt+w" -BriefDescription "WrapLineByParenthesis" -LongDescription "Wrap the entire line and move the cursor after the closing parenthesis or wrap selected string" -ScriptBlock {
  $selectionStart = $null
  $selectionLength = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$selectionStart, [ref]$selectionLength)
  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
  if ($selectionStart -ne -1) {
    [Microsoft.PowerShell.PSConsoleReadLine]::Replace($selectionStart, $selectionLength, "(" + $line.SubString($selectionStart, $selectionLength) + ")")
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selectionStart + $selectionLength + 2)
  }
  else {
    [Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, $line.Length, '(' + $line + ')')
    [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
  }
}

# メソッドの補完時に閉じ括弧を忘れない
#https://qiita.com/AWtnb/items/5551fcc762ed2ad92a81#%E3%83%A1%E3%82%BD%E3%83%83%E3%83%89%E3%81%AE%E8%A3%9C%E5%AE%8C%E6%99%82%E3%81%AB%E9%96%89%E3%81%98%E6%8B%AC%E5%BC%A7%E3%82%92%E5%BF%98%E3%82%8C%E3%81%AA%E3%81%84
Remove-PSReadlineKeyHandler "tab"
Set-PSReadLineKeyHandler -Key "tab" -BriefDescription "smartNextCompletion" -LongDescription "insert closing parenthesis in forward completion of method" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::TabCompleteNext()
  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($line[($cursor - 1)] -eq "(") {
    if ($line[$cursor] -ne ")") {
      [Microsoft.PowerShell.PSConsoleReadLine]::Insert(")")
      [Microsoft.PowerShell.PSConsoleReadLine]::BackwardChar()
    }
  }
}
Remove-PSReadlineKeyHandler "shift+tab"
Set-PSReadLineKeyHandler -Key "shift+tab" -BriefDescription "smartPreviousCompletion" -LongDescription "insert closing parenthesis in backward completion of method" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::TabCompletePrevious()
  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($line[($cursor - 1)] -eq "(") {
    if ($line[$cursor] -ne ")") {
      [Microsoft.PowerShell.PSConsoleReadLine]::Insert(")")
      [Microsoft.PowerShell.PSConsoleReadLine]::BackwardChar()
    }
  }
}

# プロファイルの再読み込み
#https://qiita.com/AWtnb/items/5551fcc762ed2ad92a81#%E3%83%97%E3%83%AD%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E5%86%8D%E8%AA%AD%E3%81%BF%E8%BE%BC%E3%81%BF
Set-PSReadLineKeyHandler -Key "alt+r" -BriefDescription "reloadPROFILE" -LongDescription "reloadPROFILE" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert('<#SKIPHISTORY#> . $PROFILE')
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

# 直前に使用した変数を利用する
#https://qiita.com/AWtnb/items/5551fcc762ed2ad92a81#%E7%9B%B4%E5%89%8D%E3%81%AB%E4%BD%BF%E7%94%A8%E3%81%97%E3%81%9F%E5%A4%89%E6%95%B0%E3%82%92%E5%88%A9%E7%94%A8%E3%81%99%E3%82%8B
Set-PSReadLineKeyHandler -Key "alt+a" -BriefDescription "yankLastArgAsVariable" -LongDescription "yankLastArgAsVariable" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$")
  [Microsoft.PowerShell.PSConsoleReadLine]::YankLastArg()
  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
  if ($line -match '\$\$') {
    $newLine = $line -replace '\$\$', "$"
    [Microsoft.PowerShell.PSConsoleReadLine]::Replace(0, $line.Length, $newLine)
  }
}

# クリップボード内容を変数に格納する
#https://qiita.com/AWtnb/items/5551fcc762ed2ad92a81#%E3%82%AF%E3%83%AA%E3%83%83%E3%83%97%E3%83%9C%E3%83%BC%E3%83%89%E5%86%85%E5%AE%B9%E3%82%92%E5%A4%89%E6%95%B0%E3%81%AB%E6%A0%BC%E7%B4%8D%E3%81%99%E3%82%8B
Set-PSReadLineKeyHandler -Key "ctrl+shift+V" -BriefDescription "setClipString" -LongDescription "setClipString" -ScriptBlock {
  $command = "<#SKIPHISTORY#> get-clipboard | sv CLIPPING"
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
  [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory('$CLIPPING ')
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

# (optional) Ctrl+f 入力で前方1単語進む : 補完の確定に使う用
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function ForwardWord
Set-PSReadLineKeyHandler -Key "UpArrow" -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key "Ctrl+o" -Function MenuComplete

# Key binding
# Emacs
#Set-PSReadLineOption -EditMode Emacs
# Vim
#Set-PSReadLineOption -EditMode Vi
# Windowsベース
Set-PSReadLineOption -EditMode Windows


#-----------------------------------------------------
# PSFzf
#-----------------------------------------------------
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'


#-----------------------------------------------------
# Scoop completion
#-----------------------------------------------------
Import-Module "$($(Get-Item $(Get-Command scoop).Path).Directory.Parent.FullName)/modules/scoop-completion"


#-----------------------------------------------------
# Chololatey completion
#-----------------------------------------------------
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "${env:ChocolateyInstall}/helpers/chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

#-----------------------------------------------------
# volta tab-completions
#-----------------------------------------------------
(& volta completions powershell) | Out-String | Invoke-Expression


#-----------------------------------------------------
# starship
#-----------------------------------------------------
# ~/.config/starship.toml
Invoke-Expression (&starship init powershell)


#-----------------------------------------------------
# Golang
#-----------------------------------------------------
$env:GO111MODULE = "on"


#-----------------------------------------------------
# Execution PATHs
#-----------------------------------------------------
#$env:PATH += ";" + $env:LOCALAPPDATA + "\JetBrains\Toolbox\apps\IDEA-U\ch-0\212.5080.55\bin"
#$env:PATH += ";" + $env:USERPROFILE + "\git\bitbucket.org\ntj-developer\diamant\target\release"


#-----------------------------------------------------
# Startup
#-----------------------------------------------------
if (((Get-Random 2) -eq 0) -AND (Get-Command pipes-rs -ea SilentlyContinue)) {
  pipes-rs
}
elseif (Get-Command rusty-rain -ea SilentlyContinue) {
  rusty-rain -C 0,180,200 -H 255,255,255 -s
}
winfetch.PS1
