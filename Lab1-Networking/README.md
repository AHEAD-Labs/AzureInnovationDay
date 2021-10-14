## Create a Resource Group

A Resource Group is a container used to organize your Azure resources. You can control access and manage billing of Resource Groups or use them to logically separate like resources (i.e. all resources relevant to a specific application).

We will start by creating a Resource Group to be used throughout the labs. All resources can be deployed to this same Resource Group.

1. Start by clicking the "+ Create a resource" in the top left of the Azure portal
2. Search for "resource group" and hit "Enter"
3. The Resource Group blade should open, with the option to "Create" at the bottom, click "Create"
4. Enter "[last name]ResourceGroup" as your Resource Group name
5. Select your subscription
6. Select region, we recommend Central US for the purposes of this demo

## Create a Virtual Network (VNet)

A VNet is the basic container for all Azure networking. It is simply a root address space in a given location.

1. Within the newly created Resource Group, click "Create", then in the search box type "Virtual Networks". 
2. Click "Create" -> "Virtual Network" 
3. Fill in the details to create a VNet:
  1. Select a Subscription & use your existing [lastname]ResourceGroup you created previously (this should autopopulate, but be sure to verify)
  2. Input [lastname]VNet as the name
  3. Input "Central US" as the Region and click "Next: IP Addresses"
  4. Set the VNet address space to 172.16.0.0/16
  5. Click "Add Subnet", here you will assign your first subnet, named "web"
  6. Set the Web subnet address space to 172.16.0.0/24, and click "Add"
  7. Select "Review + Create", then "Create"

4. Once complete a notification should pop up in the top-right of the portal letting you know the deployment has completed. From the notification, click "Go to Resource"

## Create an additional subnet

1. Within your newly created Virtual Network, select "Subnets" under settings on the overview blade.
 2. Click +Subnet
    1. Enter "data" for name
    2. Enter 172.16.1.0/24 for the address range
    3. Click "Save"
 3. You will see the additional subnet appear in the subnets list

## Create Network Security Groups

NSGs are essentially stateful firewalls. We are going to create an NSG between Web and Data, as well as one from the public into Web.

1. Within your Resource Group, click "Create", then in the search box type "Network Security Groups".
2. Click "Create" -> "Network Security Group". 
3. Enter the following values in the creation blade:
   1. Select a Subscription & use your existing [lastname]ResourceGroup you created previously (this should autopopulate, but be sure to verify)
   2. Name: webPubNSG
   3. Resource Group: Use Existing - your previously created RG
   4. Click "Review + Create", then "Create"
4. Once created, click "Go To Resource" or select your new NSG from the list
5. Click "Inbound Security Rules" and note the default rules permitting all traffic within the VNet.
6. Click +Add to create a new rule
7. Enter the following details:
   1. Source: Any
   2. Source Port Groups: \*
   3. Destination: Any
   4. Destination Port Groups: 80,443,3389
   5. Protocol: TCP
   6. Action: Allow
   7. Priority: 100
   8. Name: Default\_Web
8. Click "Add"
9. Once finished, click "Subnets" under Settings 
10. Click +Associate
11. Choose your VNet and then the "Web" Subnet
12. Click OK

## Create a Second NSG

1. Once again, click the "Create" button on the Network Security Groups Blade
  1. Name: WebToData
  2. Resource Group: Use your existing
  3. Create
2. Go To Resource
3. Click "Inbound Security Rules" and then the +Add button
  1. Source: IP Addresses
  2. CIDR Range: 172.16.0.0/24
  3. Source Port: \*
  4. Destination: IP Addresses
  5. Destination CIDR Range: 172.16.1.0/24
  6. Destination Port Range: 1433
  7. Protocol: TCP
  8. Action: Allow
  9. Priority: 100
  10. Name: Port\_1433
  11. Click "Add"
4. Once finished, click "Subnets" under Settings
5. Click +Associate
6. Select your VNet and the "data" subnet
7. Click OK

## Create a second VNet and Subnet using a Template

This template will create a "TransitVNet" with "Transit" Subnet, and a Ubuntu VM in that subnet which we will use for testing.

1. Click +Create a Resource
2. In the search box type "template" and select "Template Deployment"
3. Click Create
4. Click "Build your own template in the editor"
5. Delete everything in the editor, and then paste in the complete contents found at the following link:

[https://github.com/AHEAD-Labs/AzureInnovationDay/blob/master/Lab1-Networking/SecondVNet/azuredeploy.json](https://github.com/AHEAD-Labs/AzureInnovationDay/blob/master/Lab1-Networking/SecondVNet/azuredeploy.json)

1. Click Save
2. In the Custom Deployment Blade enter the following:
  1. Resource Group: Use your existing
  2. Location: the location of your existing Resource Group and VNet
  3. Review the settings and modify as needed
3. Click the "I agree…" checkbox and then Purchase (note, cost will be negligible)
4. This will use the template to deploy a transit VNet and subnet for use in the next section.

## Setup VNet Peering with transit VNet

1. Click Virtual Networks on the left and select your VNet
2. Click the "Peerings" link
3. Click +Add
  1. Name: UserToTransitPeering
  2. Resource Manager
  3. Virtual Networks: Select your **Transit Vnet** created previously
  4. Network Access: Enabled
  5. Leave the bottom three boxes unchecked
  6. Click OK
4. Once complete, note that the Transit Status is "Initiated" (you may have to close and reopen your blade to refresh). This indicates that the peering request has been made, but it still needs to be confirmed on the other side.
5. Click Virtual Networks and then click your Transit VNet.
6. Click Peerings.
7. Click +Add and enter the following:
  1. Name: TransitToUserPeering
  2. VNet: Select your existing [Lastname]VNet
  3. Leave the checkboxes unchecked
  4. Click OK
8. Close and reopen the blade to refresh. Click Peerings. Note that now the peering status is "Connected."
