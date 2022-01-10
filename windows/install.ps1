. "${PSScriptRoot}/Function.ps1"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
$MyPath = Split-Path -Parent $MyInvocation.MyCommand.Path
# 参考:https://www.serotoninpower.club/archives/355/#%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8
#https://bayashita.com/p/entry/show/47
if(Test-Path "$MyPath/../../WindowsTerminalSettings"){
    _Write_Section("Start")
}
else{
    _Write_Section("Error")
    exit
}

#_Write_Section("PSGallery/install.ps1")
Invoke-Expression "$MyPath/PSGallery/install.ps1"
_br(2)

#_Write_Section("winget/install.ps1")
Invoke-Expression "$MyPath/winget/install.ps1"
_br(2)

#_Write_Section("scoop/install.ps1")
Invoke-Expression "$MyPath/scoop/install.ps1"
_br(2)

#_Write_Section("Chocolatey/install.ps1")
Invoke-Expression "$MyPath/Chocolatey/install.ps1"
_br(2)

#_Write_Section("volta-npm/install.ps1")
Invoke-Expression "$MyPath/volta-npm/install.ps1"
_br(2)

#_Write_Section("go/install.ps1")
Invoke-Expression "$MyPath/go/install.ps1"
_br(2)

#_Write_Section("cargo/install.ps1")
Invoke-Expression "$MyPath/cargo/install.ps1"
_br(2)

#_Write_Section("gh/install.ps1")
Invoke-Expression "$MyPath/gh/install.ps1"
_br(2)


_Set_ExecutionPolicy
_br(2)

_Write_Section("isntall.ps1 is Finished.")
_br(2)

