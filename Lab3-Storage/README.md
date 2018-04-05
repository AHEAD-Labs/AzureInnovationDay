## Create Azure Storage Account

1. Click 'Create a Resource' (plus icon) in the top left corner.
2. Click 'Storage' -> 'Storage Account'
3. Enter a name for your storage account (It must be unique and lower case).
  1. Ensure that "Account kind" is set to "StorageV2"
  2. Replication should be set to "Locally-redundant storage (LRS)"
4. Click Create
5. Once provisioning has completed, navigate to the resource by clicking "Go to resource"
6. Click 'Blobs', and then click "Add Container" (Plus sign) near the top. Enter a name and set it to 'Private'
7. Select your container and click 'Upload'. Upload these 3 files by pasting the link into the upload dialog: (You'll have to download these manually if you're on a Mac.)

[https://goo.gl/QZLgyY](https://goo.gl/QZLgyY) , [https://goo.gl/NDfAkc](https://goo.gl/NDfAkc) , [https://goo.gl/vQcxFV](https://goo.gl/vQcxFV)

## Use Storage Explorer to Browse Storage Account

1. From a browser, search "azure storage explorer" or browse to: [https://azure.microsoft.com/en-us/features/storage-explorer/](https://azure.microsoft.com/en-us/features/storage-explorer/), and download Storage Explorer.
2. Install Storage Explorer and log in with your credentials. You'll be able to browse the Storage Account created above and view your blobs.
3. Navigate around the storage explorer. Notice you can create new Blobs, new Folders and quickly upload and download files.

## Create Azure File Share and Mount to Windows VM

1. Click 'Files' and then near the top click "Add File Share" (Plus sign)
2. Enter a name and a "1" in the quota, click 'OK'
3. Click your file share and then click 'Connect' near the top.
4. Click the "Copy" Icon next to the top script
\*Note the bash command for Linux servers at the bottom
5. RDP into the VM you created in the last lab and run a PowerShell session(or ISE) as Administrator and execute the provided commands.

[https://github.com/AHEAD-Labs/AzureInnovationDay/blob/master/Lab3-Storage/Mount-FileShare.ps1](https://github.com/AHEAD-Labs/AzureInnovationDay/blob/master/Lab3-Storage/Mount-FileShare.ps1)