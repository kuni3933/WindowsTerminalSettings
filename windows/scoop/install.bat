@echo off
chcp 932
rem :tmp�𓮂������ƂŎ��s�J�n�ӏ��𐧌�. �f�o�b�O�⓮��m�F�p
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
echo ������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������
echo �� %*
echo ������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������
exit /b

:end
echo:
echo ENTER�������āA���̃y�[�W�ɐi�݂܂��B
echo Press ENTER to go to the next page.
set /P input_tmp=":"
chcp 65001
