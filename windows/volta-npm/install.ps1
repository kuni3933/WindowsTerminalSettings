. "${PSScriptRoot}/../Function.ps1"

${MyPath} = Split-Path -Parent $MyInvocation.MyCommand.Path
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if (!(Get-Command("volta.exe") -ErrorAction SilentlyContinue)) {
  Write-Error -Message "volta.exe is not installed." -ErrorAction Stop
  return 1603
}

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("volta-npm/install.ps1")


_Write_Title("# volta")
volta -v
volta setup
volta list all
_br(1)

_Write_Title("# volta install node@latest")
volta install node@latest
_br(1)

_Write_Title("# volta install npm@latest")
volta install npm@latest
_br(1)

_Write_Title("# volta install npx@latest")
volta install npx@latest
_br(1)

_Write_Title("# volta install yarn@latest")
volta install yarn@latest
_br(1)

_Write_Title("# CLI Tool")
npm install -g @nestjs/cli expo-cli git-cz gtop json-server license-checker serve tldr typescript
#npm install -g commitizen cz-conventional-changelog-ja
_br(1)

_Write_Title("# volta list all")
volta list all > "${MyPath}/volta_log.txt"
_br(1)


_Set_ExecutionPolicy
_br(2)

_Write_Section("# volta-npm/install.ps1 has finished.")
_br(2)

