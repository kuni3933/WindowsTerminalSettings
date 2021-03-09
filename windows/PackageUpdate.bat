@echo off
rem 各パスのセット
set LINUX="%~dp0..\linux"
set WINDOWS="%~dp0..\windows"

set owl-playbook_LINUX="%~dp0..\owl-playbook\linux"
set owl-playbook_WINDOWS="%~dp0..\owl-playbook\windows"
rem -------------------------------------------------------------------------------------------------
set WINDOWS_MNT="%~dp0..\mnt\windows"
set LINUX_MNT="%~dp0..\mnt\linux"
set COMMON_MNT="%~dp0..\mnt\common"

set owl-playbook_WINDOWS_MNT="%~dp0..\owl-playbook\mnt\windows"
set owl-playbook_LINUX_MNT="%~dp0..\owl-playbook\mnt\linux"
set owl-playbook_COMMON_MNT="%~dp0..\owl-playbook\mnt\common"
rem --------------------------------------------------------------------------------------------------
rem 以下メイン処理

rem :tmpを動かすことで実行開始箇所を制御. デバッグや動作確認用
goto :tmp
:tmp
call :******************** copy_Linux
call :copy_Linux
call :******************** copy_Windows
call :copy_Windows

call :******************** copy_Windows_MNT
call :copy_Windows_MNT
call :******************** copy_linux_MNT
call :copy_linux_MNT
call :******************** copy_Common_MNT
call :copy_Common_MNT

goto :end
rem -----------------------------------------------------------------------------------------------
rem 各関数

:copy_Linux
xcopy %owl-playbook_LINUX% %LINUX% /E
exit /b

:copy_Windows
xcopy %owl-playbook_WINDOWS%\go %WINDOWS%\go /E
xcopy %owl-playbook_WINDOWS%\npm %WINDOWS%\npm /E
xcopy %owl-playbook_WINDOWS%\ubuntu %WINDOWS%\ubuntu /E
xcopy %owl-playbook_WINDOWS%\idea-files.txt %WINDOWS%\idea-files.txt
xcopy %owl-playbook_WINDOWS%\vscode-extensions.txt %WINDOWS%\vscode-extensions.txt
xcopy %owl-playbook_WINDOWS%\windows-home-dots.txt %WINDOWS%\windows-home-dots.txt
exit /b

:copy_Windows_MNT
xcopy %owl-playbook_WINDOWS_MNT%\keypirinha %WINDOWS_MNT%\keypirinha /E
xcopy %owl-playbook_WINDOWS_MNT%\wsl %WINDOWS_MNT%\wsl /E
xcopy %owl-playbook_WINDOWS_MNT%\.minttyrc %WINDOWS_MNT%\.minttyrc
xcopy %owl-playbook_WINDOWS_MNT%\.vimrc %WINDOWS_MNT%\.vimrc
xcopy %owl-playbook_WINDOWS_MNT%\broot.toml %WINDOWS_MNT%\broot.toml
exit /b

:copy_linux_MNT
xcopy %owl-playbook_LINUX_MNT% %LINUX_MNT% /E
exit /b

:copy_Common_MNT
xcopy %owl-playbook_COMMON_MNT%\.vim-snippets %COMMON_MNT%\.vim-snippets
xcopy %owl-playbook_COMMON_MNT%\IntelliJIdea %COMMON_MNT%\IntelliJIdea
exit /b

:********************
echo ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo ┃ %*
echo ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
exit /b

REM 途中で止めたい場合はここに..
:end
