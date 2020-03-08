#This is a script to test if resource group is created using an ARM template
# deployment variables
{
#NOTE: Resource group deployment to 'Central India' fails
$location = "Southeast Asia"
$resourceGroupName = "testRg"
$resourceDeploymentName = "testRg-deployment"
$template = ".\Website.json"
$templateParameters = ".\WebSite.parameters.json"
}

# create resource group
{
New-AzureRmResourceGroup `
 -Name $resourceGroupName `
 -Location $location `
 -Verbose -Force
}

# validate template
{
Test-AzureRmResourceGroupDeployment `
  -ResourceGroupName $resourceGroupName `
  -TemplateFile $template `
  -TemplateParameterFile $templateParameters
}

# deploy resources using the temlate
{
New-AzureRmResourceGroupDeployment `
 -Name $resourceDeploymentName `
 -ResourceGroupName $resourceGroupName `
 -TemplateFile $template `
 -Verbose -Force
}

# delete the resource group
{
Remove-AzureRmResourceGroup -Name $resourceGroupName
}
