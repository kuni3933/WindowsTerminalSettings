@echo off
chcp 932

rem Repositoryの場所を指定
SET WindowsTerminalSettings="%USERPROFILE%\WindowsTerminalSettings"

rem Repositoryが存在しない場合
IF NOT EXIST %WindowsTerminalSettings% (
    echo Repository:WindowsTerminalSettings が%USERPROFILE%に存在しないないためサブモジュールのpullが出来ません.
    echo Repository:WindowsTerminalSettings を%USERPROFILE%にgit cloneして配置してください.
    echo Cannot pull submodules because Repository:WindowsTerminalSettings does not exist in %USERPROFILE%.
    echo Git clone Repository:WindowsTerminalSettings to %USERPROFILE% and place it there.
    echo Reference:https://github.com/kuni3933/WindowsTerminalSettings
    goto :end
)
rem Repositoryが存在する場合
IF EXIST %WindowsTerminalSettings% (
    cd %WindowsTerminalSettings%
    call :******************** 現在のサブモジュールステータス / Current submodule status
    git submodule status
    echo:
    echo:
    call :******************** Pull後のサブモジュールステータス / Submodule status after Pull
    git submodule foreach git fetch
    echo:
    git submodule foreach git pull origin master
    echo:
    git submodule status
    echo:
    echo Pull is complete.
    echo:
    goto :end
)

:********************
echo ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo ┃ %*
echo ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
exit /b


:end
echo:
call :******************** このPull_SubModule.batが終了した後にprovision.batを実行してください.
call :******************** After this Pull_SubModule.bat is finished, please run provision.bat.
pause
chcp 65001
echo 'Pull_SubModule.bat' has finished.
