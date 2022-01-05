. "./../Function.ps1"

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("volta-npm/install.ps1")


_Write_Title("# volta")
volta -v
volta list all
_br(1)

_Write_Title("# volta install node@latest")
if(Test-Path "${env:LOCALAPPDATA}/Volta/tools/image/node"){
  Remove-Item -Recurse ${env:LOCALAPPDATA}/Volta/tools/image/node
}
volta install node@latest
_br(1)

_Write_Title("# volta install npm@latest")
if(Test-Path "${env:LOCALAPPDATA}/Volta/tools/image/npm"){
  Remove-Item -Recurse ${env:LOCALAPPDATA}/Volta/tools/image/npm
}
volta install npm@latest
_br(1)

_Write_Title("# volta install yarn@latest")
if(Test-Path "${env:LOCALAPPDATA}/Volta/tools/image/yarn"){
  Remove-Item -Recurse ${env:LOCALAPPDATA}/Volta/tools/image/yarn
}
volta install yarn@latest
_br(1)

_Write_Title("# npm install -g npm-upgrade express express-session express-generator ejs mysql2 bcrypt")
npm install -g npm-upgrade express express-session express-generator ejs mysql2 bcrypt
_br(1)

_Write_Title("# volta list all")
volta list all
_br(1)


_Set_ExecutionPolicy
_br(2)

_Write_Section("# volta-npm/install.ps1 has finished.")
_br(2)

