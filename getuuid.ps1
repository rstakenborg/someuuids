$remote = 'remoteid.json'
$local = 'localid.json'
$alloc = 10


if (!(Test-Path $local) -or ((Get-Content $local | Out-String | ConvertFrom-Json).counter -eq 0)) {
    $content = (Get-Content $remote | Out-String | ConvertFrom-Json)
    
    $localcontent = @{
        "pool"    = $content.counter
        "counter" = $alloc
    }
    $localcontent | ConvertTo-Json | Out-File $local
    $content.counter = $content.counter + $alloc
    $content | ConvertTo-Json | Out-File $remote
}

$localcontent = (Get-Content $local | Out-String | ConvertFrom-Json)
$newid = $localcontent.pool + $localcontent.counter
$localcontent.counter -= 1
$localcontent | ConvertTo-Json | Out-File $local
write-host $newid
