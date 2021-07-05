function Write_Title($msg) {
  Write-Host "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
  Write-Host "┃$msg" -ForegroundColor Yellow
  Write-Host "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
}
function br($times) {
  $tmp = 1
  while ($tmp -le $times) {
    Write-Output " ";
    $tmp += 1
  }
}

Write_Title "# rustup show"
rustup show
br(1)

Write_Title "# rustup update"
rustup self update
rustup update
br(1)

Write_Title "# rustup install nightly-x86_64-pc-windows-msvc"
rustup install nightly-x86_64-pc-windows-msvc
br(1)

Write_Title "# rustup default nightly-x86_64-pc-windows-msvc"
rustup default nightly-x86_64-pc-windows-msvc
br(1)

Write_title "# rustup component"
rustup component add `
  clippy `
  rls `
  rust-analysis `
  rust-src `
  rust-docs `
  rustfmt
br(1)

Write_Title "cargo install rusty-rain"
cargo install rusty-rain
br(1)

Write_Title "# cargo install exa"
cargo install exa
br(1)

Write_Title "# cargo/install.ps1 has finished."
br(2)
