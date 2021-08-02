function Write_Title($msg) {
  Write-Host "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
  Write-Host "┃$msg" -ForegroundColor Yellow
  Write-Host "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
}
function Write_Section($msg) {
  Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
  Write-Host "  $msg" -ForegroundColor Green
  Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
}
function br($times) {
  $tmp = 1
  while ($tmp -le $times) {
    Write-Output " ";
    $tmp += 1
  }
}
function pull($module,$branch){
    Set-Location "$env:USERPROFILE/WindowsTerminalSettings/$module"
    git pull origin $branch
    br(1)
}

# Repositoryの場所を指定
$WindowsTerminalSettings = "$env:USERPROFILE/WindowsTerminalSettings"
# submodule_list
$module = git config --file .gitmodules --get-regexp path | awk '{print $ 2}'
Write-Host $module
# Repositoryが存在しない場合
if(!(Test-Path $WindowsTerminalSettings)){
    Write-Host  "Repository:WindowsTerminalSettings が%USERPROFILE%に存在しないないためサブモジュールのpullが出来ません."
    Write-Host  "Repository:WindowsTerminalSettings を%USERPROFILE%にgit cloneして配置してください."
    Write-Host  "Cannot pull submodules because Repository:WindowsTerminalSettings does not exist in %USERPROFILE%."
    Write-Host  "Git clone Repository:WindowsTerminalSettings to %USERPROFILE% and place it there."
    Write-Host  "Reference:https://github.com/kuni3933/WindowsTerminalSettings"
    exit
}
# Repositoryが存在する場合
if(Test-Path $WindowsTerminalSettings){
    Set-Location "$env:USERPROFILE/WindowsTerminalSettings"
    Write_Title "現在のサブモジュールステータス / Current submodule status"
    git submodule status
    br(2)

    Write_Title "Pull後のサブモジュールステータス / Submodule status after Pull"
    pull "owl-playbook" "master"
    pull "pipes.sh" "master"
    pull "windotfiles" "main"
    pull "windows-terminal-colorscheme" "master"
    Set-Location "$env:USERPROFILE/WindowsTerminalSettings"
    br(2)

    git submodule status
    br(1)
    Write-Host  Pull is complete.
    br(2)
}

Write_Section "このPull_SubModule.batが終了した後にprovision.batを実行してください."
Write_Section "After this Pull_SubModule.bat is finished, please run provision.bat."
pause
Write-Host  'Pull_SubModule.bat' has finished.


