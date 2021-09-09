function Write_Title($msg) {
  Write-Host "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
  Write-Host "┃$msg" -ForegroundColor Yellow
  Write-Host "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
}
function Write_Section($msg) {
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
    Write-Host "     $msg" -ForegroundColor Green
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
}
function br($times) {
  $tmp = 1
  while ($tmp -le $times) {
    Write-Output " ";
    $tmp += 1
  }
}

Write_Title("# rustup show")
rustup show
br(1)

Write_Title("# rustup update")
rustup self update
rustup update
br(1)

Write_Title("# rustup install nightly-x86_64-pc-windows-msvc")
rustup install nightly-x86_64-pc-windows-msvc
br(1)

Write_Title("# rustup default nightly-x86_64-pc-windows-msvc")
rustup default nightly-x86_64-pc-windows-msvc
br(1)

Write_Title("# rustup component")
rustup component add `
  clippy `
  rls `
  rust-analysis `
  rust-src `
  rust-docs `
  rustfmt
br(1)

Write_Title(" cargo install rusty-rain")
cargo install rusty-rain
br(1)

Write_Title("# cargo install --git https://github.com/skyline75489/exa --branch chesterliu/dev/win-support")
cargo install --git https://github.com/skyline75489/exa --branch chesterliu/dev/win-support
br(1)

Write_Title("# cargo install silicon")
cargo install silicon
br(1)

Write_Title("# cargo install hexyl")
cargo install hexyl
br(1)

Write_Section("# cargo/install.ps1 has finished.")
br(2)
