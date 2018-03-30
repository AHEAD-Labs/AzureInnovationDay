Create a Resource Group
A Resource Group is a container used to organize your Azure resources. You can control access and manage billing of Resource Groups or use them to logically separate like resources (i.e. all resources relevant to a specific application).

We will start by creating a Resource Group to be used throughout the labs. All resources can be deployed to this same Resource Group.

Start by clicking the “+ Create a resource” in the top left of the Azure portal
Search for “resource group” and hit “Enter”
The Resource Group blade should open, with the option to “Create” at the bottom, click “Create”
Enter “[last name]ResourceGroup” as your Resource Group name
Select your subscription
Select region, we recommend Central US for the purposes of this demo


Create a VNet
A VNet is the basic container for all Azure networking. It is simply a root address space in a given location.

Click “All services”, then in the Search box type “Virtual Networks” and click the link (be sure not to click the link with “Classic” in the title)
Click the +Add button
Fill in the details to create a VNet:
Input [lastname]VNet as the name
Use your existing [lastname]ResourceGroup you created previously
Create a default subnet named “web”
Set the VNet address space to 172.16.0.0/16
Under “Subnet” you will assign your first subnet, named “web”
Set the Web subnet address space to 172.16.0.0/24.
Click Create



Once complete a notification should pop up in the top-right of the portal letting you know the deployment has completed. From the notification, click “Go to Resource”



Create an additional subnet
Select “Subnets” from the Vnet menu



Click +Subnet
Enter “data” for name
Enter 172.16.1.0/24 for the address range
Click Ok
You will see the additional subnet appear in the subnets list

Create Network Security Groups
NSGs are essentially stateful firewalls. We are going to create an NSG between Web and Data, as well as one from the public into Web.



In the Search box enter “Network Security Groups” and click the link (note, not the ‘Classic’ link)
Click the +Add button
Enter the following values in the creation blade:
Name: webPubNSG
Resource Group: Use Existing - your previously created RG
Click Create
Once created, click “Go To Resource” or select your new NSG from the list
Click “Inbound Security Rules” and note the default rules permitting all traffic within the VNet.
Click +Add to create a new rule
Enter the following details:
Source: Any
Source Port Groups: *
Destination: Any
Destination Port Groups: 80,443,3389
Protocol: TCP
Action: Allow
Priority: 100
Name: Default_Web
Click OK
Once finished, click the “Subnets” link
Click +Associate
Choose your VNet and then the “Web” Subnet
Click OK

Create a Second NSG
Click the +Add button on the Network Security Groups Blade
Name: WebToData
Resource Group: Use your existing
Create
Go To Resource
Click “Inbound Security Rules” and then the +Add button
Source: IP Addresses
CIDR Range: 172.16.0.0/24
Source Port: *
Destination: IP Addresses
Destination CIDR Range: 172.16.1.0/24
Destination Port Range: 1433
Protocol: TCP
Action: Allow
Priority: 100
Name: Port_1433
Click OK
Click the Subnets Link
Click +Associate
Select your VNet and the Data subnet
Click OK

Create a second VNet and Subnet using a Template
This template will create a “TransitVNet” with “Transit” Subnet, and a Ubuntu VM in that subnet which we will use for testing.
Click +Create a Resource
In the search box type “template” and select “Template Deployment”
Click Create
Click “Build your own template in the editor”
Delete everything in the editor, and then paste in the complete contents of the box below.
	This template can also be found here: https://github.com/AHEAD-Labs/AzureInnovationDay/blob/master/Lab1-Networking/SecondVNet/azuredeploy.json


Click Save
In the Custom Deployment Blade enter the following:
Resource Group: Use your existing
Location: the location of your existing Resource Group and VNet
Review the settings and modify as needed
Click the “I agree…” checkbox and then Purchase (note, cost will be negligible)
This will use the template to deploy a transit VNet and subnet for use in the next section.
Setup VNet Peering with transit VNet
Click Virtual Networks on the left and select your VNet
Click the “Peerings” link
Click +Add
Name: UserToTransitPeering
Resource Manager
Virtual Networks: Select your Transit Vnet created previously
Network Access: Enabled
Leave the bottom three boxes unchecked
Click OK
Once complete, note that the Transit Status is “Initiated” (you may have to close and reopen your blade to refresh). This indicates that the peering request has been made, but it still needs to be confirmed on the other side.
Click Virtual Networks and then click your Transit VNet.
Click Peerings.
Click +Add and enter the following:
Name: TransitToUserPeering
VNet: Select your existing [Lastname]VNet 
Leave the checkboxes unchecked
Click OK
Close and reopen the blade to refresh. Click Peerings. Note that now the peering status is “Connected.”

