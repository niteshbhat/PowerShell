

[xml]$bandData = Get-Content -path xml.txt
foreach ($bands in $bandData.ServiceResponse.data.Asset) {
    write-host "======================================"
    write-host "            Asset:$($bands.id)        "
    write-host "======================================"
    foreach($band in $bands.tags.list.tagsimple){  
    write-host "======================================"
    [pscustomobject]@{
        ID=$bands.id
        Name = $bands.Name
        Created = $bands.Created
        modified = $bands.modified
        Type=$bands.type
        SubID=$band.id
        SubName=$band.name
       }
       write-host "======================================"
    }
    write-host "======================================"
}
