. "./../Function.ps1"

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Write_Section("gh/install.ps1")


Write_Title("# gh extension install sheepla/gh-userfetch")
gh extension install sheepla/gh-userfetch
br(1)

Write_Title("# gh extension install sheepla/gh-fzopen")
gh extension install sheepla/gh-fzopen
br(1)

Write_Title("# gh extension install sheepla/gh-graph")
gh extension install sheepla/gh-graph
br(1)


Set_ExecutionPolicy
br(2)

Write_Section("# scoop/install.ps1 has finished.")
br(2)

