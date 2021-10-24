Param($command)
$return = wsl -- command -v $command
if($return -eq $null){
    #echo false
    return $false
    exit
}
#echo $return
#echo true
return $true
