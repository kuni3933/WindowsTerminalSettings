@echo off
chcp 932
rem ------------------------------------------------------------------------------------------------------変数/パスのセット処理
set WINDOWS="%~dp0..\windows"

set owl-playbook_WINDOWS="%~dp0..\owl-playbook\windows"

set WINDOWS_MNT="%~dp0..\mnt\windows"
set LINUX_MNT="%~dp0..\mnt\linux"
set COMMON_MNT="%~dp0..\mnt\common"

set dotfiles="%~dp0..\dotfiles"

set owl-playbook_WINDOWS_MNT="%~dp0..\owl-playbook\mnt\windows"
set owl-playbook_LINUX_MNT="%~dp0..\owl-playbook\mnt\linux"
set owl-playbook_COMMON_MNT="%~dp0..\owl-playbook\mnt\common"

set pipes.sh="%~dp0..\pipes.sh\pipes.sh"
set pipes-rs="%~dp0..\mnt\windows\pipes-rs"


set ROAMING="%USERPROFILE%\AppData\Roaming"
set LOCAL="%USERPROFILE%\AppData\Local"
set SCOOP="%USERPROFILE%\scoop"



rem :tmpを動かすことで実行開始箇所を制御. デバッグや動作確認用
goto :tmp
:tmp
rem ------------------------------------------------------------------------------------------------------メイン処理
:Main
call :******************** pipes.sh/pipes-rs
call :link_file "%USERPROFILE%\pipes.sh" "%pipes.sh%"
call :link_dir "%USERPROFILE%\.config\pipes-rs" "%pipes-rs%"

call :******************** neovim/init.vim
call :link_file "%LOCAL%\nvim\init.vim" "%WINDOWS_MNT%\.vimrc"
call :link_file "%USERPROFILE%\.vimrc" "%WINDOWS_MNT%\.vimrc"

call :******************** Copying_gitconfig
set ORIGIN_gitconfig="%~dp0..\gitconfig"
xcopy "%ORIGIN_gitconfig%" "%GIT_INSTALL_ROOT%\etc\gitconfig"

call :******************** IntelliJ IDEA

set IDEA_DIR=IntelliJIdea2021.2

set IDEA_ORIGIN_CONFIG_DIR=%COMMON_MNT%\IntelliJIdea\config
set IDEA_CONFIG_DIR=%ROAMING%\JetBrains\%IDEA_DIR%

call :link_idea_dir colors
call :link_idea_dir keymaps
call :link_idea_dir templates
call :link_idea_dir codestyles
call :link_idea_dir inspection
call :link_file "%USERPROFILE%\.ideavimrc" "%COMMON_MNT%\IntelliJIdea\.ideavimrc"

call :each link_idea_file %WINDOWS%\idea-files.txt

call :******************** VS Code

set VSCODE_ORIGIN_USER_DIR=%COMMON_MNT%\VSCode\User
set VSCODE_USER_DIR=%ROAMING%\Code\User

call :link_vscode_file keybindings.json
rem call :link_vscode_file settings.json
call :link_vscode_dir snippets
rem See https://blog.mamansoft.net/2018/09/17/vscode-satisfies-vimmer/
call :each vscode_extension_install %WINDOWS%\vscode-extensions.txt


call :******************** Homedir
call :each link_windows_home %WINDOWS%\windows-home-dots.txt

call :******************** PowerShell Core

set POWER_SHELL_ORIGIN_DIR=%WINDOWS_MNT%\power-shell
set POWER_SHELL_DIR=%USERPROFILE%\Documents\PowerShell

call :link_file "%USERPROFILE%\.oh-my-posh.json" %WINDOWS_MNT%\.oh-my-posh.json
call :link_file "%POWER_SHELL_DIR%\Microsoft.PowerShell_profile.ps1" "%POWER_SHELL_ORIGIN_DIR%\Microsoft.PowerShell_profile.ps1"


call :******************** Windows Terminal Preview

set TERMINAL_ORIGIN_DIR=%WINDOWS_MNT%\terminal
call :link_file "%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json" "%TERMINAL_ORIGIN_DIR%\LocalState\settings.json"

call :******************** winget

set WINGET_ORIGIN_DIR=%WINDOWS_MNT%\winget
call :link_file "%LOCALAPPDATA%\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json" "%WINGET_ORIGIN_DIR%\LocalState\settings.json"

call :******************** Keypirinha

set KEYPIRINHA_ORIGIN_DIR=%WINDOWS_MNT%\keypirinha
call :link_file "%SCOOP%\persist\keypirinha\portable\Profile\User\Keypirinha.ini" "%KEYPIRINHA_ORIGIN_DIR%\User\Keypirinha.ini"

call :******************** Broot

call :link_file "%USERPROFILE%\broot.toml" "%WINDOWS_MNT%\broot.toml"

call :******************** git config
rem グローバル(ユーザー)設定
git config --global core.preloadindex true
git config --global core.fscache true
git config --global core.autoCRLF false
git config --global merge.ff false
git config --global pull.ff only
rem 日本語パスの文字化け防止対策
git config --global core.quotepath false
rem git-delta
git config --global core.pager delta
git config --global core.whitespace cr-at-eol
git config --global delta.syntax-theme Monokai Extended
git config --global delta.line-number true
git config --global delta.side-by-side true
git config --global interactive.diffFilter delta --color-only

call :******************** To be continued.. (Not administrator

echo Install Tablacus Explorer manually!
echo Clone...
echo   * spinal-reflex-bindings-template
echo Create a shortcut of Xlaunch in `Star Menu / Program` with a to-link as following.
echo   * ex: %USERPROFILE%\scoop\apps\vcxsrv\current\xlaunch.exe -run %USERPROFILE%\WindowsTerminalSettings\windows\ubuntu\config.xlaunch
set xlaunch_Shortcut="%~dp0..\windows\xlaunch.exe.lnk"
copy "%xlaunch_Shortcut%" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\xlaunch.exe.lnk"

goto :end



rem  ------------------------------------------------------------------------------------------------------
rem  --------------------------------以下使用する関数----------------------------------------------------
rem  ------------------------------------------------------------------------------------------------------

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
pause
chcp 65001
echo 'provision.bat' has finished.
