@echo off

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
