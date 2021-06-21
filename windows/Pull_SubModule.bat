@echo off
chcp 932

rem Repository�̏ꏊ���w��
SET WindowsTerminalSettings="%USERPROFILE%\WindowsTerminalSettings"

rem Repository�����݂��Ȃ��ꍇ
IF NOT EXIST %WindowsTerminalSettings% (
    echo Repository:WindowsTerminalSettings ��%USERPROFILE%�ɑ��݂��Ȃ��Ȃ����߃T�u���W���[����pull���o���܂���.
    echo Repository:WindowsTerminalSettings ��%USERPROFILE%��git clone���Ĕz�u���Ă�������.
    echo Cannot pull submodules because Repository:WindowsTerminalSettings does not exist in %USERPROFILE%.
    echo Git clone Repository:WindowsTerminalSettings to %USERPROFILE% and place it there.
    echo Reference:https://github.com/kuni3933/WindowsTerminalSettings
    goto :end
)
rem Repository�����݂���ꍇ
IF EXIST %WindowsTerminalSettings% (
    cd %WindowsTerminalSettings%
    call :******************** ���݂̃T�u���W���[���X�e�[�^�X / Current submodule status
    git submodule status
    echo:
    echo:
    call :******************** Pull��̃T�u���W���[���X�e�[�^�X / Submodule status after Pull
    git submodule foreach git fetch
    echo:
    git submodule foreach git pull origin master
    echo:
    git submodule status
    echo:
    echo Pull is complete.
    echo:
    goto :end
)

:********************
echo ������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������
echo �� %*
echo ������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������
exit /b


:end
echo:
call :******************** ����Pull_SubModule.bat���I���������provision.bat�����s���Ă�������.
call :******************** After this Pull_SubModule.bat is finished, please run provision.bat.
pause
chcp 65001
echo 'Pull_SubModule.bat' has finished.
