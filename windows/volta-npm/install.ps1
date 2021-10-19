. "./../Function.ps1"

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Write_Section("volta-npm/install.ps1")


Write_Title("# volta")
volta -v
volta list all
br(1)

Write_Title("# volta install node@latest")
if(Test-Path "$env:LOCALAPPDATA/Volta/tools/image/node"){
  Remove-Item -Recurse $env:LOCALAPPDATA/Volta/tools/image/node
}
volta install node@latest
br(1)

Write_Title("# volta install npm@latest")
if(Test-Path "$env:LOCALAPPDATA/Volta/tools/image/npm"){
  Remove-Item -Recurse $env:LOCALAPPDATA/Volta/tools/image/npm
}
volta install npm@latest
br(1)

Write_Title("# volta install yarn@latest")
if(Test-Path "$env:LOCALAPPDATA/Volta/tools/image/yarn"){
  Remove-Item -Recurse $env:LOCALAPPDATA/Volta/tools/image/yarn
}
volta install yarn@latest
br(1)

Write_Title("# npm update *")
npm update *
br(1)

Write_Title("# npm install -g npm-upgrade express express-generator ejs mysql2")
npm install -g npm-upgrade express express-generator ejs mysql2
br(1)

Write_Title("# volta list all")
volta list all
br(1)


Write_Section("# volta-npm/install.ps1 has finished.")
br(2)
