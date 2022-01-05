. "./../Function.ps1"

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("Chocolatey/install.ps1")

_Write_Title("# chocolatey version")
chocolatey version

_Write_Title("# choco update all / choco upgrade all")
choco update all
choco upgrade all
_br(1)

_Write_Title("# choco-cleaner")
choco install choco-cleaner

_Write_Title("# fonts")
choco install font-hackgen
choco install font-hackgen-nerd
_br(1)

_Write_Title("# choco update all / choco upgrade all")
choco update all
choco upgrade all
_br(1)

_Write_Title("# choco-cleaner.bat")
Invoke-Command -ScriptBlock {
    choco-cleaner.bat
}

if(Test-Path "${env:USERPROFILE}/AppData/Local/Temp/chocolatey"){
    _Write_Title("Remove-Item ${env:USERPROFILE}/AppData/Local/Temp/chocolatey/*")
    Remove-Item "${env:USERPROFILE}/AppData/Local/Temp/chocolatey/*"
}
_br(1)

_Write_Title("# chocolatey version")
chocolatey version
_br(1)


_Set_ExecutionPolicy
_br(2)

_Write_Section("# Chocolatey/install.ps1 has finished.")
_br(2)

