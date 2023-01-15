$totalIter = 5
ForEach ($a in (10,20,30)) {
    Write-Host -NoNewline "-a $a takes on average: ";
    ForEach ($i in (1..$totalIter)) {
        # Create key
        #ssh -qa $a -t ed25519 -P password -f test
        $temp = (Measure-Command{Start-Sleep -Milliseconds 30}).TotalMilliseconds
        #Write-Host -NoNewline " $temp"
        [string]$listAll += "$temp"
        if ( $i -lt $totalIter ) {$listAll += ","}
        $sum += $temp
    }
    $aver = $sum / $i
    Write-Host -NoNewline "$aver ($listAll)"
    $sum = 0
    $listAll = ""
    Write-Host
}
