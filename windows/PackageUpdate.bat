@echo off

set WINDOWS_MNT="%~dp0..\mnt\windows"
set LINUX_MNT="%~dp0..\mnt\linux"
set COMMON_MNT="%~dp0..\mnt\common"

set owl-playbook_WINDOWS_MNT="%~dp0..\..\owl-playbook\mnt\windows"
set owl-playbook_LINUX_MNT="%~dp0..\..\owl-playbook\mnt\linux"
set owl-playbook_COMMON_MNT="%~dp0..\..\owl-playbook\mnt\common"


rem :tmpを動かすことで実行開始箇所を制御. デバッグや動作確認用
goto :tmp
:tmp

call :copy_Windows_MNT
call :copy_linux_MNT
call :copy_Common_MNT

goto :end
rem ---------------------------------------------------------

:copy_Windows_MNT
copy %owl-playbook_WINDOWS_MNT%/keypirinha %WINDOWS_MNT%/keypirinha
copy %owl-playbook_WINDOWS_MNT%/wsl %WINDOWS_MNT%/wsl
copy %owl-playbook_WINDOWS_MNT%/.bashrc %WINDOWS_MNT%/.bashrc
copy %owl-playbook_WINDOWS_MNT%/.minttyrc %WINDOWS_MNT%/.minttyrc
copy %owl-playbook_WINDOWS_MNT%/.vimrc %WINDOWS_MNT%/.vimrc
copy %owl-playbook_WINDOWS_MNT%/broot.toml %WINDOWS_MNT%/broot.toml
exit /b

:copy_linux_MNT
copy %owl-playbook_LINUX_MNT% %LINUX_MNT%
exit /b

:copy_Common_MNT
copy %owl-playbook_COMMON_MNT% %COMMON_MNT%
exit /b

REM 途中で止めたい場合はここに..
:end
