. "${PSScriptRoot}/../Function.ps1"

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

if (-Not (Get-Command("cargo.exe"))) {
  Write-Error -Message "cargo.exe (rust) is not installed." -ErrorAction Stop
	return 1603
}
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("cargo/install.ps1")


_Write_Title("# rustup show")
rustup show
_br(1)

_Write_Title("# rustup update")
rustup self update
rustup update
_br(1)

_Write_Title("# rustup install nightly-x86_64-pc-windows-msvc")
rustup install nightly-x86_64-pc-windows-msvc
_br(1)

_Write_Title("# rustup default nightly-x86_64-pc-windows-msvc")
rustup default nightly-x86_64-pc-windows-msvc
_br(1)

_Write_Title("# rustup component")
rustup component add `
  clippy `
  llvm-tools-preview `
  rls `
  rust-analysis `
  rust-analyzer `
  rust-docs `
  rust-src `
  rustfmt
_br(1)

_Write_Title("# cargo install choose")
cargo install choose
_br(1)

_Write_Title("# cargo install --git https://github.com/skyline75489/exa --branch chesterliu/dev/win-support")
cargo install --git https://github.com/skyline75489/exa --branch chesterliu/dev/win-support
_br(1)

_Write_Title("# cargo install rusty-rain")
cargo install rusty-rain
_br(1)

_Write_Title("# cargo install silicon")
cargo install silicon
_br(1)


_Set_ExecutionPolicy
_br(2)

_Write_Section("# cargo/install.ps1 has finished.")
_br(2)

