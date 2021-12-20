. "./Function.ps1"

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
$MyPath = Split-Path -Parent $MyInvocation.MyCommand.Path
# 参考:https://www.serotoninpower.club/archives/355/#%E3%82%84%E3%82%8A%E3%81%9F%E3%81%84%E3%81%93%E3%81%A8
if(Test-Path "$MyPath/../../WindowsTerminalSettings"){
    Write_Section("Start")
}
else{
    Write_Section("Error")
    exit
}

#Write_Section("PSGallery/install.ps1")
Invoke-Expression "$MyPath/PSGallery/install.ps1"
br(2)

#Write_Section("winget/install.ps1")
Invoke-Expression "$MyPath/winget/install.ps1"
br(2)

#Write_Section("scoop/install.ps1")
Invoke-Expression "$MyPath/scoop/install.ps1"
br(2)

#Write_Section("Chocolatey/install.ps1")
Invoke-Expression "$MyPath/Chocolatey/install.ps1"
br(2)

#Write_Section("volta-npm/install.ps1")
Invoke-Expression "$MyPath/volta-npm/install.ps1"
br(2)

#Write_Section("go/install.ps1")
Invoke-Expression "$MyPath/go/install.ps1"
br(2)

#Write_Section("cargo/install.ps1")
Invoke-Expression "$MyPath/cargo/install.ps1"
br(2)

#Write_Section("gh/install.ps1")
Invoke-Expression "$MyPath/gh/install.ps1"
br(2)


Set_ExecutionPolicy
br(2)

Write_Section("isntall.ps1 is Finished.")
br(2)

