. "${PSScriptRoot}/Function.ps1"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# DirectoryPath/FilePath
${WindowsTerminalSettings} = "${PSScriptRoot}/../"
#参考 https://www.ipentec.com/document/windows-powershell-create-directory
#参考:https://www.vwnet.jp/Windows/PowerShell/pwd.htm
${WINDOWS} = "${WindowsTerminalSettings}/windows/"
${WINDOWS_MNT} = "${WindowsTerminalSettings}/mnt/windows/"
${LINUX_MNT} = "${WindowsTerminalSettings}/mnt/linux/"
${COMMON_MNT} = "${WindowsTerminalSettings}/mnt/common/"

${owl_playbook_WINDOWS} = "${WindowsTerminalSettings}/owl-playbook/windows/"
${owl_playbook_WINDOWS_MNT} = "${WindowsTerminalSettings}/owl-playbook/mnt/windows/"
${owl_playbook_LINUX_MNT} = "${WindowsTerminalSettings}/owl-playbook/mnt/linux/"
${owl_playbook_COMMON_MNT} = "${WindowsTerminalSettings}/owl-playbook/mnt/common/"

${dotfiles} = "${WindowsTerminalSettings}/dotfiles/"

${pipes.sh} = "${WindowsTerminalSettings}/pipes.sh/pipes.sh"
${pipes_rs} = "${WindowsTerminalSettings}/mnt/windows/.config/pipes-rs/"

${winfetch_} = "${WindowsTerminalSettings}/mnt/windows/.config/winfetch/"

${ROAMING} = "${env:USERPROFILE}/AppData/Roaming/"
${LOCAL} = "${env:USERPROFILE}/AppData/Local/"
${SCOOP} = "${env:USERPROFILE}/scoop/"


# Function
_link_file(${Link},${Target}) {
    if (Test-Path -Path ${Target}) {
        if (Test-Path -Path ${Link}) {
          if((Get-Item ${Target}).PSIsContainer){
            _Write_Title "Target"
          }else{
            _File_ToRecycleBin ${Link}
            cmd /c mklink ${Link} ${Target}
          }
          #参考:https://cmdbayashita.com/p/entry/show/229
        }
    }
    else{
        Write-Host "Target File not found: ${Target}"
    }
}

_link_dir(${Link},${Target}) {
    if (Test-Path -Path ${Target}) {
        if (Test-Path -Path ${Link}) {
          if((Get-Item ${Target}).PSIsContainer){
            _Write_Title "Error=> T is a Directory; | Error Function : _link_dir"
          }else{
            _File_ToRecycleBin ${link}
            cmd /c mklink ${link} ${target}
          }
          #参考:https://cmdbayashita.com/p/entry/show/229
        }
    }
    else{
        Write-Host "Error=> File not found: ${target}"
    }
}

<#
:link_file
del %1
Mklink %1 %2
exit /b

:link_dir
rd /s /q %1
Mklink /D %1 %2
exit /b
#>
# ---------------------------------------------------------------------------------------------
#                                   Title
# ---------------------------------------------------------------------------------------------
_Write_Title "provision.ps1"

# ---------------------------------------------------------------------------------------------
#                                   Main
# ---------------------------------------------------------------------------------------------
_Write_Section "pipes.sh/pipes-rs & winfetch"
call :link_file "%USERPROFILE%\pipes.sh" "%pipes.sh%"
call :link_dir "%USERPROFILE%\.config\pipes-rs" "%pipes_rs%"
call :link_dir "%USERPROFILE%\.config\winfetch" "%winfetch_%"

call :******************** neovim
call :link_file "%USERPROFILE%\.vimrc" "%WINDOWS_MNT%\.vimrc"
If not exist "%LOCALAPPDATA%\nvim" mkdir "%LOCALAPPDATA%\nvim"
call :link_file "%LOCAL%\nvim\colors.toml" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\colors.toml"
call :link_file "%LOCAL%\nvim\dein.toml" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\dein.toml"
call :link_file "%LOCAL%\nvim\ginit.vim" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\ginit.vim"
call :link_file "%LOCAL%\nvim\init.vim" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\init.vim"
call :link_file "%LOCAL%\nvim\joke.toml" "%WINDOWS_MNT%\LOCALAPPDATA\nvim\joke.toml"

call :******************** Copying_gitconfig
set ORIGIN_gitconfig="%WindowsTerminalSettings%\windows\gitconfig"
xcopy "%ORIGIN_gitconfig%" "%GIT_INSTALL_ROOT%\etc\gitconfig"

call :******************** "GitHub_CLI_config.yml"
set ORIGIN_ghconfig="%WINDOWS_MNT%\ROAMINGAPPDATA\GitHub_CLI\config.yml"
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

call :link_file "%USERPROFILE%\.oh-my-posh.json" %WINDOWS_MNT%\.oh-my-posh.json
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

call :******************** Broot

call :link_file "%USERPROFILE%\broot.toml" "%WINDOWS_MNT%\broot.toml"

call :******************** git config
rem �O���[�o��(���[�U�[)�ݒ�
git config --global core.preloadindex true
git config --global core.fscache true
git config --global core.autoCRLF false
git config --global merge.ff false
git config --global pull.ff only
rem ���{��p�X�̕��������h�~�΍�
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
echo   * ex: %USERPROFILE%\scoop\apps\vcxsrv\current\xlaunch.exe -run %WindowsTerminalSettings%\windows\config.xlaunch
set xlaunch_Shortcut="%WindowsTerminalSettings%\windows\xlaunch.exe.lnk"
copy "%xlaunch_Shortcut%" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\xlaunch.exe.lnk"

goto :end



rem  ------------------------------------------------------------------------------------------------------
rem  --------------------------------�ȉ��g�p����֐�----------------------------------------------------
rem  ------------------------------------------------------------------------------------------------------

rem ------------------------------------------------------------------------------------------------------���C�������̊֐�
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



:each
@FOR /F "usebackq" %%t IN (`bat %2`) DO call :%1 %%t
exit /b

:********************
echo ������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������
echo �� %*
echo ������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������
exit /b

REM �r���Ŏ~�߂����ꍇ�͂�����..
:end
echo:
pause
chcp 65001
echo 'provision.bat' has finished.