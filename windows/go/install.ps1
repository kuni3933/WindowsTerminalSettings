. "./../Function.ps1"

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Write_Section("go/install.ps1")


Write_Title("# go get -u github.com/tadashi-aikawa/gowl")
go get -u github.com/tadashi-aikawa/gowl
br(1)

Write_Title("# go get -u github.com/tcnksm/ghr")
go get -u github.com/tcnksm/ghr
br(1)


Set_ExecutionPolicy
br(2)

Write_Section("# go/install.ps1 has finished.")
br(2)

