@echo off

set ORIGIN_gitconfig="%~dp0..\..\gitconfig"
xcopy %ORIGIN_gitconfig% %GIT_INSTALL_ROOT%\etc\gitconfig
%USERPROFILE%\scoop\apps\vscode\current\vscode-uninstall-context.reg
%USERPROFILE%\scoop\apps\vscode\current\vscode-install-context.reg
