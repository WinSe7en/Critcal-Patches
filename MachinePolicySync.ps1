Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1' # Import the ConfigurationManager.psd1 module 
Set-Location 'DU1:' # Set the current location to be the site code.

$SiteServer = 'sccm-fs.du.edu'
$SiteCode = 'DU1' 
$CollectionName = 'MS17-010'
$CollectionId = 'DU100255'

# Refresh the Collection before moving forward
Invoke-WmiMethod `
-Path "ROOT\SMS\Site_$($SiteCode):SMS_Collection.CollectionId='$CollectionId'" `
-Name RequestRefresh -ComputerName $SiteServer
#$cred = Get-credential 
#Retrieve SCCM collection by name 
start-sleep -s 4
$Collection = get-wmiobject -ComputerName $siteServer -NameSpace "ROOT\SMS\site_$SiteCode" -Class SMS_Collection -Credential $cred  | where {$_.Name -eq "$CollectionName"} 
#Retrieve members of collection 
$SMSMemebers = Get-WmiObject -ComputerName $SiteServer -Credential $cred -Namespace  "ROOT\SMS\site_$SiteCode" -Query "SELECT * FROM SMS_FullCollectionMembership WHERE CollectionID='$($Collection.CollectionID)'" | select name

write "There are " $SMSMemebers.Count "objects for a Machine Policy Sync"
foreach ($SMSMember in $SMSMemebers) {
    $SMSMember
    Invoke-WMIMethod -ComputerName $SMSMember.name -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000021}" -Verbose
    start-sleep -s 45 -Verbose
    Invoke-WMIMethod -ComputerName $SMSMember.name -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{00000000-0000-0000-0000-000000000022}" -Verbose
}