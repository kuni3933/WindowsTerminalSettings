@echo off
chcp 932

IF NOT DEFINED WindowsTerminalSettings (
    echo 環境変数:WindowsTerminalSettings が定義されていないためサブモジュールのpullが出来ません.
    echo ユーザー環境変数:WindowsTerminalPreviewを設定してください.
    echo SubModule cannot be pulled because the user environment variable: WindowsTerminalSettings is not defined.
    echo Set the user environment variable: WindowsTerminalPreview.
    goto :end
)
IF  DEFINED WindowsTerminalSettings (
    cd %WindowsTerminalSettings%
    call :******************** 現在のサブモジュールステータス / Current submodule status
    git submodule status
    echo:
    call :******************** Pull後のサブモジュールステータス / Submodule status after Pull
    git submodule foreach git fetch
    git submodule foreach git pull origin master
    git submodule status
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
