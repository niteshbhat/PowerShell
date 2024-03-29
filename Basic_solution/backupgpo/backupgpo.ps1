Function Remove-backup {
    if(Test-Path -path "\\SERVER\GPO_Backup\GPO"){
        Remove-Item -path "\\SERVER\GPO_Backup\GPO\" -ErrorAction stop 
    }
    else{
        Write-Error "Share Path Is not Found" -ErrorAction continue
    }
    try{    
            New-Item -Path "\\SERVER\GPO_Backup\GPO\$($(Get-date).tostring('yyyy-MM-d'))" -ItemType directory -ErrorAction Stop
            $newfolder=$($(Get-date).tostring('yyyy-MM-d'))       
        }
        catch{
               Write-Error "[Error:]$error[0].Exception.Message"
        
        }
Return $newfolder
}

Import-Module grouppolicy
$removebackup=Remove-backup
Backup-Gpo -All -Path "\\SERVER\GPO_Backup\GPO\$removebackup"