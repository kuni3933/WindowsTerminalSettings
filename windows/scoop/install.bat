@echo off
chcp 932
rem :tmpを動かすことで実行開始箇所を制御. デバッグや動作確認用
goto :tmp
:tmp

call :******************** xcopy-gitconfig
set ORIGIN_gitconfig="%~dp0..\..\gitconfig"
xcopy %ORIGIN_gitconfig% %GIT_INSTALL_ROOT%\etc\gitconfig

call :******************** registry registration VSCode
%USERPROFILE%\scoop\apps\vscode\current\vscode-uninstall-context.reg
%USERPROFILE%\scoop\apps\vscode\current\vscode-install-context.reg

goto :end


:********************
echo ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo ┃ %*
echo ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
exit /b

:end
echo:
echo ENTERを押して、次のページに進みます。
echo Press ENTER to go to the next page.
set /P input_tmp=":"
chcp 65001
