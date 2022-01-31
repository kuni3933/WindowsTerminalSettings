${MyPath} = Split-Path -Parent $MyInvocation.MyCommand.Path
"${env:GIT_INSTALL_ROOT}/git-bash.exe" "${MyPath}/Git.Git.sh"
