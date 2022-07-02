" --------------------------------------------------
"                    OS_Settings
" --------------------------------------------------
if has('unix')
  " none

"elseif system('uname -a | grep Microsoft') != ''
  " Clipboard magic"
  "augroup myYank
    "autocmd!
    "autocmd TextYankPost * :call system('clip.exe', @")
  "augroup END

elseif has('wsl')
  " Clipboard magic?
  augroup myYank
    autocmd!
    autocmd TextYankPost * :call system('clip.exe', @")
  augroup END

elseif has('mac')
  " none

elseif has('win32') || has('win64')
  " Clipboard magic?
  set clipboard+=unnamed

endif

" --------------------------------------------------
"                  Common_Settings
" --------------------------------------------------
