# Azure Storage

## Create Azure Storage Account 
Click ‘Create a Resource’ (plus icon) in the top left corner.
Click ‘Storage’ → ‘Storage Account’
Enter a name for your storage account (It must be unique and lower case). See following picture for additional settings. Select the resource group you created in the previous lab. 

Click Create
Once provisioning has completed, navigate to the resource by clicking “Go to resource”
Click ‘Blobs’, and then click “Add Container” (Plus sign) near the top. Enter a name and set it to ‘Private’
Select your container and click ‘Upload’. Upload these 3 files by pasting the link into the upload dialog: (You’ll have to download these manually if you’re on a Mac.)
https://goo.gl/QZLgyY , https://goo.gl/NDfAkc , https://goo.gl/vQcxFV

Use Storage Explorer to Browse Storage Account
From a browser, search “azure storage explorer” or browse to: https://azure.microsoft.com/en-us/features/storage-explorer/ , and download Storage Explorer.
Install and log in with your credentials. You’ll now be able to see your blobs.




Navigate around the storage explorer. Notice you can create new Blobs, new Folders and quickly upload and download files.

Create Azure File Share and Mount to Windows VM
Click ‘Files’ and then near the top click “Add File Share” (Plus sign)
Enter a name and a “1” in the quota, click ‘OK’
Click your file share and then click ‘Connect’ near the top.
Click the “Copy” Icon next to the top script 
*Note the bash command for Linux servers at the bottom
RDP into the VM you created in the last lab and run a PowerShell session(or ISE) as Administrator and execute the provided commands.
$acctKey = ConvertTo-SecureString -String "<storage-account-key>" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential -ArgumentList "Azure\<storage-account-name>", $acctKey
New-PSDrive -Name <desired-drive-letter> -PSProvider FileSystem -Root "\\<storage-account-name>.file.core.windows.net\<share-name>" -Credential $credential