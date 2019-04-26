param(
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
     $resourceGroupName,
     [Parameter(Mandatory=$true)]
     [string[]]
     $resourceTypes
     )
    
     Connect-AzureRmAccount
     $resourceGroup = Get-AzureRmResourceGroup $resourceGroupName
     $resources=Get-AzureRmResource -ResourceGroupName $resourceGroup.ResourceGroupName
     
     foreach ($resourceType in $resourceTypes) {
        $resources = Get-AzureRmResource -ResourceType $resourceType  -ResourceGroupName $resourceGroupName
        foreach($resource in $resources){
            Remove-AzureRmResource -ResourceId $resource.ResourceId -Force
        }
     }