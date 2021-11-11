## Delete Your Resource Group

In this lab we will start by deleting our Resource Group and all the resources contained within.

1. Navigate to your Resource Group in the Azure portal
2. Click "Delete resource group" at the top of your Resource Group blade
3. A window will open warning you of the resources you are about to remove
4. Type the name of your Resource Group to confirm deletion and then click "Delete" at the bottom of the window

## Recreate your Resource Group and Resources

Deploy this ARM Template to your Azure environment:

Click +Create a Resource
In the search box type "template" and select "Template Deployment"
Click Create
Click "Build your own template in the editor"
Delete everything in the editor, and then paste in the complete contents found at the following link:

[https://github.com/AHEAD-Labs/AzureInnovationDay/blob/master/Lab5-Automation/Recreate-Environment/azuredeploy.json](https://github.com/AHEAD-Labs/AzureInnovationDay/blob/master/Lab5-Automation/Recreate-Environment/azuredeploy.json)

Once saved: you will be prompted with the following parameters. Either keep the parameters as they are or populate accordingly. 
![image](https://user-images.githubusercontent.com/26149753/141372989-cbdc86fa-3d97-478a-b54b-4999d038a444.png)
