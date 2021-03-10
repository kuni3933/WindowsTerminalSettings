@echo off
chcp 932
rem ------------------------------------------------------------------------------------------------------変数/パスのセット処理
set LINUX="%~dp0..\linux"
set WINDOWS="%~dp0..\windows"

set owl-playbook_LINUX="%~dp0..\owl-playbook\linux"
set owl-playbook_WINDOWS="%~dp0..\owl-playbook\windows"


set WINDOWS_MNT="%~dp0..\mnt\windows"
set LINUX_MNT="%~dp0..\mnt\linux"
set COMMON_MNT="%~dp0..\mnt\common"

set owl-playbook_WINDOWS_MNT="%~dp0..\owl-playbook\mnt\windows"
set owl-playbook_LINUX_MNT="%~dp0..\owl-playbook\mnt\linux"
set owl-playbook_COMMON_MNT="%~dp0..\owl-playbook\mnt\common"


set ROAMING="%USERPROFILE%\AppData\Roaming"
set LOCAL="%USERPROFILE%\AppData\Local"
set SCOOP="%USERPROFILE%\scoop"



rem :tmpを動かすことで実行開始箇所を制御. デバッグや動作確認用
goto :tmp
:tmp
rem ------------------------------------------------------------------------------------------------------更新処理
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

call :******************** pipes.sh/pipes.go
set pipes.sh="%~dp0..\pipes.sh\pipes.sh"
set pipes.go="%~dp0..\pipes.go"
call :link_file %USERPROFILE%\pipes.sh %pipes.sh%

call :******************** gitconfig
set ORIGIN_gitconfig="%~dp0..\gitconfig"
xcopy %ORIGIN_gitconfig% %GIT_INSTALL_ROOT%\etc\gitconfig


rem ------------------------------------------------------------------------------------------------------メイン処理
call :******************** IntelliJ IDEA

set IDEA_DIR=IntelliJIdea2020.3

set IDEA_ORIGIN_CONFIG_DIR=%COMMON_MNT%\IntelliJIdea\config
set IDEA_CONFIG_DIR=%ROAMING%\JetBrains\%IDEA_DIR%

call :link_idea_dir colors
call :link_idea_dir keymaps
call :link_idea_dir templates
call :link_idea_dir codestyles
call :link_idea_dir inspection
call :link_file %USERPROFILE%\.ideavimrc %COMMON_MNT%\IntelliJIdea\.ideavimrc

call :each link_idea_file idea-files.txt

call :******************** VS Code

set VSCODE_ORIGIN_USER_DIR=%COMMON_MNT%\VSCode\User
set VSCODE_USER_DIR=%ROAMING%\Code\User

call :link_vscode_file keybindings.json
REM call :link_vscode_file settings.json
call :link_vscode_dir snippets
rem See https://blog.mamansoft.net/2018/09/17/vscode-satisfies-vimmer/
call :each vscode_extension_install vscode-extensions.txt


call :******************** Homedir
call :each link_windows_home windows-home-dots.txt

call :******************** PowerShell Core

set POWER_SHELL_ORIGIN_DIR=%WINDOWS_MNT%\power-shell
set POWER_SHELL_DIR=%USERPROFILE%\Documents\PowerShell

call :link_file %POWER_SHELL_DIR%\Microsoft.PowerShell_profile.ps1 %POWER_SHELL_ORIGIN_DIR%\Microsoft.PowerShell_profile.ps1


call :******************** Windows Terminal Preview

set TERMINAL_ORIGIN_DIR=%WINDOWS_MNT%\terminal
call :link_file %LOCALAPPDATA%\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json %TERMINAL_ORIGIN_DIR%\LocalState\settings.json

call :******************** Keypirinha

set KEYPIRINHA_ORIGIN_DIR=%WINDOWS_MNT%\keypirinha
call :link_file %SCOOP%\persist\keypirinha\portable\Profile\User\Keypirinha.ini %KEYPIRINHA_ORIGIN_DIR%\User\Keypirinha.ini

call :******************** Broot

call :link_file "%USERPROFILE%\broot.toml" %WINDOWS_MNT%\broot.toml


call :******************** git config

git config --global core.preloadindex true
git config --global core.fscache true
git config --global core.autoCRLF false
git config --global merge.ff false
git config --global pull.ff only
rem 日本語パスの文字化け防止対策
git config --global core.quotepath false


call :******************** To be continued.. (Not administrator

echo Install Tablacus Explorer manually!
echo Clone...
echo   * spinal-reflex-bindings-template
echo Create a shortcut of Xlaunch in `Star Menu / Program` with a to-link as following.
echo   * ex: C:\Users\syoum\scoop\apps\vcxsrv\current\xlaunch.exe -run C:\Users\syoum\git\github.com\tadashi-aikawa\owl-playbook\windows\ubuntu\config.xlaunch

goto :end



rem  ------------------------------------------------------------------------------------------------------
rem  --------------------------------以下使用する関数----------------------------------------------------
rem  ------------------------------------------------------------------------------------------------------
rem ------------------------------------------------------------------------------------------------------更新処理の関数
:copy_Linux
xcopy %owl-playbook_LINUX% %LINUX% /E /H /S /I
exit /b

:copy_Windows
xcopy %owl-playbook_WINDOWS%\go %WINDOWS%\go /E /H /S /I
xcopy %owl-playbook_WINDOWS%\npm %WINDOWS%\npm /E /H /S /I
xcopy %owl-playbook_WINDOWS%\ubuntu %WINDOWS%\ubuntu /E /H /S /I
xcopy %owl-playbook_WINDOWS%\idea-files.txt %WINDOWS%\idea-files.txt
xcopy %owl-playbook_WINDOWS%\vscode-extensions.txt %WINDOWS%\vscode-extensions.txt
xcopy %owl-playbook_WINDOWS%\windows-home-dots.txt %WINDOWS%\windows-home-dots.txt
exit /b

:copy_Windows_MNT
xcopy %owl-playbook_WINDOWS_MNT%\keypirinha %WINDOWS_MNT%\keypirinha /E /H /S /I
xcopy %owl-playbook_WINDOWS_MNT%\wsl %WINDOWS_MNT%\wsl /E /H /S /I
xcopy %owl-playbook_WINDOWS_MNT%\.minttyrc %WINDOWS_MNT%\.minttyrc
xcopy %owl-playbook_WINDOWS_MNT%\.vimrc %WINDOWS_MNT%\.vimrc
xcopy %owl-playbook_WINDOWS_MNT%\broot.toml %WINDOWS_MNT%\broot.toml
exit /b

:copy_linux_MNT
xcopy %owl-playbook_LINUX_MNT% %LINUX_MNT% /E /H /S /I
exit /b

:copy_Common_MNT
xcopy %owl-playbook_COMMON_MNT%\.vim-snippets %COMMON_MNT%\.vim-snippets /E /H /S /I
xcopy %owl-playbook_COMMON_MNT%\IntelliJIdea %COMMON_MNT%\IntelliJIdea /E /H /S /I
xcopy %owl-playbook_COMMON_MNT%\VSCode %COMMON_MNT%\VSCode /E /H /S /I
exit /b


rem ------------------------------------------------------------------------------------------------------メイン処理の関数
:link_windows_home
call :link_file %USERPROFILE%\%1 %WINDOWS_MNT%\%1
exit /b

:link_idea_file
call :link_file %IDEA_CONFIG_DIR%\%1 %IDEA_ORIGIN_CONFIG_DIR%\%1
exit /b

:link_idea_dir
call :link_dir %IDEA_CONFIG_DIR%\%1 %IDEA_ORIGIN_CONFIG_DIR%\%1
exit /b

:link_vscode_file
call :link_file %VSCODE_USER_DIR%\%1 %VSCODE_ORIGIN_USER_DIR%\%1
exit /b

:link_vscode_dir
call :link_dir %VSCODE_USER_DIR%\%1 %VSCODE_ORIGIN_USER_DIR%\%1
exit /b

:vscode_extension_install
call code --install-extension %1
exit /b


rem ------------------------------------------------------------------------------------------------------common
:link_file
del %1
Mklink %1 %2
exit /b

:link_dir
rd /s /q %1
Mklink /D %1 %2
exit /b

:each
@FOR /F "usebackq" %%t IN (`bat %2`) DO call :%1 %%t
exit /b

:********************
echo ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo ┃ %*
echo ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
exit /b

REM 途中で止めたい場合はここに..
:end
echo:
echo ENTERを押して終了します。
echo Press ENTER to exit.
set /P =":"
chcp 65001
