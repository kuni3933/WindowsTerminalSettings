#uninstall
scoop uninstall `
  gcc `


./install.bat
scoop update git -g
scoop update *
scoop cleanup *
scoop status
