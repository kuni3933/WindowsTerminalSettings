@echo off
chcp 932

IF NOT DEFINED WindowsTerminalSettings (
    echo ���ϐ�:WindowsTerminalSettings ����`����Ă��Ȃ����߃T�u���W���[����pull���o���܂���.
    echo ���[�U�[���ϐ�:WindowsTerminalPreview��ݒ肵�Ă�������.
    echo SubModule cannot be pulled because the user environment variable: WindowsTerminalSettings is not defined.
    echo Set the user environment variable: WindowsTerminalPreview.
    goto :end
)
IF  DEFINED WindowsTerminalSettings (
    cd %WindowsTerminalSettings%
    call :******************** ���݂̃T�u���W���[���X�e�[�^�X / Current submodule status
    git submodule status
    echo:
    call :******************** Pull��̃T�u���W���[���X�e�[�^�X / Submodule status after Pull
    git submodule foreach git fetch
    git submodule foreach git pull origin master
    git submodule status
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
