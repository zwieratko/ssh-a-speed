$aList = 16,32,64,100,200
$totalIter = 5
#$listOfTTCK = @()
$listOfTTCP = @()

ForEach ($a in $aList) {
    Write-Host -NoNewline "-a $a takes on average: ";
    ForEach ($i in (1..$totalIter)) {
        # Measure time to create key
        #$timeToCreateKey = (Measure-Command{ssh-keygen -qa $a -t ed25519 -N password -f test}).TotalMilliseconds
        ssh-keygen -qa $a -t ed25519 -N password -f test
        # Measure time to change password
        $timeToChangePassword = (Measure-Command{ssh-keygen -qa $a -pP password -N new -f test}).TotalMilliseconds
        Remove-Item test*
        #$listOfTTCK += [System.Math]::Round($timeToCreateKey,2)
        $listOfTTCP += [System.Math]::Round($timeToChangePassword,2)
    }
    #$averTTCK = [System.Math]::Round((($listOfTTCK | Measure-Object -Average).Average)/1000,2)
    $averTTCP = [System.Math]::Round((($listOfTTCP | Measure-Object -Average).Average)/1000,2)
    #$listAllTimeToChangePassword = [string]::Join(' ', $listOfTTCP).replace(",",".")
    Write-Host "$averTTCP"
    #$listOfTTCK = @()
    $listOfTTCP = @()
}
