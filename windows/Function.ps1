Add-Type -AssemblyName Microsoft.VisualBasic
#参考 https://win.just4fun.biz/?PowerShell/%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%84%E3%83%95%E3%82%A9%E3%83%AB%E3%83%80%E3%82%92%E3%81%94%E3%81%BF%E7%AE%B1%E3%81%AB%E7%A7%BB%E5%8B%95%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95

# フォルダをゴミ箱に移動する
function _Folder_ToRecycleBin($target_dir_path) {
  if ((Test-Path $target_dir_path) -And ((Test-Path -PathType Container (Get-Item $target_dir_path)))) {
    $fullpath = (Get-Item $target_dir_path).FullName
    [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory($fullpath,'OnlyErrorDialogs','SendToRecycleBin')
  } else {
    Write-Output "'$target_dir_path' is not directory or not found."
  }
}

# ファイルをゴミ箱に移動する
function _File_ToRecycleBin($target_file_path) {
  if ((Test-Path $target_file_path) -And ((Test-Path -PathType Leaf (Get-Item $target_file_path)))) {
    $fullpath = (Get-Item $target_file_path).FullName
    [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile($fullpath,'OnlyErrorDialogs','SendToRecycleBin')
  } else {
    Write-Output "'$target_file_path' is not file or not found."
  }
}

function _Write_Title([string] ${msg}) {
  Write-Host " ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
  Write-Host " ┃${msg}" -ForegroundColor Yellow
  Write-Host " ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Yellow
}

function _Write_Section([string] ${msg}) {
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
    Write-Host "     ${msg}" -ForegroundColor Green
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
}

function _br([int16] ${times}) {
  [int16] ${tmp} = 1
  while (${tmp} -le ${times}) {
    Write-Output " "
    $tmp += 1
  }
}

function _Want_To_Install([string] ${msg}) {
  $bool = Read-Host("Do you want to install ${msg} ? (y/n)")
  if($bool -eq "y") {
    return 1
  } else {
    return 0
  }
}

function _Set_ExecutionPolicy() {
  Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
  Write-Host "     Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force" -ForegroundColor Green
  Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
  Set-ExecutionPolicy Undefined -Force
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
  Get-ExecutionPolicy -List
}
