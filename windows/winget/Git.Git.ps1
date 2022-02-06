${MyPath} = Split-Path -Parent $MyInvocation.MyCommand.Path

& "${env:GIT_INSTALL_ROOT}/git-bash.exe ${MyPath}/Git.Git.sh"

[System.Diagnostics.Process] ${process} = Start-Process `
		-FilePath "git.exe" `
		-ArgumentList "update-git-for-windows" `
		-NoNewWindow `
		-PassThru `
		-Wait

return ${process}.ExitCode
