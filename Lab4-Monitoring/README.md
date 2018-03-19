Host Level Metrics
We are going to create our first Web Server VM using the Azure Portal.

Log into https://portal.azure.com with your credentials.
Click “All Services” in the top left corner, search for and click on “Monitor”
Under the “Shared Services” section, click on “Metrics”
A selection pane will show at the top to choose the following:
Subscription - a list of available subscriptions, choose the relevant subscription where your VM is located 
Resource Group - list of all resource groups within the subscription, choose the resource group your VM is located
Resource Type - list of resources available within the resource group, choose Virtual Machines
Resource - list of Virtual Machines within the resource group, choose your VM name
After selecting the parameters, the available host metrics will be shown on the left hand side in checkbox form
Choose “[Host] Percentage CPU”

Click the pin off on the right hand side.
Navigate back to the dashboard 




Create Log Analytics Workspace
Navigate to “Log Analytics” within the Azure portal
Click “+ Add” to create a new Log Analytics workspace
Specify the workspace name, subscription, Resource Group, and Location, then click Create to provision your new workspace

Once provisioned, navigate to your new Log Analytics workspace
We will first configure our Workspace by choosing “Advanced settings” under the “Settings” section
Under the “Data” tab, choose “Windows Performance Counters” and add the recommended Performance data by clicking the “Add the selected performance counters” button

Navigate to “Windows Event Logs”, from here you will be able to search for and configure your guest-level logs to be collected by your Log Analytics workspace
Type “System” into the search bar and click the “+” plus sign to add

Click “Save” at the top bar



Configure Data Source for Log Analytics
Navigate back to your Log Analytics workspace and find the “Workspace Data Sources” settings
Choose “Virtual Machines”
Click on your Virtual Machine
Another blade will open and you can click “Connect” to configure the OMS Agent on the selected VM

Once provisioned, the VM will show connected to your workspace


Log Analytics Queries
From the Log Analytics “OMS Workspace” click “Log Search”
Once the Log Search blade is open, Azure provides some information about the Log Analytics query language structure and a built-in query editor.

Copy or create a query in the editor window and then click the Magnifying Glass symbol to run the query.

Try out some of the following queries:

Number of “Error” events logged for each VM
		Event
| where (EventLevelName == "Error")
| where (TimeGenerated > ago(1days))
| summarize ErrorCount = count() by Computer
List of VMs with a heartbeat in the past hour
Heartbeat
| where TimeGenerated > ago(1d)
| summarize arg_max(TimeGenerated, *) by Computer
List of VMs with a specific Event ID 
Event
| where EventID == "7036"
| summarize count(EventID) by Computer

Percentage available disk space for a specified VM
Perf
| where TimeGenerated > ago(1h)
| where Computer == "VMNAME"
| where CounterName == "% Free Space"
| summarize min(CounterValue) by InstanceName


Chart of CPU utilization of all VMs in past day
Perf
| where TimeGenerated > ago(1d)
| where CounterName == @"% Processor Time"
| summarize avg(CounterValue) by Computer, bin(TimeGenerated, 15m) 
| render timechart






Configure Just in Time Access On a VM
Just in time VM Access is only available on Virtual Machines that have a Public IP and Network Security Group configured.
Navigate to “Security Center” within the Azure portal
Under the “Advanced Cloud Defense” section, click on “Just in time VM access”
You may need to enable enhanced security to test the feature
Under the “Recommended” tab, find and select your VM
Click the “Enable JIT on 1 VMs”

The access configuration blade will open and provide the Azure recommended settings.
Click “Save” to configure the settings

Once the settings are provisioned, navigate to the “Configured” tab

Click “Request Access”
From the “Request Access” blade, choose which ports you want to enable, and toggle them to “On”. By choosing “My IP” as the Allowed Source IP, Azure will find your current Public IP and enable this as the allowed source.
Click “Enable Ports” at the bottom of the blade

Once enabled, JIT will configure Network Security Group rules that will only allow your Public IP to have access to the VM from the specified ports for duration of the time range