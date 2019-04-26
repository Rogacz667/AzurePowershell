# PREDICA TEST - DEPLOY
$resourceGroupName = "PredicaTest"
$location = "North Europe"
$containerRegistryName = "apiContainerRegistry01"
$dockerImageName = "apitask"
$dnsname = "predica-test-apitask"
$containerInstanceName = "api-task-container-instance"

Connect-AzureRmAccount
$resourceGroup = New-AzureRmResourceGroup -Name $resourceGroupName -Location $location
$registry = New-AzureRmContainerRegistry -ResourceGroupName $resourceGroup.ResourceGroupName -Name $containerRegistryName -Sku "Basic" -EnableAdminUser

$creds = Get-AzureRmContainerRegistryCredential -Registry $registry
docker login -u $creds.Username -p $creds.Password $registry.LoginServer

$imagepath = $registry.LoginServer + "/" + $dockerImageName
docker tag $dockerImageName $imagepath
docker push $imagepath

$secpasswd = ConvertTo-SecureString $creds.Password -AsPlainText -Force 
$pscred = New-Object System.Management.Automation.PSCredential($creds.Username, $secpasswd)

New-AzureRmContainerGroup -ResourceGroup $resourceGroup.ResourceGroupName -Name $containerInstanceName -Image $imagepath -RegistryCredential $pscred -Cpu 1 -MemoryInGB 1 -DnsNameLabel $dnsname -RestartPolicy Never -OsType Linux
