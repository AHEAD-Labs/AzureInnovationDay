New-AzVM `
-ResourceGroupName "YOURRESOURCEGROUP" `
-Name "web-vm-2" `
-Location "LOCATION" `
-VirtualNetworkName "YOURVNET" `
-SubnetName "web" `
-AvailabilitySetName "YOURAVAILABILITYSETNAME"
