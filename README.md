# Critical-Patches
Using ConfigMgr and PoSH

Steps to patch a Zero-Day using a maintenance window.

1.  Create a collection targeting the patches that are missing.  When creating the query use the Collection Query as the base template.  Change the last line SMS_SoftwareUpdate.ArticleID = 4012212 and use ArticleID in question.  Set the refresh to 1 hour.
2.	After the collection is created and the collection is populated, you need to create the Maintenance Window.  Open the properties of the collection and click on the MW Tab.  Create the maintenance window and set it to daily.
3.  Now you need to tell force the servers to check in for any new policies.  Run the 'MachinePolicySync.ps1' script.  Before doing so, fix the CollectionID and Collection Name to match what you created in the first step.  Now the servers are aware of the new maintenance window.  
4.  OPTIONAL - You can run the 'SoftwareUpdateEvalCycle.ps1' which will kick off a WSUS scan on all the servers in the collection.
5.  Deploy the Critical Software Update Group (SUG) to your collection.  Use the template XXXXX in the pull down menu.
6.  Re-reun the 'MachinePolicySync.ps1' script.  This tell the server that there is work to be done.  It will not run the updates until the MW.
7.  Run the 'SoftwareUpdateEvalCycle.ps1' which will kick off a WSUS scan on all the servers in the collection.


Afterwards, you can keep an eye on the Deployment in Monitoring.