Import-Module 'C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager.psd1' # Import the ConfigurationManager.psd1 module 
Set-Location 'DU1:' # Set the current location to be the site code.

$computers = Get-Content "C:\Users\matthew.w.johnson\Documents\GitHub\Critcal-Patches\Round1.txt"

foreach($computer in $computers) {
   $computer
   Add-CMDeviceCollectionDirectMembershipRule -CollectionName "Critical Round 1" -ResourceId $(get-cmdevice -Name $computer).ResourceID -Verbose
}