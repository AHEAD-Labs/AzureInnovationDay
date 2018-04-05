## Host Level Metrics

1. Click “All Services” in the top left corner, search for and click on “Monitor"
2. Under the "Shared Services" section, click on "Metrics"
3. A selection pane will show at the top to choose the following:
  1. Subscription - a list of available subscriptions, choose the relevant subscription where your VM is located
  2. Resource Group - list of all resource groups within the subscription, choose the resource group your VM is located
  3. Resource Type - list of resources available within the resource group, choose Virtual Machines
  4. Resource - list of Virtual Machines within the resource group, choose your VM name
4. After selecting the parameters, the available host metrics will be shown on the left hand side in checkbox form
5. Choose "[Host] Percentage CPU"
6. Click the pin off on the right hand side.
7. Navigate back to the dashboard

## Create Log Analytics Workspace

1. Navigate to "Log Analytics" within the Azure portal
2. Click "+ Add" to create a new Log Analytics workspace
3. Specify the workspace name, subscription, Resource Group, and Location, then click Create to provision your new workspace
4. Once provisioned, navigate to your new Log Analytics workspace
5. We will first configure our Workspace by choosing "Advanced settings" under the "Settings" section
6. Under the "Data" tab, choose "Windows Performance Counters" and add the recommended Performance data by clicking the "Add the selected performance counters" button
7. Navigate to "Windows Event Logs", from here you will be able to search for and configure your guest-level logs to be collected by your Log Analytics workspace
8. Type "System" into the search bar and click the "+" plus sign to add
9. Click "Save" at the top bar


## Configure Data Source for Log Analytics

1. Navigate back to your Log Analytics workspace and find the "Workspace Data Sources" settings
2. Choose "Virtual Machines"
3. Click on your Virtual Machine
4. Another blade will open and you can click "Connect" to configure the OMS Agent on the selected VM
5. Once provisioned, the VM will show connected to your workspace


## Log Analytics Queries

1. From the Log Analytics “OMS Workspace” click “Log Search”
2. Once the Log Search blade is open, Azure provides some information about the Log Analytics query language structure and a built-in query editor.
3. Copy or create a query in the editor window and then click the Magnifying Glass symbol to run the query.

Try out some of these queries:
[https://github.com/AHEAD-Labs/AzureInnovationDay/tree/master/Lab4-Monitoring/LogAnalyticsQueries](https://github.com/AHEAD-Labs/AzureInnovationDay/tree/master/Lab4-Monitoring/LogAnalyticsQueries)


## Configure Just in Time Access On a VM

Just in time VM Access is only available on Virtual Machines that have a Public IP and Network Security Group configured.

1. Navigate to "Security Center" within the Azure portal
2. Under the "Advanced Cloud Defense" section, click on "Just in time VM access"
3. You may need to enable enhanced security to test the feature
4. Under the "Recommended" tab, find and select your VM
5. Click the "Enable JIT on 1 VMs"
6. The access configuration blade will open and provide the Azure recommended settings.
7. Click "Save" to configure the settings
8. Once the settings are provisioned, navigate to the "Configured" tab
9. Click "Request Access"
10. From the "Request Access" blade, choose which ports you want to enable, and toggle them to "On". By choosing "My IP" as the Allowed Source IP, Azure will find your current Public IP and enable this as the allowed source.
11. Click "Enable Ports" at the bottom of the blade
12. Once enabled, JIT will configure Network Security Group rules that will only allow your Public IP to have access to the VM from the specified ports for duration of the time range