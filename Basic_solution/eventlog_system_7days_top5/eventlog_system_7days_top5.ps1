$after=$(get-date).AddDays(-7)
$before=$(get-date)
$hasharray=@()
$group_indexs=Get-Eventlog -LogName System -After $after -Before $before | Where {$_.EntryType -match 'Warning|Error'} | Group-Object Index
foreach($group_index in $group_indexs){    
write-host "Start-date:"$($after.tostring("yyy-MM-dd"))" End-date:"$($before.tostring("yyy-MM-dd"))" Frequency:$($($group_index).count) EventID:$($($group_index).Name)"   
}
 Get-WinEvent