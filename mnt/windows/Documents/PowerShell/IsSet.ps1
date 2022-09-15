Param(${command})

${return} = wsl -- command -v ${command}
#${return} = &wsl -- command -v ${command}

if($null -eq ${return}){
  #echo false
  return $false
}
#echo $return
return $true
