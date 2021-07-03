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

Write_Title "# go get -u github.com/tadashi-aikawa/gowl"
go get -u github.com/tadashi-aikawa/gowl
br(1)

Write_Title "# go get -u github.com/tcnksm/ghr"
go get -u github.com/tcnksm/ghr
br(1)

Write_Title "# go/install.ps1 has finished."
br(2)
