$Xftp = “ftp://evilaosa@ftp.drivehq.com/drivehqshare/evilaosa/GroupWrite/”
$XlocalDirectory = "c:\studio\"
$Xuser = "evilaosa"
$Xpass = Read-host "enter your password"

$Xwebclient = New-Object System.Net.WebClient
$Xwebclient.Credentials = New-Object System.Net.NetworkCredential($Xuser,$Xpass)
$XFiles = Get-ChildItem -Path "c:\studio\*" -Rec -For | ? {$_.LastWriteTime -gt (Get-Date).AddHours(-1)} | where { ! $_.PSIsContainer } | Select-Object FullName
$Xnombre = $XFiles.Count
foreach ($XFile in $XFiles)
{
$XLocalFile = $XFile.FullName

$XRemoveDirectory = $XLocalFile.Replace("C:\studio\","")
$XChangeSlashes = $XRemoveDirectory.Replace('\', '/')
$XRemoveSpaces = $XChangeSlashes.Trim()
$XRemoteFile = $Xftp +$XRemoveSpaces
$Xuri = New-Object System.Uri($XRemoteFile)
$Xwebclient.UploadFile($Xuri, $XLocalFile)

Write-Host "Getting $XFile from $XlocalDirectory" -Foreground "Red" -BackgroundColor DarkBlue
Write-Host "Puting $XFile to $Xftp" -Foreground "Yellow" -BackgroundColor DarkBlue
}

""
Write-Host "Finished Sync to $Xftp" -Foreground "Green" -BackgroundColor DarkBlue