@echo off
chcp 65001
rem ------------------------------------------------------------------------------------------------------変数/パスのセット処理
cd "%~dp0../"
set WindowsTerminalSettings=%CD%
set WINDOWS=%WindowsTerminalSettings%\windows
set WINDOWS_MNT=%WindowsTerminalSettings%\mnt\windows
set LINUX_MNT=%WindowsTerminalSettings%\mnt\linux
set COMMON_MNT=%WindowsTerminalSettings%\mnt\common

set owl-playbook_WINDOWS=%WindowsTerminalSettings%\owl-playbook\windows
set owl-playbook_WINDOWS_MNT=%WindowsTerminalSettings%\owl-playbook\mnt\windows
set owl-playbook_LINUX_MNT=%WindowsTerminalSettings%\owl-playbook\mnt\linux
set owl-playbook_COMMON_MNT=%WindowsTerminalSettings%\owl-playbook\mnt\common

set dotfiles=%WindowsTerminalSettings%\dotfiles

set pipes.sh=%WindowsTerminalSettings%\pipes.sh\pipes.sh
set pipes_rs=%WindowsTerminalSettings%\mnt\windows\.config\pipes-rs
set winfetch_=%WindowsTerminalSettings%\mnt\windows\.config\winfetch

set ROAMING=%USERPROFILE%\AppData\Roaming
set LOCAL=%USERPROFILE%\AppData\Local
set SCOOP=%USERPROFILE%\scoop



rem :tmpを動かすことで実行開始箇所を制御. デバッグや動作確認用
goto :tmp
:tmp
rem ------------------------------------------------------------------------------------------------------メイン処理
:Main
If not exist "%USERPROFILE%\.config" mkdir "%USERPROFILE%\.config"

call :******************** "pipes.sh/pipes-rs & winfetch"
call :link_file "%USERPROFILE%\pipes.sh" "%pipes.sh%"
call :link_dir "%USERPROFILE%\.config\pipes-rs" "%pipes_rs%"
call :link_dir "%USERPROFILE%\.config\winfetch" "%winfetch_%"

call :******************** neovim
call :link_file "%USERPROFILE%\.vimrc" "%WINDOWS_MNT%\.vimrc"
call :link_dir "%LOCAL%\nvim" "%WINDOWS_MNT%\LOCALAPPDATA\nvim"
rem call :link_file "%LOCAL%\nvim\colors.toml" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\colors.toml"
rem call :link_file "%LOCAL%\nvim\dein.toml" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\dein.toml"
rem call :link_file "%LOCAL%\nvim\ginit.vim" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\ginit.vim"
rem call :link_file "%LOCAL%\nvim\init.vim" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\init.vim"
rem call :link_file "%LOCAL%\nvim\joke.toml" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\joke.toml"
rem call :link_file "%LOCAL%\nvim\lightlinerc.vim" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\lightlinerc.vim"
rem call :link_file "%LOCAL%\nvim\lsp.toml" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\lsp.toml"
rem call :link_file "%LOCAL%\nvim\skkeletonrc.vim" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\skkeletonrc.vim"
rem If not exist "%USERPROFILE%\.config\nvim" mkdir "%USERPROFILE%\.config\nvim"
rem call :link_file "%USERPROFILE%\.config\nvim\colors.toml" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\colors.toml"
rem call :link_file "%USERPROFILE%\.config\nvim\dein.toml" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\dein.toml"
rem call :link_file "%USERPROFILE%\.config\nvim\ginit.vim" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\ginit.vim"
rem call :link_file "%USERPROFILE%\.config\nvim\init.vim" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\init.vim"
rem call :link_file "%USERPROFILE%\.config\nvim\joke.toml" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\joke.toml"
rem call :link_file "%USERPROFILE%\.config\nvim\lightlinerc.vim" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\lightlinerc.vim"
rem call :link_file "%USERPROFILE%\.config\nvim\lsp.toml" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\lsp.toml"
rem call :link_file "%USERPROFILE%\.config\nvim\skkeletonrc.vim" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\skkeletonrc.vim"

call :******************** Copying_gitconfig
set ORIGIN_gitconfig="%WindowsTerminalSettings%\windows\gitconfig"
xcopy "%ORIGIN_gitconfig%" "%GIT_INSTALL_ROOT%\etc\gitconfig"

call :******************** "GitHub_CLI_config.yml"
set ORIGIN_ghconfig="%WINDOWS_MNT%\ROAMINGAPPDATA\GitHub_CLI\config.yml"
If not exist "%ROAMING%\GitHub CLI" mkdir "%ROAMING%\GitHub CLI"
call :link_file "%ROAMING%\GitHub CLI\config.yml" "%ORIGIN_ghconfig%"

call :******************** "bat"
set ORIGIN_bat="%WINDOWS_MNT%\ROAMINGAPPDATA\bat"
call :link_dir "%ROAMING%\bat" "%ORIGIN_bat%"

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
set POWER_SHELL_ORIGIN_DIR=%WINDOWS_MNT%\Documents\PowerShell
set POWER_SHELL_DIR=%USERPROFILE%\Documents\PowerShell
If not exist "%USERPROFILE%\Documents" mkdir %USERPROFILE%\Documents"
If not exist "%USERPROFILE%\Documents\PowerShell" mkdir %USERPROFILE%\Documents\PowerShell"
call :link_file "%USERPROFILE%\.oh-my-posh.json" %WINDOWS_MNT%\.oh-my-posh.json
call :link_file "%USERPROFILE%\.config\starship.toml" "%WINDOWS_MNT%\.config\starship.toml"
call :link_file "%POWER_SHELL_DIR%\Microsoft.PowerShell_profile.ps1" "%POWER_SHELL_ORIGIN_DIR%\Microsoft.PowerShell_profile.ps1"


call :******************** Windows Terminal Preview

set TERMINAL_ORIGIN_DIR=%WINDOWS_MNT%\LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState
call :link_file "%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json" "%TERMINAL_ORIGIN_DIR%\settings.json"

call :******************** winget

set WINGET_ORIGIN_DIR=%WINDOWS_MNT%\LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState
call :link_file "%LOCALAPPDATA%\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json" "%WINGET_ORIGIN_DIR%\settings.json"

call :******************** Keypirinha

set KEYPIRINHA_ORIGIN_DIR=%WINDOWS_MNT%\scoop\persist\keypirinha\portable\Profile\User
call :link_file "%SCOOP%\persist\keypirinha\portable\Profile\User\Keypirinha.ini" "%KEYPIRINHA_ORIGIN_DIR%\Keypirinha.ini"

call :******************** To be continued.. (Not administrator

echo Install Tablacus Explorer manually!
echo Clone...
echo   * spinal-reflex-bindings-template
echo Create a shortcut of Xlaunch in `Star Menu / Program` with a to-link as following.
echo   * ex: %USERPROFILE%\scoop\apps\vcxsrv\current\xlaunch.exe -run %WindowsTerminalSettings%\windows\config.xlaunch
set config_xlaunch="%WindowsTerminalSettings%\windows\config.xlaunch"
call :link_file "%APPDATA%\Microsoft\Windows\Start Menu\Programs\config.xlaunch" "%config_xlaunch%"
call :link_file "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\config.xlaunch" "%config_xlaunch%"

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
