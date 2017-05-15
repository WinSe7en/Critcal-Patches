Import-Module ActiveDirectory
$computers = Get-ADComputer -Filter * -SearchBase "OU=MSSQL,OU=DU Service Accounts,OU=UTS, DC=du, DC=edu" | select name
foreach ($computer in $computers) {
    $SMSMember.name
    Invoke-WMIMethod -ComputerName $computer.name -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000114}" -Verbose
}