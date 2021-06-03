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
:Update_Repository
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


rem ------------------------------------------------------------------------------------------------------メイン処理
:Main
call :******************** pipes.sh/pipes-rs
set pipes.sh="%~dp0..\pipes.sh\pipes.sh"
set pipes-rs="%~dp0..\mnt\windows\pipes-rs"
call :link_file "%USERPROFILE%\pipes.sh" "%pipes.sh%"
call :link_dir "%USERPROFILE%\.config\pipes-rs" "%pipes-rs%"

call :******************** Copying_gitconfig
set ORIGIN_gitconfig="%~dp0..\gitconfig"
xcopy "%ORIGIN_gitconfig%" "%GIT_INSTALL_ROOT%\etc\gitconfig"

call :******************** Obsidian

set OBSIDIAN_ORIGIN_DIR="%USERPROFILE%\Box\obsidian\minerva"
set OBSIDIAN_DIR="%USERPROFILE%\work\minerva"
set OBSIDIAN_CONFIG_DIR="%OBSIDIAN_DIR%\.obsidian"set OBSIDIAN_DIR="%USERPROFILE%\work\minerva\.obsidian"

rem sync.jsonとworkspace以外はすべて
call :link_obsidian_file obsidian.css
call :link_obsidian_file publish.css
call :link_obsidian_file publish.js
call :link_obsidian_file favicon.ico
call :link_obsidian_config_file config
call :link_obsidian_config_file daily-notes.json
call :link_obsidian_config_file global-search.json
call :link_obsidian_config_file graph.json
call :link_obsidian_config_file publish.json
call :link_obsidian_config_dir themes
call :link_obsidian_config_dir snippets
call :link_obsidian_config_dir plugins

call :******************** IntelliJ IDEA

set IDEA_DIR=IntelliJIdea2021.1

set IDEA_ORIGIN_CONFIG_DIR=%COMMON_MNT%\IntelliJIdea\config
set IDEA_CONFIG_DIR=%ROAMING%\JetBrains\%IDEA_DIR%

call :link_idea_dir colors
call :link_idea_dir keymaps
call :link_idea_dir templates
call :link_idea_dir codestyles
call :link_idea_dir inspection
call :link_file "%USERPROFILE%\.ideavimrc" "%COMMON_MNT%\IntelliJIdea\.ideavimrc"

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
xcopy "%WINDOWS_MNT%\broot.toml" "%USERPROFILE%\.config\broot\broot"

call :******************** git config
rem グローバル(ユーザー)設定
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
echo   * ex: %USERPROFILE%\scoop\apps\vcxsrv\current\xlaunch.exe -run %WindowsTerminalSettings%\windows\ubuntu\config.xlaunch
set xlaunch_Shortcut="%~dp0..\windows\xlaunch.exe.lnk"
xcopy "%xlaunch_Shortcut%" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\xlaunch.exe.lnk"

goto :end



rem  ------------------------------------------------------------------------------------------------------
rem  --------------------------------以下使用する関数----------------------------------------------------
rem  ------------------------------------------------------------------------------------------------------


rem ------------------------------------------------------------------------------------------------------更新処理の関数
:copy_Linux
xcopy "%owl-playbook_LINUX%\ansible\roles\check" "%LINUX%\ansible\roles\check" /E /H /S /I
xcopy "%owl-playbook_LINUX%\ansible\roles\clitool" "%LINUX%\ansible\roles\clitool" /E /H /S /I
xcopy "%owl-playbook_LINUX%\ansible\roles\core" "%LINUX%\ansible\roles\core" /E /H /S /I
xcopy "%owl-playbook_LINUX%\ansible\roles\dependency" "%LINUX%\ansible\roles\dependency" /E /H /S /I
xcopy "%owl-playbook_LINUX%\ansible\roles\editor" "%LINUX%\ansible\roles\editor" /E /H /S /I
xcopy "%owl-playbook_LINUX%\ansible\roles\font" "%LINUX%\ansible\roles\font" /E /H /S /I
xcopy "%owl-playbook_LINUX%\ansible\roles\language" "%LINUX%\ansible\roles\language" /E /H /S /I
xcopy "%owl-playbook_LINUX%\ansible\roles\link\bash" "%LINUX%\ansible\roles\link\bash" /E /H /S /I
xcopy "%owl-playbook_LINUX%\ansible\roles\link\bash_it" "%LINUX%\ansible\roles\link\bash_it" /E /H /S /I
xcopy "%owl-playbook_LINUX%\ansible\roles\link\broot" "%LINUX%\ansible\roles\link\broot" /E /H /S /I
xcopy "%owl-playbook_LINUX%\ansible\roles\link\idea" "%LINUX%\ansible\roles\link\idea" /E /H /S /I
xcopy "%owl-playbook_LINUX%\ansible\roles\link\input" "%LINUX%\ansible\roles\link\input" /E /H /S /I
xcopy "%owl-playbook_LINUX%\ansible\roles\link\tig" "%LINUX%\ansible\roles\link\tig" /E /H /S /I
xcopy "%owl-playbook_LINUX%\ansible\roles\link\tmux" "%LINUX%\ansible\roles\link\tmux" /E /H /S /I
xcopy "%owl-playbook_LINUX%\ansible\roles\link\vim" "%LINUX%\ansible\roles\link\vim" /E /H /S /I
xcopy "%owl-playbook_LINUX%\ansible\roles\package_manager" "%LINUX%\ansible\roles\package_manager" /E /H /S /I
xcopy "%owl-playbook_LINUX%\ansible\roles\terminal" "%LINUX%\ansible\roles\terminal" /E /H /S /I
xcopy "%owl-playbook_LINUX%\ansible\ansible.cfg" "%LINUX%\ansible\ansible.cfg"
xcopy "%owl-playbook_LINUX%\ansible\local" "%LINUX%ansible\local"
xcopy "%owl-playbook_LINUX%\ansible\Makefile" "%LINUX%ansible\Makefile"
xcopy "%owl-playbook_LINUX%\lubuntu-base" "%LINUX%\lubuntu-base" /E /H /S /I
xcopy "%owl-playbook_LINUX%\lubuntu-jp" "%LINUX%\lubuntu-jp" /E /H /S /I
xcopy "%owl-playbook_LINUX%\ubuntu" "%LINUX%\ubuntu" /E /H /S /I
exit /b

:copy_Windows
xcopy "%owl-playbook_WINDOWS%\go" "%WINDOWS%\go" /E /H /S /I
xcopy "%owl-playbook_WINDOWS%\npm" "%WINDOWS%\npm" /E /H /S /I
xcopy "%owl-playbook_WINDOWS%\ubuntu" "%WINDOWS%\ubuntu" /E /H /S /I
xcopy "%owl-playbook_WINDOWS%\idea-files.txt" "%WINDOWS%\idea-files.txt"
xcopy "%owl-playbook_WINDOWS%\vscode-extensions.txt" "%WINDOWS%\vscode-extensions.txt"
xcopy "%owl-playbook_WINDOWS%\windows-home-dots.txt" "%WINDOWS%\windows-home-dots.txt"
exit /b

:copy_Windows_MNT
xcopy "%owl-playbook_WINDOWS_MNT%\keypirinha" "%WINDOWS_MNT%\keypirinha" /E /H /S /I
xcopy "%owl-playbook_WINDOWS_MNT%.bashrc" "%WINDOWS_MNT%\.bashrc"
xcopy "%owl-playbook_WINDOWS_MNT%\.minttyrc" "%WINDOWS_MNT%\.minttyrc"
xcopy "%owl-playbook_WINDOWS_MNT%\.oh-my-posh.json" "%WINDOWS_MNT%\.oh-my-posh.json"
xcopy "%owl-playbook_WINDOWS_MNT%\.vimrc" "%WINDOWS_MNT%\.vimrc"
xcopy "%owl-playbook_WINDOWS_MNT%\broot.toml" "%WINDOWS_MNT%\broot.toml"
exit /b

:copy_linux_MNT
xcopy "%owl-playbook_LINUX_MNT%\ubuntu\.bash_it\themes\maman\maman.theme.bash" "%LINUX_MNT%\ubuntu\.bash_it\themes\maman\maman.theme.bash"
xcopy "%owl-playbook_LINUX_MNT%\ubuntu\.vim" "%LINUX_MNT%\ubuntu\.vim" /E /H /S /I
xcopy "%owl-playbook_LINUX_MNT%\ubuntu\.inputrc" "%LINUX_MNT%\ubuntu\.inputrc"
xcopy "%owl-playbook_LINUX_MNT%\ubuntu\.tigrc" "%LINUX_MNT%\ubuntu\.tigrc"
xcopy "%owl-playbook_LINUX_MNT%\ubuntu\.tmux.conf" "%LINUX_MNT%\ubuntu\.tmux.conf"
xcopy "%owl-playbook_LINUX_MNT%\ubuntu\.vimrc" "%LINUX_MNT%\ubuntu\.vimrc"
xcopy "%owl-playbook_LINUX_MNT%\ubuntu\broot.toml" "%LINUX_MNT%\ubuntu\broot.toml"
exit /b

:copy_Common_MNT
xcopy "%owl-playbook_COMMON_MNT%\.vim-snippets" "%COMMON_MNT%\.vim-snippets" /E /H /S /I
xcopy "%owl-playbook_COMMON_MNT%\IntelliJIdea" "%COMMON_MNT%\IntelliJIdea" /E /H /S /I
xcopy "%owl-playbook_COMMON_MNT%\VSCode\User\snippets" "%COMMON_MNT%\VSCode\User\snippets" /E /H /S /I
xcopy "%owl-playbook_COMMON_MNT%\VSCode\User\keybindings.json" "%COMMON_MNT%\VSCode\User\keybindings.json"
exit /b


rem ------------------------------------------------------------------------------------------------------メイン処理の関数
:link_windows_home
call :link_file %USERPROFILE%\%1 %WINDOWS_MNT%\%1
exit /b

:link_obsidian_file
call :link_file %OBSIDIAN_DIR%\%1 %OBSIDIAN_ORIGIN_DIR%\%1
exit /b

:link_obsidian_config_file
call :link_file %OBSIDIAN_CONFIG_DIR%\%1 %OBSIDIAN_ORIGIN_DIR%\%1
exit /b

:link_obsidian_config_dir
call :link_dir %OBSIDIAN_CONFIG_DIR%\%1 %OBSIDIAN_ORIGIN_DIR%\%1

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
