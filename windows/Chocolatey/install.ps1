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

Write_Title("# Choco-Cleaner-manual.bat")
C:/ProgramData/chocolatey/bin/choco-cleaner.bat
br(1)

Write_Title("# chocolatey version")
chocolatey version

Write_Section("# Chocolatey/install.ps1 has finished.")
br(2)
