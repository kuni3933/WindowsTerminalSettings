function Write_Title($msg) {
  Write-Host "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
  Write-Host "┃$msg" -ForegroundColor Yellow
  Write-Host "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
}
function br($times) {
  $tmp = 1
  while ($tmp -le $times) {
    Write-Output " ";
    $tmp += 1
  }
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
    Set-Location "$env:USERPROFILE/WindowsTerminalSettings/owl-playbook"
    git pull origin master
    br(1)
    Set-Location "$env:USERPROFILE/WindowsTerminalSettings/pipes.sh"
    git pull origin master
    br(1)
    Set-Location "$env:USERPROFILE/WindowsTerminalSettings/windotfiles"
    git pull origin main
    br(1)
    Set-Location "$env:USERPROFILE/WindowsTerminalSettings/windows-terminal-colorscheme"
    git pull master
    br(1)
    Set-Location "$env:USERPROFILE/WindowsTerminalSettings"
    br(1)
    git submodule status
    br(1)
    Write-Host  Pull is complete.
    br(1)
}

br(1)
Write_Title "このPull_SubModule.batが終了した後にprovision.batを実行してください."
Write_Title "After this Pull_SubModule.bat is finished, please run provision.bat."
pause
Write-Host  'Pull_SubModule.bat' has finished.


