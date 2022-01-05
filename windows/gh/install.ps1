. "./../Function.ps1"

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
_Write_Section("gh/install.ps1")


_Write_Title("# gh extension install sheepla/gh-userfetch")
gh extension install sheepla/gh-userfetch
_br(1)

_Write_Title("# gh extension install sheepla/gh-fzopen")
gh extension install sheepla/gh-fzopen
_br(1)

_Write_Title("# gh extension install sheepla/gh-graph")
gh extension install sheepla/gh-graph
_br(1)


_Set_ExecutionPolicy
_br(2)

_Write_Section("# scoop/install.ps1 has finished.")
_br(2)

