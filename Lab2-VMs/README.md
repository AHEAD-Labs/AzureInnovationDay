# Create and Manage Azure VMs

## Create an Azure VM with the Portal
We are going to create our first Web Server VM using the Azure Portal.

Log into https://portal.azure.com with your credentials.
Click “Create a Resource” (plus icon) in the top left corner.
Select “Windows Server 2016 Datacenter” from the list under “Popular.”
Fill out the basic info:
Name your VM ‘web-vm-1’
Choose a username and password
Select the Resource Group used in Lab 1.
Select the Location used in Lab 1.
Click OK
 
Choose a size:
Select the “View All” link to show all available sizes
Scroll down and select “B2S Standard” size for a cost effective burstable instance size
Click Select
Configure Optional Features


On the Create screen click “Create”
You will be redirected to your Dashboard where you will see a tile for your new VM. Wait a few minutes for the VM to finish provisioning.

## Connect to web-vm-1
Once the provisioning process is complete, click the tile for the VM if you are not automatically redirected.
Click the Connect button. You will see Microsoft Remote Desktop open, or on a Mac you will get a download link for a .rdp file.
Open the .rdp file and enter the credentials you used when creating the VM. Mac users: you will need to have Microsoft RDP installed (link)
Accept security warnings and click connect.
Close the Server Manager window
TEST Connection between Web and Transit 
Open a cmd shell and run “ping 172.254.1.4”
Note, this should be your test VM IP address but you may have to view that VM and verify
If the peering was successful you should see a reply from your TestVM in your TransitVnet
Create an Azure VM with PowerShell
We are going to create our second Web Server VM with PowerShell. We are going to use the Azure Cloud Shell, however because this is the first time we will have to setup a quick storage account.

Open the cloud PowerShell console by clicking the powershell icon in the top right of the Azure Portal

Select “PowerShell (Windows)”
Click the “Advanced Settings” Link and choose the following:
Region: East US
Resource Group: Use your existing Resource Group
Storage Account: Create New - (must be lower case) [lastname]storage
File Share: Create New - name [lastname]fs
Click Create Storage

Once complete the shell should have loaded PowerShell and authenticated you to Azure.

Run the following command to create a VM supplying your last name where appropriate

New-AzureRmVM `
-ResourceGroupName "YOURRESOURCEGROUP" `
-Name "web-vm-2" `
-Location "LOCATION" `
-VirtualNetworkName "YOURVNET" `
-SubnetName "web" 


Create an Azure VM with an Availability Set
Availability sets cannot be easily added to an existing Virtual Machine. We will create new VMs within an availability set.

Start by following the steps provided in the “Create an Azure VM with the Portal” section, but stop when you get to the optional features.
VMName: availSetVM1

Click on “Availability set”
The “Change availability set” blade will open, click “Create new”
Enter “[lastname]AvailabilitySet” as the name
Keep the default Fault and Update domains

Continue on with the remaining settings to create your VM
We can now create a second VM and add it to our new Availability Set
Follow the steps to create a VM within the portal and select your Availability Set during the configuration process
VM Name: availSetVM2
Navigate to your “[lastname]AvailabilitySet” and click “Overview”
You’ll see that both VMs are added to this Availability Set and are placed in separate Fault and Update Domains