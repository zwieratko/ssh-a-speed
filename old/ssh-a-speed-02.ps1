$aList = 16,32
$totalIter = 5
$listOfTTCK = @()
$listOfTTCP = @()

ForEach ($a in $aList) {
    Write-Host -NoNewline "-a $a takes on average: ";
    ForEach ($i in (1..$totalIter)) {
        # Measure time to create key
        $timeToCreateKey = (Measure-Command{ssh-keygen -qa $a -t ed25519 -P password -f test}).TotalMilliseconds
        # Measure time to change password
        $timeToChangePassword = (Measure-Command{ssh-keygen -qa $a -pP password -N new -f test}).TotalMilliseconds
        Remove-Item test*
        $listOfTTCK += $timeToCreateKey
        $listOfTTCP += $timeToChangePassword
        #Write-Host -NoNewline " $timeToChangePassword"
        [string]$listAllTimeToChangePassword += [System.Math]::Round($timeToChangePassword,2)
        if ( $i -lt $totalIter ) {$listAllTimeToChangePassword += ","}
        $sumTTCP += $timeToChangePassword
        $sumTTCK += $timeToCreateKey
    }
    $averTTCP = [System.Math]::Round(($sumTTCP/$i/1000),2)
    $averTTCK = [System.Math]::Round(($sumTTCK/$i/1000),2)
    Write-Host "$averTTCK / $averTTCP s ($listAllTimeToChangePassword ms)"
    ($listOfTTCK | Measure-Object -Average).Average
    ($listOfTTCP | Measure-Object -Average).Average
    $listOfTTCK = @()
    $listOfTTCP = @()
    $sumTTCP = 0
    $sumTTCK = 0
    $listAllTimeToChangePassword = ""
}
