. "./../Function.ps1"

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Write_Section("Chocolatey/install.ps1")

Write_Title("# chocolatey version")
chocolatey version

Write_Title("# choco update all / choco upgrade all")
choco update all
choco upgrade all
br(1)

Write_Title("# choco-cleaner")
choco install choco-cleaner

Write_Title("# fonts")
choco install font-hackgen
choco install font-hackgen-nerd
br(1)

Write_Title("# choco update all / choco upgrade all")
choco update all
choco upgrade all
br(1)

Write_Title("# choco-cleaner.bat")
Invoke-Command -ScriptBlock {
    choco-cleaner.bat
}

if(Test-Path "$env:USERPROFILE/AppData/Local/Temp/chocolatey"){
    Write_Title("Remove-Item $env:USERPROFILE/AppData/Local/Temp/chocolatey/*")
    Remove-Item "$env:USERPROFILE/AppData/Local/Temp/chocolatey/*"
}
br(1)

Write_Title("# chocolatey version")
chocolatey version
br(1)


Set_ExecutionPolicy
br(2)

Write_Section("# Chocolatey/install.ps1 has finished.")
br(2)

