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

Write_Title "rustup show"
rustup show
br(1)

Write_Title "rustup install nightly-x86_64-pc-windows-gnu"
rustup install nightly-x86_64-pc-windows-gnu
br(1)

Write_Title "rustup default nightly-x86_64-pc-windows-gnu"
rustup default nightly-x86_64-pc-windows-gnu
br(1)

Write_Title "cargo install exa"
cargo install exa
br(1)
Write_Title " 'install.ps1'が終了しました. / 'install.ps1' has finished."
