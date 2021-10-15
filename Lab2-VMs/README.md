## Create an Azure VM with the Portal

We are going to create our first Web Server VM using the Azure Portal.

1. Log into [https://portal.azure.com](https://portal.azure.com) with your credentials.
2. Click "Create a Resource" (plus icon) in the top left corner.
3. Select "Windows Server 2019 Datacenter" from the list under "Popular" and click "Create". 
4. Fill out the basic info:
   1. Select the Resource Group used in Lab 1.
   2. Select the Location used in Lab 1.
   3. Name your VM 'web-vm-1'
5. Configure Optional Features
   1. Availability Set - click on the availability set option and then "Create new"
   2. A separate blade will open to create the availability set. Give the availability set a name, and leave the default values for Fault and Update domains.
   3. Under "Storage" ensure that the "Use managed disks" option is set to "Yes"
6. Choose a size:
   1. Select the "See All Sizes" link to show all available sizes
   2. Scroll down and select "B2S Standard" size for a cost effective burstable instance size
   3. Click Select
6. Choose a Username and Password, then click "Next: Disks".
7. For OS disk type, choose "Standard SSD", then click "Next: Networking".
8. Networking
    1. Virtual Network: [last name]VNet that was created previously
    2. Subnet: choose your "web" Subnet
    3. Public IP address: a default Public IP should be defined, if not click "Create New".
    4. Network Security Group: Remove the default NSG applied to the VM
9. Select "Review + Create" and click "Create" once validated. 
10. You will be redirected to your Dashboard where you will see a tile for your new VM. Wait a few minutes for the VM to finish provisioning.

## Connect to web-vm-1

1. Once the provisioning process is complete, click the tile for the VM if you are not automatically redirected.
2. Click the Connect button. You will see Microsoft Remote Desktop open, or on a Mac you will get a download link for a .rdp file.
3. Open the .rdp file and enter the credentials you used when creating the VM. Mac users: you will need to have Microsoft RDP installed ( [link](https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-mac))
4. Accept security warnings and click connect.
5. Close the Server Manager window
6. **TEST Connection between Web and Transit**
  1. Open a cmd shell and run "ping 172.254.1.4"
  2. Note, this should be your test VM IP address but you may have to view that VM and verify
  3. If the peering was successful you should see a reply from your TestVM in your TransitVnet

## Create an Azure VM with PowerShell

We are going to create our second Web Server VM with PowerShell. We are going to use the Azure Cloud Shell, however because this is the first time we will have to setup a quick storage account.

1. Open the cloud PowerShell console by clicking the powershell icon in the top right of the Azure Portal
2. Select "PowerShell (Windows)"
3. Choose the following:
  3. Storage Account: Create New - (**must be lower case**) [lastname]storage
  5. Click Create Storage
4. Once complete the shell should have loaded PowerShell and authenticated you to Azure.
5. Run the following command to create a VM supplying your last name where appropriate

[https://github.com/AHEAD-Labs/AzureInnovationDay/blob/master/Lab2-VMs/PowerShell/PowerShellVM.ps1](https://github.com/AHEAD-Labs/AzureInnovationDay/blob/master/Lab2-VMs/PowerShell/PowerShellVM.ps1)

## Review the Availability Set Configuration

1. Navigate to your [lastname]ResourceGroup
2. Navigate to your "[lastname]AvailabilitySet" and click "Overview"
3. You'll see that both VMs are added to this Availability Set and are placed in separate Fault and Update Domains
