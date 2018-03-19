#Create and Manage Virtual Networking

##Create a Resource Group
A Resource Group is a container used to organize your Azure resources. You can control access and manage billing of Resource Groups or use them to logically separate like resources (i.e. all resources relevant to a specific application).

We will start by creating a Resource Group to be used throughout the labs. All resources can be deployed to this same Resource Group.

1. Start by clicking the “+ Create a resource” in the top left of the Azure portal
2. Search for “resource group” and hit “Enter”
3. The Resource Group blade should open, with the option to “Create” at the bottom, click “Create”
4. Enter “[last name]ResourceGroup” as your Resource Group name
5. Select your subscription
6. Select region, we recommend Central US for the purposes of this demo

##Create a VNet
A VNet is the basic container for all Azure networking. It is simply a root address space in a given location.

1. In the Search box type “Virtual Networks” and click the link (be sure not to click the link with “Classic” in the title)
2. Click the +Add button
3. Fill in the details to create a VNet:
    a. Input [lastname]VNet as the name
    b. Use your existing [lastname]ResourceGroup you created previously
    c. Create a default subnet named “web”
    d. Set the VNet address space to 172.16.0.0/16 where student number is assigned during the class
    e. Set the Web subnet address space to 172.16.0.0/24.
    f. Click Create
4. Once complete click “Go to Resource” or click your VNet in the list

##Create an additional subnet
1. Select “Subnets” from the Vnet menu
2. Click +Subnet
    a. Enter “data” for name
    b. Enter 172.16.10.0/24 for the address range
    c. Click Ok
3. You will see the additional subnet appear in the subnets list

Create Network Security Groups
NSGs are essentially stateful firewalls. We are going to create an NSG between Web and Data, as well as one from the public into Web.

1. In the Search box enter “Network Security Groups” and click the link (note, not the ‘Classic’ link)
2. Click the +Add button
3. Enter the following values in the creation blade:
    a. Name: webPubNSG
    b. Resource Group: Use Existing - your previously created RG
    c. Click Create
4. Once created, click “Go To Resource” or select your new NSG from the list
5. Click “Inbound Security Rules” and note the default rules permitting all traffic within the VNet.
6. Click +Add to create a new rule
7. Enter the following details:
    a. Source: Any
    b. Source Port Groups: *
    c. Destination: Any
    d. Destination Port Groups: 80,443,3389
    e. Protocol: TCP
    f. Action: Allow
    g. Priority: 100
    h. Name: Default_Web
8. Click OK
9. Once finished, click the “Subnets” link
10. Click +Associate
11. Choose your VNet and then the “Web” Subnet
12. Click OK

##Create a Second NSG
1. Click the +Add button on the Network Security Groups Blade
    a. Name: WebToData
    b. Resource Group: Use your existing
    c. Create
2. Go To Resource
3. Click “Inbound Security Rules” and then the +Add button
    a. Source: IP Addresses
    b. CIDR Range: 172.16.0.0/24
    c. Source Port: *
    d. Destination: IP Addresses
    e. Destination CIDR Range: 172.16.10.0/24
    f. Destination Port Range: 1433
    g. Protocol: TCP
    h. Action: Allow
    i. Priority: 100
    j. Name: Port_1433
    k. Click OK
4. Click the Subnets Link
5. Click +Associate
6. Select your VNet and the Data subnet
7. Click OK

##Create a second VNet and Subnet using a Template
This template will create a “TransitVNet” with “Transit” Subnet, and a Ubuntu VM in that subnet which we will use for testing.
1. Click +Create a Resource
2. In the search box type “template” and select “Template Deployment”
3. Click Create
4. Click “Build your own template in the editor”
5. Delete everything in the editor, and then paste in the complete contents from "/SecondVNet/azuredeploy.json"
6. Click Save
7. In the Custom Deployment Blade enter the following:
    a. Resource Group: Use your existing
    b. Location: the location of your existing Resource Group and VNet
    c. Review the settings and modify as needed
8. Click the “I agree…” checkbox and then Purchase (note, cost will be negligible)
9. This will use the template to deploy a transit VNet and subnet for use in the next section.

##Setup VNet Peering with transit VNet
1. Click Virtual Networks on the left and select your VNet
2. Click the “Peerings” link
3. Click +Add
    a. Name: UserToTransitPeering
    b. Resource Manager
    c. Virtual Networks: Select your Transit Vnet created previously
    d. Network Access: Enabled
    e. Leave the bottom three boxes unchecked
    f. Click OK
4. Once complete, note that the Transit Status is “Initiated” (you may have to close and reopen your blade to refresh). This indicates that the peering request has been made, but it still needs to be confirmed on the other side.
5. Click Virtual Networks and then click your Transit VNet.
6. Click Peerings.
7. Click +Add and enter the following:
    a. Name: TransitToUserPeering
    b. VNet: Select your existing [Lastname]VNet 
    c. Leave the checkboxes unchecked
    d. Click OK
8. Close and reopen the blade to refresh. Click Peerings. Note that now the peering status is “Connected.”

